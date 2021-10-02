;; Keep config directory clean
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))


;; Straight.el bootstrap for package management
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-disable-native-compile nil)

(use-package f :straight t)

;; Config management functions
(defconst pg/config-dir (expand-file-name "~/.emacs.profiles.d/purplg/"))
(defconst pg/module-dir (expand-file-name "modules/" pg/config-dir))

(defun pg/load-module (module-name)
  "Load a module file located in the `pg/module-dir' directory."
  (load (expand-file-name module-name pg/module-dir)))

;; Configuration modules
(setq pg/modules
  '("basics"
    "keybinds"
    "interface"
    "editing"
    "apps"))

;; Load exwm if `--exwm' switch is passed
(add-to-list 'command-switch-alist
             '("--exwm" . (lambda (_) (add-to-list 'pg/modules "exwm" t))))

;; Load system-specific modules
(cond ((string= "framework" (system-name))
       (add-to-list 'pg/modules "framework" t))
      ((string= "desktop" (system-name))
       (add-to-list 'pg/modules "desktop" t)))

;; Do the loading
(dolist (module pg/modules) 
 (pg/load-module module))

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
(defconst pg/config-dir "~/.emacs.profiles.d/purplg/")

(defun pg/config-file (filename)
  "The full path of a file in the `pg/config-dir' directory if it exists"
  (unless (string-empty-p filename)
    (let ((filepath (expand-file-name filename pg/config-dir)))
      (when (file-exists-p filepath) filepath))))

(defconst pg/module-dir (pg/config-file "modules/"))

(defun pg/load-module (module-name)
  "Load a module file located in the `pg/module-dir' directory."
  (let ((module-path (expand-file-name module-name pg/module-dir)))
    (cond ((f-exists? (concat module-path ".org"))
           (org-babel-load-file (concat module-path ".org")))
          ((f-exists? (concat module-path ".el"))
           (load-file (concat module-path ".el")))
          ((message "module `%s' doesn't exist" module-name)))))


;; Load the config modules
(pg/load-module "basics")
(pg/load-module "keybinds")
(pg/load-module "interface")
(pg/load-module "editing")
(pg/load-module "apps")

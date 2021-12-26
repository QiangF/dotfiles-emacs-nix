(setq byte-compile-warnings nil)
(setq native-comp-async-report-warnings-errors nil)

;;; * Config config
(defconst pg/config-dir (file-truename (expand-file-name user-emacs-directory)))
(defconst pg/module-dir (expand-file-name "modules" pg/config-dir))
(add-to-list 'load-path pg/module-dir)

; Keep config directory clean
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/"))
(setq url-history-file (expand-file-name "url/history" user-emacs-directory))

(defun pg/open-module (module-name)
  "Open a configuration module."
  (interactive 
    (list (completing-read "Module: "
            (mapcar #'file-name-base
                    (directory-files-recursively pg/module-dir ".el$" nil))
            nil t)))

  (let ((matches (seq-filter
                  (lambda (file) (string-match (concat module-name ".el$") file))
                  (directory-files-recursively pg/module-dir ".el$" nil))))
    (if (= 1 (length matches))
        (find-file (car matches))
        (user-error "module not found: %s" module-name))))

;; If in the Emacs config directory, automatically byte compile files on save
(add-hook 'emacs-lisp-mode-hook
  (lambda ()
    (when (and (buffer-file-name)
               (string-match (file-truename pg/module-dir)
                             (buffer-file-name)))
      (add-hook
       'after-save-hook
       (lambda () (byte-compile-file (buffer-file-name)))
       0 t))))

;;; * Straight.el bootstrap
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

;;; * Emacs config
(require 'pg-perf)
(require 'pg-keybinds)
(require 'pg-interface)
(require 'pg-editing)
(require 'pg-apps)
(require 'pg-system-specific)

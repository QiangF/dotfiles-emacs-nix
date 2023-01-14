;;; --- -*- lexical-binding: t; -*-
(setq byte-compile-warnings nil)
(setq native-comp-async-report-warnings-errors nil)

;; * Config config
(defconst pg/config-dir (file-truename (expand-file-name user-emacs-directory)))
(defconst pg/module-dir (expand-file-name "modules" pg/config-dir))
(add-to-list 'load-path pg/module-dir)
(require 'pg-perf)

(setq custom-file (expand-file-name "custom.el" pg/config-dir))
(when (file-exists-p custom-file)
  (load custom-file))

;; Keep config directory clean
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

;; * Straight.el bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq use-package-always-defer nil)
(setq straight-disable-native-compile nil)

;; * Emacs config
(require 'pg-keybinds)
(require 'pg-interface)
(require 'pg-editing)
(require 'pg-apps)
(require 'pg-system-specific)
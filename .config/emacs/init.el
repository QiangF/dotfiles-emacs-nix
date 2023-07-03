;;; --- -*- lexical-binding: t; -*-
(setq byte-compile-warnings nil)
(setq native-comp-async-report-warnings-errors nil)

;; * Config config
(defconst pg/config-dir (file-truename (expand-file-name user-emacs-directory)))
(defconst pg/module-dir (expand-file-name "modules" pg/config-dir))
(add-to-list 'load-path pg/module-dir)

;; Keep config directory clean
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/"))
(setq custom-file (expand-file-name "custom.el" pg/config-dir))
(when (file-exists-p custom-file) (load custom-file))
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

(load-file (file-name-concat pg/config-dir "modules.el"))

;; Try to load system-specific modules (hostname)
(pg/try-load-file (file-name-concat "system/"
                                    (file-name-with-extension (system-name) ".el")))

;; local.el is an untracked / .gitignored file. Load it if it exists
(pg/try-load-file "local.el")

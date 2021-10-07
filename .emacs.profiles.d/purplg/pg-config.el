;;; --- -*- lexical-binding: t; -*-

;; Configuration management

(defconst pg/config-dir (expand-file-name user-emacs-directory))
(defconst pg/module-dir (expand-file-name "modules/" pg/config-dir))
(add-to-list 'load-path pg/module-dir)

;; Keep config directory clean
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))

;; What warnings/errors to show when compiling elisp files.
(setq byte-compile-warnings t)

(defun pg/compile-modules ()
  "Compile all modules in config directory."
  (interactive)
  (dolist (file (directory-files-recursively pg/module-dir ".el$" nil))
    (message "comp: %s" file)
    (byte-compile-file file)))

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

(provide 'pg-config)

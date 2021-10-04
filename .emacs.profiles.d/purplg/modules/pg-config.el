;; Configuration management

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
            (mapcar
              (lambda (file)
                (file-name-base file))
              (directory-files-recursively pg/module-dir ".el$" nil)) nil t)))

  (let ((matches (seq-filter
                  (lambda (file) (string-match (concat module-name ".el$") file))
                  (directory-files-recursively pg/module-dir ".el$" nil))))
    (if (= 1 (length matches))
        (find-file (car matches))
        (message "module not found: %s" module-name))))

;; Byte compile the file on every save
(add-hook 'after-save-hook (lambda () (byte-compile-file (buffer-file-name))))

(provide 'pg-config)

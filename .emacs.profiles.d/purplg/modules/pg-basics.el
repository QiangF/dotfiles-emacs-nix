(require 'pg-straight)

(defalias 'after! 'with-eval-after-load)

(setq native-comp-async-report-warnings-errors nil)
(setq ring-bell-function 'ignore)
(setq scroll-conservatively 101)

(defun pg/compile-modules ()
  (interactive)
  (dolist (file (directory-files-recursively pg/module-dir ".el$" nil))
    (message "comp: %s" file)
    (byte-compile-file file)))

(defun pg/open-module (module-name)
  (interactive 
    (list (completing-read "Module: "
            (mapcar
              (lambda (file)
                (file-name-base file))
              (directory-files-recursively pg/module-dir ".el$" nil)) nil t)))

  (let ((matches (-filter
                  (lambda (file) (string-match (concat module-name ".el$") file))
                  (directory-files-recursively pg/module-dir ".el$" nil))))
    (if (= 1 (length matches))
        (find-file (car matches))
        (message "module not found: %s" module-name))))

(provide 'pg-basics)

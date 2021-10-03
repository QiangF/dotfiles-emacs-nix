(require 'pg-straight)

;; Copy my user enviroment settings into Emacs. Necessary for some things like using Rust Cargo crates
(when (daemonp)
  (use-package exec-path-from-shell
    :straight t
    :init
    (exec-path-from-shell-initialize)))

(defalias 'after! 'with-eval-after-load)

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

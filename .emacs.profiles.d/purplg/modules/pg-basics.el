(require 'pg-straight)

(set-face-attribute 'default nil :font "Fira Code Retina-10")
(add-to-list 'default-frame-alist '(font . "Fira Code Retina-10"))

;; Copy my user enviroment settings into Emacs. Necessary for some things like using Rust Cargo crates
(when (daemonp)
  (use-package exec-path-from-shell
    :straight t
    :init
    (exec-path-from-shell-initialize)))


;; Silence compiler warnings
(setq native-comp-async-report-warnings-errors nil)

(defalias 'after! 'with-eval-after-load)

(setq frame-title-format "PurplEmacs")

(setq ring-bell-function 'ignore)

(setq scroll-conservatively 101)

(defun pg/compile-modules ()
  (interactive)
  (let ((files (directory-files pg/module-dir t ".el$")))
    (dolist (file files)
      (byte-compile-file file))))

(provide 'pg-basics)

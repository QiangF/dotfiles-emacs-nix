;;; --- -*- lexical-binding: t; -*-
(require 'pg-environment)
(require 'pg-keybinds)
(require 'pg-treesitter)

(let ((python-modes '(python-mode))
      (python-hooks '(python-mode-hook)))

  (when (pg/native-treesitter-p)
    (add-to-list 'python-modes 'python-ts-mode)
    (add-to-list 'python-hooks 'python-ts-mode-hook))

  (with-eval-after-load 'corfu
    (dolist (hook python-hooks)
      (add-hook hook #'corfu-mode)))

  ;; this version of tree-sitter is only used when native treesit is not
  ;; available
  (with-eval-after-load 'tree-sitter
    (add-hook 'python-mode-hook #'tree-sitter-mode))

  (with-eval-after-load 'eglot
    (dolist (mode python-modes)
      (add-to-list 'eglot-server-programs `(,mode . ("jedi-language-server"))))

    (dolist (hook python-hooks)
      (add-hook hook #'eglot-ensure)))

  (with-eval-after-load 'lsp-mode
    (dolist (hook python-hooks)
      (add-hook hook #'lsp)))

  (advice-add #'run-python :around
              (lambda (fn &rest args)
                (let ((default-directory (or (project-root (project-current))
                                             default-directory)))
                  (apply fn args)))))

(with-eval-after-load 'ob-core
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t))))

(provide 'pg-python)

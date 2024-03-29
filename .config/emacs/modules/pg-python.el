;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)
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
                (let ((default-directory (or (ignore-error (project-root (project-current)))
                                             default-directory)))
                  (apply fn args)))))

(use-package apheleia
  :after python
  :init
  (add-hook 'python-base-mode-hook #'apheleia-mode))

(use-package flycheck-mypy
  :init
  (add-hook 'python-base-mode-hook #'flycheck-mode))

(use-package pet)

(provide 'pg-python)

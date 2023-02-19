;;; --- -*- lexical-binding: t; -*-

(use-package unity
  :straight '(:type git :host github :repo "elizagamedev/unity.el")
  :hook (after-init-hook . unity-mode))

(dolist (hook '(csharp-mode-hook csharp-ts-mode-hook))
  (with-eval-after-load 'lsp-mode
    (add-hook hook #'lsp))

  (with-eval-after-load 'eglot
    (add-hook hook #'eglot-ensure))

  (with-eval-after-load 'corfu
    (add-hook hook #'corfu-mode)))

(provide 'pg-csharp)

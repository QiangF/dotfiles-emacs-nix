;;; --- -*- lexical-binding: t; -*-

(use-package unity
  :straight '(:type git :host github :repo "elizagamedev/unity.el")
  :hook (after-init-hook . unity-mode))

(with-eval-after-load 'lsp-mode
  (add-hook 'csharp-mode-hook #'lsp)
  (add-hook 'csharp-ts-mode-hook #'lsp))

(provide 'pg-csharp)

;;; --- -*- lexical-binding: t; -*-

(use-package unity
  :straight '(:type git :host github :repo "elizagamedev/unity.el")
  :hook (after-init-hook . unity-mode))

(with-eval-after-load 'lsp-mode
  (add-hook 'csharp-mode-hook #'lsp)
  (add-hook 'csharp-ts-mode-hook #'lsp))

(with-eval-after-load 'eglot
  (add-hook 'csharp-mode-hook #'eglot-ensure)
  (add-hook 'csharp-ts-hook #'eglot-ensure))

(with-eval-after-load 'corfu
  (add-hook 'csharp-mode-hook #'corfu-mode)
  (add-hook 'csharp-ts-mode-hook #'corfu-mode))

(provide 'pg-csharp)

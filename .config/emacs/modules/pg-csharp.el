;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package unity
  :elpaca (:type git :host github :repo "elizagamedev/unity.el")
  :hook (after-init-hook . unity-mode))

(let ((modes '(csharp-mode csharp-ts-mode))
      (hooks '(csharp-mode-hook csharp-ts-mode-hook)))

  (with-eval-after-load 'lsp-mode
    (dolist (hook hooks)
      (add-hook hook #'lsp)))

  (with-eval-after-load 'eglot
    (dolist (hook hooks)
      (add-hook hook #'eglot-ensure))
    (dolist (mode modes)
      (setf (alist-get mode eglot-server-programs) '("OmniSharp" "-lsp"))))

  (with-eval-after-load 'corfu
    (dolist (hook hooks)
      (add-hook hook #'corfu-mode))))

(provide 'pg-csharp)

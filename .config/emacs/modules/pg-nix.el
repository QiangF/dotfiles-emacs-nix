;;; --- -*- lexical-binding: t; -*-

(use-package nix-mode
  :hook (nix-mode . eglot-ensure)
  :init
  (with-eval-after-load 'lsp-mode
    (add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection '("rnix-lsp"))
                      :major-modes '(nix-mode)
                      :server-id 'nix))
    (add-hook 'nix-mode-hook #'lsp))
  (with-eval-after-load 'eglot
    (when (executable-find "nil")
        (add-to-list 'eglot-server-programs '(nix-mode . ("nil")))))
  (add-hook 'nix-mode-hook #'corfu-mode))


(provide 'pg-nix)

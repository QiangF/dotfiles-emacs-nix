;;; --- -*- lexical-binding: t; -*-

(use-package nix-mode
  :straight t
  :init
  (with-eval-after-load 'lsp-mode
    (add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection '("rnix-lsp"))
                      :major-modes '(nix-mode)
                      :server-id 'nix)))
  (add-hook 'nix-mode-hook #'lsp)
  (add-hook 'nix-mode-hook #'corfu-mode))


(provide 'pg-nix)

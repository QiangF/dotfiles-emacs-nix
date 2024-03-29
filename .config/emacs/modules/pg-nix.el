;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package nix-mode
  :hook (nix-mode . eglot-ensure)
        (nix-mode . corfu-mode)
  :config
  (with-eval-after-load 'lsp-mode
    (add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection '("rnix-lsp"))
                      :major-modes '(nix-mode)
                      :server-id 'nix))
    (add-hook 'nix-mode-hook #'lsp))

  (with-eval-after-load 'eglot
    (when (executable-find "nil")
        (add-to-list 'eglot-server-programs '(nix-mode . ("nil"))))
    (when (executable-find "rnix-lsp")
        (add-to-list 'eglot-server-programs '(nix-mode . ("rnix-lsp"))))))

(use-package nixpkgs-fmt
  :after nix-mode
  :config
  (evil-define-key* 'normal nix-mode-map
    (kbd "<leader> m f") #'(nixpkgs-fmt-buffer :wk "format buffer")))

(provide 'pg-nix)

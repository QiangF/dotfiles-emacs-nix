;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)
(require 'pg-treesitter)

(use-package rustic
  :config
  (setq rustic-format-on-save nil)
  (setq rustic-lsp-format nil)

  (defun rustic-cargo-run-no-args () 
    (interactive)
    (rustic-run-cargo-command "cargo run"))

  (pg/local-leader
   :keymaps '(rustic-mode-map rustic-compilation-mode-map)
   "r" #'(rustic-cargo-run-no-args :wk "run")
   "R" #'(rustic-cargo-run :wk "run w/ args")
   "a" #'(rustic-cargo-add :wk "add dep")
   "x" #'(rustic-cargo-rm :wk "rm dep")
   "c" #'(rustic-cargo-check :wk "check")
   "t" #'(rustic-cargo-test :wk "test")))

(use-package rustic :after corfu :config (add-hook 'rustic-mode-hook #'corfu-mode))
(use-package rustic :after electric :config (add-hook 'rustic-mode-hook #'electric-indent-mode))
(use-package rustic :after tree-sitter :config (add-hook 'rustic-mode-hook #'tree-sitter-mode))

(use-package rustic :after eglot
  :config
  (setq rustic-lsp-client 'eglot)
  (setq eglot-ignored-server-capabilities nil)

  (pg/local-leader
   :keymaps 'eglot-mode-map
   "f" #'(eglot-format :wk "format")))

(provide 'pg-rust)

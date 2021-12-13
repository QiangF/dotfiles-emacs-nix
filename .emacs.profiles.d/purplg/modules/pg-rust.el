;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)
(require 'pg-treesitter)

(use-package rustic
  :config
  (setq rustic-format-on-save nil
        rustic-lsp-format nil)

  (defun rustic-cargo-run-no-args () 
    (interactive)
    (rustic-run-cargo-command "cargo run"))
    
  (hook! 'rustic-mode-hook #'(electric-indent-mode tree-sitter-mode company-mode))

  (pg/local-leader
   :keymaps 'rustic-mode-map
   "r" #'(rustic-cargo-run-no-args :wk "run")
   "R" #'(rustic-cargo-run :wk "run w/ args")
   "a" #'(rustic-cargo-add :wk "add dep")
   "x" #'(rustic-cargo-rm :wk "rm dep")
   "c" #'(rustic-cargo-check :wk "check")
   "t" #'(rustic-cargo-test :wk "test")))

(use-package rustic
  :after eglot
  :config
  (setq rustic-lsp-client 'eglot)
  (setq eglot-ignored-server-capabilities nil)

  (pg/leader
   :keymaps 'eglot-mode-map
   :states '(normal visual)
   "c f" #'(eglot-format :wk "format")))

(provide 'pg-rust)

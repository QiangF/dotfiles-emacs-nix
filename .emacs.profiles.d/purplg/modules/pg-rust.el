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
   "c" '(:wk "cargo")
   "c r" #'(rustic-cargo-run-no-args :wk "run")
   "c R" #'(rustic-cargo-run :wk "run w/ args")
   "c a" #'(rustic-cargo-add :wk "add dep")
   "c x" #'(rustic-cargo-rm :wk "rm dep")
   "c c" #'(rustic-cargo-check :wk "check")
   "c t" #'(rustic-cargo-test :wk "test")))

(use-package rustic
  :after eglot
  :config
  (setq rustic-lsp-client 'eglot)

  (pg/leader
   :keymaps 'eglot-mode-map
   "c f" #'(rustic-format-file :wk "format")))

(provide 'pg-rust)

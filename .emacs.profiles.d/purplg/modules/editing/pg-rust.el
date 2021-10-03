(require 'pg-straight)
(require 'pg-keybinds)
(require 'pg-treesitter)

(use-package rustic
  :straight t
  :config
  (setq rustic-format-on-save nil
        rustic-lsp-format nil)

  (defun rustic-cargo-run-no-args () 
    (interactive)
    (rustic-run-cargo-command "cargo run"))
    
  (hook! 'rustic-mode-hook #'electric-indent-mode)
  (hook! 'rustic-mode-hook #'tree-sitter-mode)

  (pg/local-leader
    :keymaps 'rustic-mode-map
    "c" '(:which-key "cargo")
    "c r" #'(rustic-cargo-run-no-args :which-key "run")
    "c R" #'(rustic-cargo-run :which-key "run w/ args")
    "c a" #'(rustic-cargo-add :which-key "add dep")
    "c x" #'(rustic-cargo-rm :which-key "rm dep")
    "c c" #'(rustic-cargo-check :which-key "check")
    "c t" #'(rustic-cargo-test :which-key "test")))

(provide 'pg-rust)

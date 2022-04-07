;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)
(require 'pg-treesitter)

(use-package rustic
  :straight t
  :init
  (with-eval-after-load 'corfu
    (add-hook 'rustic-mode-hook #'corfu-mode))

  (with-eval-after-load 'electric
    (add-hook 'rustic-mode-hook #'electric-indent-mode))

  (with-eval-after-load 'tree-sitter
    (add-hook 'rustic-mode-hook #'tree-sitter-mode))

  (with-eval-after-load 'eglot
    (setq rustic-lsp-client 'eglot)
    (setq eglot-ignored-server-capabilities nil))

  :config
  (pg/local-leader
     :keymaps 'eglot-mode-map
     "f" #'(eglot-format :wk "format"))

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

(provide 'pg-rust)

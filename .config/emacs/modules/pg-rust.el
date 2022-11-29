;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)
(require 'pg-treesitter)

(use-package rustic
  :straight t
  :mode ("\\.rs\\'" . rustic-mode)
  :init
  (with-eval-after-load 'corfu
    (add-hook 'rustic-mode-hook #'corfu-mode))

  (with-eval-after-load 'electric
    (add-hook 'rustic-mode-hook #'electric-indent-mode))

  (with-eval-after-load 'tree-sitter
    (add-hook 'rustic-mode-hook #'tree-sitter-mode))

  (with-eval-after-load 'flymake
    (add-hook 'rustic-mode-hook #'(lambda () (flymake-mode -1))))

  (with-eval-after-load 'eglot
    (setq rustic-lsp-client 'eglot)
    (setq eglot-ignored-server-capabilities nil))

  (with-eval-after-load 'hideshow
    (add-hook 'rustic-mode-hook
              (lambda ()
                (with-current-buffer (buffer-name)
                  (when (> (count-lines (point-min) (point-max) 100))
                    (hs-hide-level 2))))))

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
    "f" #'(rustic-format-buffer :wk "format")
    "c" #'(rustic-cargo-check :wk "check")
    "t" #'(rustic-cargo-test :wk "test")))

(provide 'pg-rust)

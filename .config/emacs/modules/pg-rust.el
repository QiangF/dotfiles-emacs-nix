;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)
(require 'pg-keybinds)
(require 'pg-treesitter)

(use-package rustic
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

  :config
  (dolist (keymap '(rustic-mode-map rustic-compilation-mode-map))
    (evil-define-key* 'normal keymap
      (kbd "<leader> m r") #'("run" . rustic-cargo-run-no-args)
      (kbd "<leader> m R") #'("run w/ args" . rustic-cargo-run)
      (kbd "<leader> m a") #'("add dep" . rustic-cargo-add)
      (kbd "<leader> m x") #'("rm dep" . rustic-cargo-rm)
      (kbd "<leader> m f") #'("format" . rustic-format-buffer)
      (kbd "<leader> m c") #'("check" . rustic-cargo-check)
      (kbd "<leader> m t") #'("test" . rustic-cargo-test)))
  )

(provide 'pg-rust)

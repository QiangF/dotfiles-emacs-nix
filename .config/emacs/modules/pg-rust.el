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

  :config
  (with-eval-after-load 'popper
    (add-to-list 'popper-reference-buffers "^\\*rustfmt\\*$")
    (add-to-list 'popper-reference-buffers 'rustic-compilation-mode)
    (add-to-list 'popper-reference-buffers 'rustic-cargo-run-mode)
    (add-to-list 'popper-reference-buffers 'rustic-format-mode)
    (add-to-list 'popper-reference-buffers 'rustic-cargo-fmt-mode)
    (when popper-mode
      (popper-mode 1)))

  (evil-define-key* 'normal rustic-mode-map
    (kbd "<leader> m r") #'("run" . rustic-cargo-run)
    (kbd "<leader> m R") #'("run w/ args" . rustic-cargo-run)
    (kbd "<leader> m a") #'("add dep" . rustic-cargo-add)
    (kbd "<leader> m x") #'("rm dep" . rustic-cargo-rm)
    (kbd "<leader> m f") #'("format" . rustic-format-buffer)
    (kbd "<leader> m c") #'("check" . rustic-cargo-check)
    (kbd "<leader> m t") #'("test" . rustic-cargo-test))

  ;; Override the rustic-process-kill-p function so it always kills a running process
  (with-eval-after-load 'rustic-compile
    (defun rustic-process-kill-p (proc &optional no-error)
      "Don't allow two rust processes at once.

If NO-ERROR is t, don't throw error if user chooses not to kill running process."
      (condition-case ()
          (progn
            (interrupt-process proc)
            (sit-for 0.5)
            (delete-process proc))
        (error nil)))))

(provide 'pg-rust)

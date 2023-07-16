;;; --- -*- lexical-binding: t; -*-

(use-package golden-ratio
  :init
  (golden-ratio-mode)
  :config
  (setopt golden-ratio-auto-scale t)

  ;; https://github.com/roman/golden-ratio.el/issues/41
  (setq golden-ratio-extra-commands
        (append golden-ratio-extra-commands
                '(evil-window-left
                  evil-window-right
                  evil-window-up
                  evil-window-down
                  buf-move-left
                  buf-move-right
                  buf-move-up
                  buf-move-down
                  window-number-select
                  select-window
                  select-window-1
                  select-window-2
                  select-window-3
                  select-window-4
                  select-window-5
                  select-window-6
                  select-window-7
                  select-window-8
                  select-window-9))))

(provide 'pg-golden-ratio)

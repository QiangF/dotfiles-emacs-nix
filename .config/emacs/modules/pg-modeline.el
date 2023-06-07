;;; --- -*- lexical-binding: t; -*-

(use-package doom-modeline
  :disabled
  :init
  (doom-modeline-mode 1))

(use-package mood-line
  :config
  (setopt mood-line-show-cursor-point t)
  (setopt mood-line-show-encoding-information t)
  (setopt mood-line-show-eol-style t)
  (setopt mood-line-show-indentation-style t)
  (setopt mood-line-show-major-mode t)
  (mood-line-mode))

(provide 'pg-modeline)

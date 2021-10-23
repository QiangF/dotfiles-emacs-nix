;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)

(use-package doom-themes
  :straight t
  :config
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)

  (load-theme 'doom-dracula t))

(provide 'pg-theme)

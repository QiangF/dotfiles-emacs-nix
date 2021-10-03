(require 'pg-straight)

(hook! 'prog-mode-hook #'hl-line-mode)

;; Hide extraneous stuff on the main Emacs frame
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)

(use-package doom-themes
  :straight t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)

  (load-theme 'doom-dracula t))

(use-package page-break-lines
  :defer t
  :straight t
  :config
  (global-page-break-lines-mode))

(provide 'pg-appearance)

;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package dashboard
  :init
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice #'dashboard-open)
  (setq dashboard-projects-backend 'project-el)
  ;; (setq dashboard-banners-directory (expand-file-name "banners/" pg/config-dir))
  (setq dashboard-startup-banner 2)
  (setq dashboard-filter-agenda-entry #'dashboard-filter-agenda-by-todo)
  (setq dashboard-agenda-release-buffers t)

  (setq dashboard-items '((projects . 5)
                          (recents . 10)
                          (agenda . 15)
                          (bookmarks . 5)))
  :config
  (add-hook 'dashboard-after-initialize-hook
    (lambda ()
      (with-current-buffer "*dashboard*" (emacs-lock-mode 'kill))))

  (add-hook 'dashboard-mode-hook
            (lambda ()
              (setq visual-fill-column-width 150)
              (setq visual-fill-column-center-text t)
              (setq visual-fill-column-fringes-outside-margins nil)
              (visual-fill-column-mode)))

  (defun dashboard-switch ()
    "Switch to dashboard buffer"
    (interactive)
    (switch-to-buffer dashboard-buffer-name))
  
  (evil-define-key* 'normal 'global
   (kbd "<leader> o d") #'("dashboard" . dashboard-switch))

  (evil-define-key 'normal dashboard-mode-map
   (kbd "q") nil))

(provide 'pg-dashboard)

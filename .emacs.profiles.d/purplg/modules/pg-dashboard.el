;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(eval-after-load 'org
  (setq initial-buffer-choice
        (lambda ()
         (find-file (expand-file-name "PC.org" org-directory)))))

(use-package dashboard
  :disabled
  :straight t
  :init
  (dashboard-setup-startup-hook)

  :config
  (add-hook 'dashboard-after-initialize-hook
    (lambda ()
      (with-current-buffer "*dashboard*" (emacs-lock-mode 'kill))))

  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (setq dashboard-projects-backend 'project-el)
  (setq dashboard-banners-directory (expand-file-name "banners/" pg/config-dir))
  (setq dashboard-startup-banner (+ 1 (random 3)))
  (setq dashboard-filter-agenda-entry #'dashboard-filter-agenda-by-todo)
  (setq dashboard-footer-messages nil)
  (setq dashboard-agenda-release-buffers t)
  (setq dashboard-items '((projects . 5)
                          (recents . 10)
                          (agenda . 15)
                          (bookmarks . 5)))
  (defun dashboard-switch ()
    "Switch to dashboard buffer"
    (interactive)
    (switch-to-buffer dashboard-buffer-name))
  
  (pg/leader
   "o d" #'(dashboard-switch :wk "dashboard"))

  :general
  (:states 'normal
   :keymaps 'dashboard-mode-map
   "q" nil))

(provide 'pg-dashboard)

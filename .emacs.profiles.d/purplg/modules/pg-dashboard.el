;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)
(require 'pg-keybinds)

(use-package dashboard
  :straight t
  :config
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (setq dashboard-banners-directory (expand-file-name "banners/" pg/config-dir))
  (setq dashboard-startup-banner (+ 1 (random 3)))
  (setq dashboard-filter-agenda-entry #'dashboard-filter-agenda-by-todo)
  (setq dashboard-footer-messages nil)
  (setq dashboard-items '((projects . 5)
                          (recents . 10)
                          (agenda . 15)))

  (dashboard-setup-startup-hook)

  (hook! 'dashboard-after-initialize-hook
         #'(lambda ()
             (with-current-buffer "*dashboard*" (emacs-lock-mode 'kill))))

  (defun dashboard-refresh-buffer-silent ()
    "Refresh buffer in background."
    (interactive)
    (let ((dashboard-force-refresh t)) (dashboard-insert-startupify-lists)))
  
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

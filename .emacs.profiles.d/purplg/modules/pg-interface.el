;;; --- -*- lexical-binding: t; -*-

;; Don't show startup page
(setq inhibit-startup-message t)

(recentf-mode 1)

;; Fix scrolling so that it doesn't jump by pages
(setq scroll-conservatively 101)

(setq compilation-scroll-output t)

(add-to-list 'recentf-exclude (concat user-emacs-directory "bookmarks") t)

;; Highlight line of point
(add-hook 'prog-mode-hook #'hl-line-mode)

;; Scroll message buffer to bottom on update
(add-hook 'post-command-hook
  (lambda ()
    (let ((messages-buffer (get-buffer "*Messages*")))
      (unless (eq (current-buffer) messages-buffer)
        (with-current-buffer messages-buffer
          (goto-char (point-max)))))))

;; Prevent the scratch buffer from being deleted
(with-current-buffer "*scratch*" (emacs-lock-mode 'kill))

(defun pg/config-frame ()
  (when window-system 
    (setq frame-title-format "PurplEmacs")
    (scroll-bar-mode -1)
    (tool-bar-mode -1)
    (menu-bar-mode -1)
    (set-fringe-mode 10)))

(pg/config-frame)
(add-hook 'server-after-make-frame-hook #'pg/config-frame)

(use-package hl-todo
  :straight t
  :init
  (add-hook 'prog-mode-hook #'hl-todo-mode))

(require 'pg-completion)
(require 'pg-dashboard)
(require 'pg-embark)
(require 'pg-font)
(require 'pg-help)
(require 'pg-indent-guides)
(require 'pg-line-numbers)
(require 'pg-modeline)
(require 'pg-popper)
(require 'pg-theme)
(require 'pg-workspaces)
(require 'pg-visual-page-breaks)

(provide 'pg-interface)

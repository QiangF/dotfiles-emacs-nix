;;; --- -*- lexical-binding: t; -*-

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

(require 'pg-modeline)
(require 'pg-completion)
(require 'pg-embark)
(require 'pg-dashboard)
(require 'pg-help)
(require 'pg-font)
(require 'pg-frame)
(require 'pg-theme)
(require 'pg-visual-page-breaks)
(require 'pg-workspaces)
(require 'pg-popper)

(provide 'pg-interface)

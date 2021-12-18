;;; --- -*- lexical-binding: t; -*-

(require 'pg-modeline)
(require 'pg-completion)
(require 'pg-embark)
(require 'pg-dashboard)
(require 'pg-help)
(require 'pg-frame)
(require 'pg-theme)
(require 'pg-visual-page-breaks)
(require 'pg-workspaces)
(require 'pg-popper)

(add-to-list 'recentf-exclude (concat user-emacs-directory "bookmarks") t)

;; Highlight line of point
(hook! 'prog-mode-hook #'hl-line-mode)

;; Scroll message buffer to bottom on update
(hook! 'post-command-hook
  (lambda ()
    (let ((messages-buffer (get-buffer "*Messages*")))
      (unless (eq (current-buffer) messages-buffer)
        (with-current-buffer messages-buffer
          (goto-char (point-max)))))))

;; Prevent the scratch buffer from being deleted
(with-current-buffer "*scratch*" (emacs-lock-mode 'kill))

(provide 'pg-interface)

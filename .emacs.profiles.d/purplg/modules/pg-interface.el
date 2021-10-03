(add-to-list 'load-path (expand-file-name "interface/" pg/module-dir))

(require 'pg-completion)
(require 'pg-dashboard)
(require 'pg-frame)
(require 'pg-theme)
(require 'pg-visual-page-breaks)
(require 'pg-workspaces)

;; Highlight line of point
(hook! 'prog-mode-hook #'hl-line-mode)

;; Scroll message buffer to bottom on update
(hook! 'post-command-hook
  (lambda ()
    (let ((messages (get-buffer "*Messages*")))
      (unless (eq (current-buffer) messages)
        (with-current-buffer messages
          (goto-char (point-max)))))))

;; Prevent the scratch buffer from being deleted
(with-current-buffer "*scratch*" (emacs-lock-mode 'kill))

(provide 'pg-interface)

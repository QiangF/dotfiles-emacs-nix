;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package tramp
  :after evil
  :elpaca nil
  :config
  (setq tramp-default-method "sshx")

  (setq pg/tramp-hosts-file "~/.emacs-tramp-hosts.el")

  (defun pg/tramp-hosts ()
    (when (file-exists-p pg/tramp-hosts-file)
      (with-temp-buffer
        (insert-file-contents pg/tramp-hosts-file)
        (goto-char (point-min))
        (read (current-buffer)))))

  (defun find-remote-file (host)
    (interactive
     (list (let ((tramp-hosts (pg/tramp-hosts)))
            (unless tramp-hosts (user-error "No tramp hosts configured."))
            (let* ((host (completing-read "Remote host:" tramp-hosts nil t))
                   (path (cdr (assoc-string host tramp-hosts))))
              (read-file-name "Find remote file:" (format "/%s:" path))))))
    (find-file host))

  (evil-define-key* 'normal 'global
   (kbd "<leader> f R") #'(find-remote-file :wk "remote file")))

(provide 'pg-tramp)

;;; --- -*- lexical-binding: t; -*-

(set-font-face "Fira Code Retina-10")

(use-package tramp
  :config
  (setq tramp-default-method "sshx")
  (setq tramp-default-host-alist '((home0)))

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
              (read-file-name "Find remote file:" (format "/%s:%s:" tramp-default-method path))))))
    (find-file host)))

(require 'pg-hass)

(provide 'pg-desktop)

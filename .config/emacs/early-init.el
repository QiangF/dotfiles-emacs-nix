(setq package-enable-at-startup nil)

(when (file-exists-p "~/.org")
  (setq org-directory "~/.org"))

(when (expand-file-name "PC.org" org-directory)
  (setq initial-buffer-choice
        (lambda ()
          (let ((buffer (find-file (expand-file-name "PC.org" org-directory))))
            (with-current-buffer buffer (auto-revert-mode 1))
            buffer))))

;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package puni
  :hook (prog-mode . puni-mode)
  :init
  (defun pg/puni-change-line ()
    (interactive)
    (puni-kill-line)
    (evil-insert 0))

  (evil-define-key* 'normal puni-mode-map
    (kbd "C") #'pg/puni-change-line
    (kbd "D") #'puni-kill-line
    (kbd "M-h") #'puni-barf-forward
    (kbd "M-l") #'puni-slurp-forward
    (kbd "M-d") #'puni-kill-line))

(provide 'pg-structured-editing)

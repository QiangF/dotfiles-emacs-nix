;;; --- -*- lexical-binding: t; -*-

(use-package denote
  :init
  (setq denote-directory "~/.notes/")
  (setq denote-prompts '(title keywords))
  (setq denote-known-keywords '(emacs project linux lan idea))

  (defun pg/denote-today ()
    "Create a denote entry named after today."
    (interactive)
    (denote
     (format-time-string "%A %e %B %Y")
     '("journal")
     nil
     nil
     nil
     'journal))

  (evil-define-key '(normal visual) 'global
    (kbd "<leader> x") (make-sparse-keymap)
    (kbd "<leader> x n") #'denote
    (kbd "<leader> x j") #'pg/denote-today
    (kbd "<leader> f x") #'denote-open-or-create
    (kbd "<leader> x f") #'denote-open-or-create))

(provide 'pg-notes)

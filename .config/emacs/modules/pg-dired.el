;;; --- -*- lexical-binding: t; -*-

(use-package dirvish
  :init
  (dirvish-override-dired-mode)

  (dirvish-define-preview exa (file)
    :require ("exa")
    (when (file-directory-p file)
      `(shell . ("exa" "-al" "--color=always" "--icons" "--group-directories-first" ,file))))
  (add-to-list 'dirvish-preview-dispatchers 'exa)

  (setq dirvish-side-follow-mode t)
  (pg/leader
    :states 'normal
    "o p" #'(dirvish-side :wk "sidebar")))

(provide 'pg-dired)

;;; --- -*- lexical-binding: t; -*-

(setq dired-dwim-target t)

(with-eval-after-load 'evil
  (evil-define-key '(normal motion visual) dired-mode-map
    (kbd "SPC") nil))

(use-package dirvish
  :init
  (dirvish-override-dired-mode)

  (dirvish-define-preview exa (file)
    :require ("exa")
    (when (file-directory-p file)
      `(shell . ("exa" "-al" "--color=always" "--icons" "--group-directories-first" ,file))))
  (add-to-list 'dirvish-preview-dispatchers 'exa)

  (setq dirvish-side-follow-mode t)
  (evil-define-key 'normal 'global
    (kbd "<leader> o p") #'("sidebar" . dirvish-side)))

(provide 'pg-dired)

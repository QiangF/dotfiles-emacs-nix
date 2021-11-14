;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package treemacs
  :init
  (pg/leader
   "o p" #'treemacs)

  :config
  (treemacs-resize-icons 16)
  (treemacs-set-width 30)

  :general
  (:states 'normal
   :keymaps 'treemacs-mode-map
   "C-j" #'treemacs-next-neighbour
   "C-k" #'treemacs-previous-neighbour
   "M-j" #'treemacs-move-project-down
   "M-k" #'treemacs-move-project-up))

(use-package treemacs-all-the-icons
  :after treemacs
  :config
  (treemacs-load-theme "all-the-icons"))

(use-package project
  :config
  (pg/leader
   "p f" #'(project-find-file :wk "file")
   "p p" #'(project-switch-project :wk "open")))

(provide 'pg-projects)

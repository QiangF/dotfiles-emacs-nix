;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package project
  :init
  (setq project-switch-commands 'project-find-file)
  :config

  ;; Add an optional `starting-directory' argument
  (advice-add
   'project-prompt-project-dir
   :around
   (lambda (inner &optional starting-directory)
     (let ((default-directory (or starting-directory default-directory)))
       (funcall inner))))

  (pg/leader
   "p f" #'(project-find-file :wk "file")
   "f p" #'(project-find-file :wk "file")
   "p d" #'(project-forget-project :wk "delete")
   "p p" #'(project-switch-project :wk "open")))

(use-package project
  :after dashboard
  :init
  (setq dashboard-projects-backend 'project-el))

(provide 'pg-projects)

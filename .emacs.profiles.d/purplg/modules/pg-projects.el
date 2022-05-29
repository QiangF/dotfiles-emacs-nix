;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package dired
  :init
  (add-hook 'dired-mode-hook (lambda () (dired-omit-mode))))

(use-package dired-sidebar
  :straight t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (setq dired-sidebar-close-sidebar-on-file-open t)
  (defun pg/toggle-sidebar ()
    (interactive)
    (if (vc-root-dir)
      (dired-sidebar-toggle-sidebar)
      (dired-sidebar-toggle-with-current-directory))
    ;; Hack to properly enable `dired-omit-mode'
    (when-let ((buffer (dired-sidebar-buffer)))
      (with-current-buffer buffer
        (dired-omit-mode 1))))
  (pg/leader
    :states 'normal
    "o p" #'(pg/toggle-sidebar :wk "sidebar")))

(use-package ibuffer-sidebar
  :straight t
  :init
  (setq ibuffer-saved-filter-groups
      (quote (("default"
               ("rust" (mode . rustic-mode))
               ("elisp" (mode . emacs-lisp-mode))
               ("special" (or
                           (name . "^\\*scratch\\*$")
                           (name . "^\\*Messages\\*$")))
               ("org" (mode . org-mode))))))
  (add-hook 'ibuffer-mode-hook
            (lambda () (ibuffer-switch-to-saved-filter-groups "default"))))
(pg/leader
  :states '(visual normal)
  "o i" #'(ibuffer-sidebar-toggle-sidebar :wk "ibuffer"))


;; M-h move point left
;; M-l move point right

(use-package treemacs
  :disabled
  :straight t
  :defer t
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
  :straight t
  :after treemacs
  :defer t
  :config
  (treemacs-load-theme "all-the-icons"))

(use-package project
  :init
  (setq project-switch-commands 'project-find-file)
  :config
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

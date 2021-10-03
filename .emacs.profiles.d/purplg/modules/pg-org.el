;;; pg-org.el --- -*- lexical-binding: t; -*-
(require 'pg-straight)
(require 'pg-keybinds)

(use-package org
  :straight t

  :config
  (setq org-return-follows-link t           ;; Press Enter to follow link under point
        org-adapt-indentation nil           ;; Stop putting indents everywhere
        org-edit-src-content-indentation 0  ;; Fixes indenting entire src block on enter
        org-src-preserve-indentation t      ;; Stop annoying bug with indenting elisp in a code block
        org-confirm-babel-evaluate nil      ;; Don't ask for confirmation when executing a codeblock
        org-directory "~/.org"
        org-agenda-files '("~/.org/PC.org")
        org-capture-project-file "project.org"
        org-capture-templates
        '(("w" "Work"
            entry (file+headline "~/.org/Work.org" "Tasks")
            "* TODO %?\n %i\n")

          ("p" "Current project"
            entry (file+headline (lambda () (expand-file-name org-capture-project-file (projectile-project-root))) "Tasks")
            "* TODO %?\n%i\n%a" :prepend t)

          ("s" "Session"
            entry (file+headline "~/.org/PC.org" "Session")
            "* TODO %?\n%i" :prepend t)

          ("c" "PC"
            entry (file+headline "~/.org/PC.org" "Tasks")
            "* TODO %?\n%i" :prepend t)

          ("h" "Home"
            entry (file+headline "~/.org/Home.org" "Tasks")
            "* TODO %?\n%i" :prepend t)))

  (hook! 'org-mode-hook #'(flyspell-mode org-indent-mode))

  (pg/leader
    "X" #'org-capture)

  (pg/leader
    :keymaps 'org-mode-map
    "t l" #'(org-toggle-link-display :which-key "link display"))
    
  :general
  (:states 'normal
   :keymaps 'org-src-mode-map
   "C-c C-c" #'org-edit-src-exit))
   
(use-package htmlize
  :straight t
  :after org)

(provide 'pg-org)

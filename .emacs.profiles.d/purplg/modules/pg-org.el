;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package org
  :straight (:type built-in)
  :init
  (add-hook 'org-mode-hook #'flyspell-mode)
  (add-hook 'org-mode-hook #'org-indent-mode)
  (add-hook 'org-mode-hook #'visual-line-mode)
  (setq org-return-follows-link t)                ;; Press Enter to follow link under point
  (setq org-adapt-indentation nil)                ;; Stop putting indents everywhere
  (setq org-edit-src-content-indentation 0)       ;; Fixes indenting entire src block on enter
  (setq org-src-preserve-indentation t)           ;; Stop annoying bug with indenting elisp in a code block
  (setq org-confirm-babel-evaluate nil)           ;; Don't ask for confirmation when executing a codeblock
  (setq org-src-window-setup 'split-window-below) ;; Don't hide other windows when using `org-edit-special'
  (setq org-directory "~/.org")
  (setq org-agenda-files '("~/.org/PC.org"))
  (setq org-capture-project-file "project.org")
  (setq org-capture-templates
        '(("w" "Work"
            entry (file+headline "~/.org/Work.org" "Tasks")
            "* TODO %?\n %i\n")
          ("p" "Current project"
            entry (file+headline (lambda () (expand-file-name org-capture-project-file (vc-root-dir))) "Tasks")
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

  (pg/leader
   "X" #'org-capture)

  (pg/leader
   :keymaps 'org-mode-map
   "t l" #'(org-toggle-link-display :wk "link display")
   "t s" #'(flyspell-mode :wk "spell check"))
    
  :general
  (:states 'normal :keymaps 'org-src-mode-map
   "C-c C-c" #'org-edit-src-exit)
  (:states 'normal :keymaps 'org-mode-map
   "RET" #'org-return))
   
(use-package htmlize
  :after org
  :straight t
  :defer t)

(use-package org-auto-tangle
  :after org
  :straight t
  :init
  (add-hook 'org-mode-hook #'org-auto-tangle-mode))

(use-package org-make-toc
  :after org
  :straight t
  :defer t)

(provide 'pg-org)

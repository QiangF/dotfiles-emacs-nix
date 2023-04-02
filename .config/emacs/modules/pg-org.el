;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package org
  :straight (:type built-in)
  :init

  ;; Hooks
  (add-hook 'org-mode-hook #'flyspell-mode)
  (add-hook 'org-mode-hook #'org-indent-mode)
  (add-hook 'org-mode-hook #'visual-line-mode)

  ;; Tweaks
  (setq org-return-follows-link t) ;; Press Enter to follow link under point
  (setq org-adapt-indentation nil) ;; Stop putting indents everywhere
  (setq org-edit-src-content-indentation 0) ;; Fixes indenting entire src block on enter
  (setq org-src-preserve-indentation t) ;; Stop annoying bug with indenting elisp in a code block
  (setq org-confirm-babel-evaluate nil) ;; Don't ask for confirmation when executing a codeblock
  (setq org-src-window-setup 'split-window-below) ;; Don't hide other windows when using `org-edit-special'
  (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

  (when (file-exists-p "~/.org") (setq org-directory "~/.org"))
  (when-let (org-pc (expand-file-name "PC.org" org-directory))
    (setq initial-buffer-choice
          (lambda ()
            (let ((buffer (find-file org-pc)))
              (with-current-buffer buffer (auto-revert-mode 1))
              buffer))))

  ;; Capture
  (setq org-capture-project-file "project.org")
  (setq org-capture-templates
        '(("i" "Inbox" entry
           (file+headline (lambda () (expand-file-name "inbox.org" org-directory)) "Tasks")
           "* TODO %i%?")

          ("t" "Tickler" entry
           (file+headline (lambda () (expand-file-name "tickler.org" org-directory)) "Tickler")
           "* %i%? \n %U")))

  (setq org-agenda-custom-commands
        '(("w" "At work" tags-todo "@work"
           ((org-agenda-overriding-header "Work")))
          ("h" "At home" tags-todo "@home"
           ((org-agenda-overriding-header "Home")))))
  
  (setq org-agenda-files '("~/.org/inbox.org"
                           "~/.org/tickler.org"))

  (setq org-refile-targets '(("~/.org/inbox.org" :maxlevel . 3)
                             ("~/.org/someday.org" :level . 1)
                             ("~/.org/tickler.org" :maxlevel . 2)))
  
  ;; Keybinds
  (pg/leader
    "X" #'org-capture)

  (defun pg/sort-tasks ()
    "Sort by priority, then todo."
    (interactive)
    (let ((line (org-current-line)))
      (org-up-heading-safe)
      (org-sort-entries nil ?p)
      (org-sort-entries nil ?o)
      (goto-line line))
    (org-cycle-set-startup-visibility))
  
  (pg/leader
    :keymaps 'org-mode-map
    "t l" #'(org-toggle-link-display :wk "link display")
    "t s" #'(flyspell-mode :wk "spell check")
    "m s" #'(pg/sort-tasks :wk "sort"))
    
  :general
  (:states 'normal :keymaps 'org-src-mode-map
           "C-c C-c" #'org-edit-src-exit)
  (:states 'normal :keymaps 'org-mode-map
           "RET" #'org-return))
   
(use-package htmlize
  :after org
  :defer t)

(use-package org-auto-tangle
  :after org
  :init
  (add-hook 'org-mode-hook #'org-auto-tangle-mode))

(use-package org-make-toc
  :after org
  :defer t)

(with-eval-after-load 'ob-core
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (shell . t))))

(provide 'pg-org)

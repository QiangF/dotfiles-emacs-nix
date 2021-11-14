;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package vertico
  :init
  (vertico-mode 1)

  :config
  (defun pg/find-file-in-profile-dir ()
    (interactive)
    (ido-find-file-in-dir pg/config-dir))
  
  (defun pg/find-file-in-home-dir ()
    (interactive)
    (ido-find-file-in-dir "~"))
  
  (defun pg/find-file-in-org-dir ()
    (interactive)
    (ido-find-file-in-dir org-directory))
  
  (defun pg/find-file-in-root-dir ()
    (interactive)
    (ido-find-file-in-dir "/"))

  (defun pg/project-search-thing-at-point ()
    (interactive)
    (consult-ripgrep (consult--project-root) (thing-at-point 'symbol)))

  (pg/leader
   "f o" #'(pg/find-file-in-org-dir :wk "in org")
   "f c" #'(pg/find-file-in-profile-dir :wk "in config")
   "f ~" #'(pg/find-file-in-home-dir :wk "in home")
   "f /" #'(pg/find-file-in-root-dir :wk "in root")
   "f f" #'(find-file :wk "file")
   "p S" #'(pg/project-search-thing-at-point :wk "search this"))

  :general
  (:keymaps 'minibuffer-local-map
   "C-S-k" #'scroll-down-command
   "C-S-j" #'scroll-up-command
   "C-k" #'previous-line
   "C-j" #'next-line
   "C-l" #'vertico-insert))

(use-package consult
  :after vertico
  :config
  
  (setq consult-project-root-function #'vc-root-dir)
  
  (pg/leader
   "b b" #'(consult-buffer :wk "buffer")
   "b o" #'(consult-buffer-other-frame :wk "buffer-other")
   "s b" #'(consult-line :wk "buffer")
   "s p" #'(consult-line-multi :wk "project")
   "s r" #'(consult-ripgrep :wk "regex")
   "f r" #'(consult-recent-file :wk "recent"))
  (recentf-mode 1))
    
(use-package consult-lsp
  :after consult lsp
  :config
  (pg/leader
   :keymaps 'lsp-mode-map
   "s e" #'(consult-lsp-diagnostics :wk "errors")))

(use-package marginalia
  :after vertico
  :init
  (marginalia-mode 1))

;; ~orderless~ allows completion chunks (space delimited) to be search out of order. In other words, a
;; query for =some function= will return the same results as =function some= with possibly a different
;; sort order based on accuracy.

(use-package orderless
  :config
  (setq completion-styles '(orderless partial-completion)))

(use-package savehist
  :init
  (savehist-mode))

(provide 'pg-completion)
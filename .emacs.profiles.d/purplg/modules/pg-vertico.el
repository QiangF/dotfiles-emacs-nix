;;; pg-vertico.el --- -*- lexical-binding: t; -*-

(require 'pg-straight)
(require 'pg-keybinds)

(use-package vertico
  :straight t
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
    (consult-ripgrep projectile-project-root (thing-at-point 'symbol)))

  (pg/leader
    "f o" #'(pg/find-file-in-org-dir :which-key "in org")
    "f c" #'(pg/find-file-in-profile-dir :which-key "in config")
    "f ~" #'(pg/find-file-in-home-dir :which-key "in home")
    "f /" #'(pg/find-file-in-root-dir :which-key "in root")
    "f f" #'(find-file :which-key "file")
    "p S" #'(pg/project-search-thing-at-point :which-key "search this"))

  :general
  (:keymaps 'minibuffer-local-map
    "C-S-k" #'scroll-down-command
    "C-S-j" #'scroll-up-command
    "C-k" #'previous-line
    "C-j" #'next-line
    "C-l" #'vertico-insert))

(use-package consult
  :straight t
  :after vertico
  :config
  
  (setq consult-project-root-function #'projectile-project-root)
  
  (pg/leader
    "b b" #'(consult-buffer :which-key "buffer")
    "b o" #'(consult-buffer-other-frame :which-key "buffer-other")
    "s b" #'(consult-line :which-key "buffer")
    "s p" #'(consult-line-multi :which-key "project")
    "s r" #'(consult-ripgrep :which-key "regex")
    "f r" #'(consult-recent-file :which-key "recent"))
  (recentf-mode 1))
    
(use-package consult-lsp
  :straight t
  :after consult lsp
  :config
  (pg/leader
    :keymaps 'lsp-mode-map
    "s e" #'(consult-lsp-diagnostics :which-key "errors")))

(use-package marginalia
  :straight t
  :after vertico
  :init
  (marginalia-mode 1))

(provide 'pg-vertico)

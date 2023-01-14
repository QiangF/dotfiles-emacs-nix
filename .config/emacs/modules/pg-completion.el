;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package corfu
  :straight (:files (:defaults "extensions/corfu-popupinfo.el"))
  :init
  (setq corfu-auto t)
  (setq corfu-auto-delay 0.2)
  (setq corfu-popupinfo-delay 0.5)

  (add-hook 'corfu-mode-hook #'corfu-popupinfo-mode)

  :general
  ; Clear conflicting C-k keybind
  (:keymaps 'evil-insert-state-map
   "C-k" nil)
  (:keymaps 'corfu-map
   "C-j" #'corfu-next
   "C-k" #'corfu-previous
   "C-S-j" #'corfu-scroll-up
   "C-S-k" #'corfu-scroll-down))

(use-package corfu
  :after elisp-mode
  :init
  (add-hook 'emacs-lisp-mode-hook #'corfu-mode))

(use-package eldoc-box
  :disabled
  :straight t
  :hook (eldoc-mode . eldoc-box-hover-mode)
  :general
  (:states 'normal
   "C-/" #'eldoc-box-eglot-help-at-point))

(use-package kind-icon
  :straight t
  :after corfu
  :config
  (setq kind-icon-default-face 'corfu-default)
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

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
    (consult-ripgrep (consult--project-root) (thing-at-point 'symbol)))

  (pg/leader
   "f o" #'(pg/find-file-in-org-dir :wk "in org")
   "f c" #'(pg/find-file-in-profile-dir :wk "in config")
   "f `" #'(pg/find-file-in-home-dir :wk "in home")
   "f /" #'(pg/find-file-in-root-dir :wk "in root")
   "f f" #'(find-file :wk "here")
   "p S" #'(pg/project-search-thing-at-point :wk "search this"))

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
  
  (setq consult-project-root-function #'vc-root-dir)
  
  (pg/leader
   "b b" #'(consult-buffer :wk "buffer")
   "b o" #'(consult-buffer-other-frame :wk "buffer-other")
   "s b" #'(consult-line :wk "buffer")
   "s p" #'(consult-line-multi :wk "project")
   "s r" #'(consult-ripgrep :wk "regex")
   "f r" #'(consult-recent-file :wk "recent")))

(use-package consult-eglot
  :straight t
  :after consult eglot
  :config
  (pg/leader
   :keymaps 'eglot-mode-map
   :states 'normal
   "s s" #'(consult-eglot-symbols :wk "Symbol")))

(use-package all-the-icons
  :straight t)

(use-package all-the-icons-completion
  :after all-the-icons
  :straight t
  :init
  (all-the-icons-completion-mode))

(use-package all-the-icons-dired
  :after all-the-icons
  :straight t
  :init
  (add-hook 'dired-mode-hook #'all-the-icons-dired-mode))
    
(use-package marginalia
  :straight t
  :after vertico
  :init
  (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)
  (marginalia-mode 1))

(use-package orderless
  :straight t
  :init
  (setq completion-styles '(orderless flex)))

(use-package savehist
  :straight t
  :init
  (savehist-mode))

(provide 'pg-completion)

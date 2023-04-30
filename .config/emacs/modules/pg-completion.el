;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(setq completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

(use-package corfu
  :elpaca (:files (:defaults "extensions/corfu-popupinfo.el"))
  :init
  (setq corfu-auto t)
  (setq corfu-auto-delay 0)
  (setq corfu-auto-prefix 1)
  (setq corfu-popupinfo-delay 0.5)

  (with-eval-after-load 'elisp-mode
    (add-hook 'emacs-lisp-mode-hook #'corfu-mode))

  (evil-define-key* 'insert 'global
   (kbd "C-k") nil) ; Clear conflicting C-k keybind

  :config
  (add-hook 'corfu-mode-hook #'corfu-popupinfo-mode)

  (evil-define-key* '(normal insert) corfu-map
   (kbd "C-j") #'corfu-next
   (kbd "C-k") #'corfu-previous
   (kbd "C-S-j") #'corfu-scroll-up
   (kbd "C-S-k") #'corfu-scroll-down))

(use-package eldoc-box
  :hook (eldoc-mode . eldoc-box-hover-mode)
  :init
  (evil-define-key* 'normal 'global
   (kbd "C-/") #'eldoc-box-eglot-help-at-point))

(use-package kind-icon
  :after corfu
  :config
  (setq kind-icon-default-face 'corfu-default)
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

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

  (evil-define-key* 'normal 'global
   (kbd "<leader> f o") #'("in org" . pg/find-file-in-org-dir)
   (kbd "<leader> f c") #'("in config" . pg/find-file-in-profile-dir)
   (kbd "<leader> f `") #'("in home" . pg/find-file-in-home-dir)
   (kbd "<leader> f /") #'("in root" . pg/find-file-in-root-dir))

  (evil-define-key* 'normal 'global
   (kbd "<leader> p S") #'("search this" . pg/project-search-thing-at-point))

  (evil-define-key* '(normal insert) minibuffer-local-map
   (kbd "C-S-k") #'scroll-down-command
   (kbd "C-S-j") #'scroll-up-command
   (kbd "C-k") #'previous-line
   (kbd "C-j") #'next-line
   (kbd "C-l") #'vertico-insert))

(use-package consult
  :after vertico
  :init
  (setq consult-project-root-function #'project-root)

  (evil-define-key* 'normal 'global
   (kbd "<leader> b b") #'("buffer" . consult-buffer)
   (kbd "<leader> b o") #'("buffer other" . consult-buffer-other-frame))

  (evil-define-key* 'normal 'global
   (kbd "<leader> p b") #'("project file" . consult-project-buffer))

  (evil-define-key* 'normal 'global
   (kbd "<leader> s b") #'("buffer" . consult-line)
   (kbd "<leader> s i") #'("imenu" . consult-imenu)
   (kbd "<leader> s I") #'("imenu-multi" . consult-imenu-multi)
   (kbd "<leader> s p") #'("project" . consult-line-multi)
   (kbd "<leader> s h") #'("heading" . consult-outline)
   (kbd "<leader> s r") #'("regex" . consult-ripgrep))

  (evil-define-key* 'normal 'global
   (kbd "<leader> f r") #'("recent" . consult-recent-file)))

(use-package consult-eglot
  :after consult eglot
  :config
  (evil-define-key* 'normal eglot-mode-map
    (kbd "<leader> s s") #'("Symbol" . consult-eglot-symbols)))

(use-package all-the-icons)

(use-package all-the-icons-completion
  :after all-the-icons
  :init
  (all-the-icons-completion-mode))

(use-package all-the-icons-dired
  :after all-the-icons
  :init
  (add-hook 'dired-mode-hook #'all-the-icons-dired-mode))
    
(use-package marginalia
  :after vertico
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)
  (marginalia-mode 1))

(use-package orderless
  :init
  (setq completion-styles '(orderless flex)))

(use-package savehist
  :elpaca nil
  :init
  (savehist-mode))

(use-package cape
  :init
  (evil-define-key 'insert 'global
    (kbd "C-f") #'cape-file))

(provide 'pg-completion)

;;; pg-ivy.el --- -*- lexical-binding: t; -*-

;; Better fuzzy search. Unintuitively intercepts `ivy--regex-fuzzy` below

;; Better fuzzy search. Unintuitively intercepts `ivy--regex-fuzzy` below
(use-package flx
  :straight t)

(use-package ivy
  :straight t
  :init
  (ivy-mode 1)

  :config
  (setq ivy-use-virtual-buffers t
        ivy-initial-inputs-alist nil
        ivy-re-builders-alist '((t . ivy--regex-fuzzy)))

  :general
;; Minibuffer Evil movement keys
  (:keymaps 'ivy-minibuffer-map
    "C-S-k" #'ivy-scroll-down-command
    "C-S-j" #'ivy-scroll-up-command
    "C-k" #'ivy-previous-line
    "C-j" #'ivy-next-line))

(use-package counsel
  :straight t
  :after ivy
  :init
  (counsel-mode 1)

  :config
  (setq counsel-describe-variable-function #'helpful-variable
        counsel-describe-function-function #'helpful-function)

  ;; Redefine find file functions to counsel variants
  (defun pg/find-file-in-profile-dir ()
    (interactive)
    (counsel-find-file pg/config-dir))
  
  (defun pg/find-file-in-home-dir ()
    (interactive)
    (counsel-find-file "~"))
  
  (defun pg/find-file-in-root-dir ()
    (interactive)
    (counsel-find-file "/"))

  (defun pg/project-search-thing-at-point ()
    (interactive)
    (counsel-rg (thing-at-point 'symbol)))

  (pg/leader
    "p s" #'(counsel-rg :which-key "search")
    "f f" #'(counsel-find-file :which-key "in profile")
    "f c" #'(pg/find-file-in-profile-dir :which-key "in config")
    "f ~" #'(pg/find-file-in-home-dir :which-key "in home")
    "f /" #'(pg/find-file-in-root-dir :which-key "in root")
    "f r" #'(counsel-recentf :which-key "find recent")
    "p S" #'(pg/project-search-thing-at-point :which-key "search this")))

(use-package ivy-rich
  :straight t
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package swiper
  :straight t
  :after ivy
  :config
  (pg/leader
    "s b" #'(swiper :which-key "buffer")))

(provide 'pg-ivy)

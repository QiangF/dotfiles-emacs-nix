(hook! 'prog-mode-hook #'hl-line-mode)

(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)

(use-package doom-themes
  :straight t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)

  (load-theme 'doom-dracula t))

(use-package page-break-lines
  :defer t
  :straight t
  :config
  (global-page-break-lines-mode))

(with-current-buffer "*scratch*" (emacs-lock-mode 'kill))

(use-package dashboard
  :straight t
  :config
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))
        dashboard-banners-directory (concat pg/config-dir "banners/")
        dashboard-startup-banner (+ 1 (random 3))
        dashboard-filter-agenda-entry #'dashboard-filter-agenda-by-todo
        dashboard-items '((projects . 5)
                          (recents . 5)
                          (agenda . 15)))

  (dashboard-setup-startup-hook)

  (hook! 'dashboard-after-initialize-hook #'(lambda ()
                                              (with-current-buffer "*dashboard*" (emacs-lock-mode 'kill))))

  (defun dashboard-refresh-buffer-silent ()
    "Refresh buffer in background."
    (interactive)
    (let ((dashboard-force-refresh t)) (dashboard-insert-startupify-lists)))
  
  (defun dashboard-switch ()
    "Switch to dashboard buffer"
    (switch-to-buffer dashboard-buffer-name))
  
  (pg/leader "o d" '(dashboard-switch :which-key "dashboard"))

  :general
  (:states 'normal
   :keymaps 'dashboard-mode-map
   "q" nil))

(use-package which-key
  :straight t
  :config
  (setq which-key-idle-delay 1)
  (which-key-mode 1))

(use-package vertico
  :straight t
  :init
  (vertico-mode 1)

  :config
  ;; Redefine find file functions to support vertico
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
    "f o" '(pg/find-file-in-org-dir :which-key "in org")
    "f c" '(pg/find-file-in-profile-dir :which-key "in config")
    "f ~" '(pg/find-file-in-home-dir :which-key "in home")
    "f /" '(pg/find-file-in-root-dir :which-key "in root")
    "p S" '(pg/project-search-thing-at-point :which-key "search this"))

  :general
  (:keymaps 'minibuffer-local-map
    "C-S-k" 'scroll-down-command
    "C-S-j" 'scroll-up-command
    "C-k" 'previous-line
    "C-j" 'next-line
    "C-l" 'vertico-insert))

(use-package consult
  :straight t
  :after vertico
  :config
  
  (setq consult-project-root-function #'projectile-project-root)
  
  (pg/leader
    "b b" '(consult-buffer :which-key "buffer")
    "b o" '(consult-buffer-other-frame :which-key "buffer-other")
    "s b" '(consult-line :which-key "buffer")
    "s p" '(consult-line-multi :which-key "project")
    "s r" '(consult-ripgrep :which-key "regex")
    "f r" '(consult-recent-file :which-key "recent"))
  (recentf-mode 1))
    
(use-package consult-lsp
  :straight t
  :after consult lsp
  :config
  (pg/leader
    :keymaps 'lsp-mode-map
    "s e" '(consult-lsp-diagnostics :which-key "errors")))

(use-package marginalia
  :straight t
  :after vertico
  :init
  (marginalia-mode 1))

(use-package orderless
  :straight t
  :config
  (setq completion-styles '(basic orderless partial-completion)))

(use-package savehist
  :straight t
  :init
  (savehist-mode))

(use-package doom-modeline
  :straight t
  :config
  (doom-modeline-mode 1))

(use-package persp-mode
  :straight t
  :config
  (setq persp-auto-resume-time -1)
  (add-to-list 'recentf-exclude (concat user-emacs-directory "persp-confs/persp-auto-save") t)

  ;; Modified from Doom's `+workspace--tabline`
  (defun persp--format-tab (label active) 
    (propertize label
      'face (if active
        'doom-modeline-panel
        'doom-modeline-bar-inactive)))

  (defun persp-list () 
  "Display a list of perspectives"
    (interactive)
    (message "%s"
      (let ((names persp-names-cache)
            (current-name (safe-persp-name
                            (get-current-persp
                              (selected-frame)
                              (selected-window)))))
        (mapconcat
         #'identity
          (cl-loop for name in names
                   for i to (length names)
                   collect
                   (persp--format-tab
                     (format " %d:%s " (1+ i) name)
                     (equal current-name name)))
         nil))))

  ;; Show list of perspectives after switching
  (advice-add 'persp-next :after 'persp-list)
  (advice-add 'persp-prev :after 'persp-list)
  
  (pg/leader
    :keymaps 'persp-mode-map
    "b b" '(persp-switch-to-buffer :which-key "buffer")
    "TAB" '(:which-key "perspectives")
    "TAB TAB" '(persp-list :which-key "list")
    "TAB s" '(persp-switch :which-key "switch")
    "TAB a" '(persp-add-buffer :which-key "add buffer")
    "TAB x" '(persp-remove-buffer :which-key "remove buffer")
    "TAB d" '(persp-kill :which-key "kill persp")
    "TAB r" '(persp-rename :which-key "rename")
    "TAB n" '(persp-add-new :which-key "new")
    "TAB l" '(persp-next :which-key "next persp")
    "TAB h" '(persp-prev :which-key "prev persp"))

  (persp-mode))

(use-package helpful
  :straight t
  :config
  (pg/leader
    "h f" '(helpful-function :which-key "function")
    "h v" '(helpful-variable :which-key "variable")
    "h m" '(helpful-macro :which-key "macro")
    "h V" '(apropos-value :which-key "value")
    "h ." '(helpful-at-point :which-key "this")
    "h k" '(helpful-key :which-key "key")))

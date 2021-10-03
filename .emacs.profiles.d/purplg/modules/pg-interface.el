;;; pg-interface.el --- -*- lexical-binding: t; -*-
(require 'pg-straight)
(require 'pg-basics)
(require 'pg-config)
(require 'pg-keybinds)

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

(hook! 'post-command-hook
        (lambda ()
            (let ((messages (get-buffer "*Messages*")))
              (unless (eq (current-buffer) messages)
                (with-current-buffer messages
                  (goto-char (point-max)))))))

;; Prevent the scratch buffer from being deleted
(with-current-buffer "*scratch*" (emacs-lock-mode 'kill))

(use-package dashboard
  :straight t
  :config
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))
        dashboard-banners-directory (expand-file-name "banners/" pg/config-dir)
        dashboard-startup-banner (+ 1 (random 3))
        dashboard-filter-agenda-entry #'dashboard-filter-agenda-by-todo
        dashboard-items '((projects . 5)
                          (recents . 10)
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
    (interactive)
    (switch-to-buffer dashboard-buffer-name))
  
  (pg/leader "o d" #'(dashboard-switch :which-key "dashboard"))

  :general
  (:states 'normal
   :keymaps 'dashboard-mode-map
   "q" nil))

(setq dashboard-set-navigator t)
(setq dashboard-navigator-buttons
      `(((nil "Home Assistant" "Home Assistant" (lambda (&rest _) (hass/query-entities))))))

(use-package which-key
  :straight t
  :config
  (setq which-key-idle-delay 1)
  (which-key-mode 1))

(require 'pg-vertico)

;; ~orderless~ allows completion chunks (space delimited) to be search out of order. In other words, a
;; query for =some function= will return the same results as =function some= with possibly a different
;; sort order based on accuracy.

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
  :after doom-modeline
  :config
  (setq persp-auto-resume-time -1)
  (add-to-list 'recentf-exclude (concat user-emacs-directory "persp-confs/persp-auto-save") t)

  ;; Modified from Doom's `+workspace--tabline`
  (defun persp--format-tab (label active) 
    (propertize label
      'face (if active)
        'doom-modeline-panel
        'doom-modeline-bar-inactive))

  (defun persp-list ()) 
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
       nil)))

  ;; Show list of perspectives after switching
  (advice-add 'persp-next :after #'persp-list)
  (advice-add 'persp-prev :after #'persp-list)
  
  (pg/leader
    :keymaps 'persp-mode-map
    "b b" #'(persp-switch-to-buffer :which-key "buffer")
    "TAB" #'(:which-key "perspectives")
    "TAB TAB" #'(persp-list :which-key "list")
    "TAB s" #'(persp-switch :which-key "switch")
    "TAB a" #'(persp-add-buffer :which-key "add buffer")
    "TAB x" #'(persp-remove-buffer :which-key "remove buffer")
    "TAB d" #'(persp-kill :which-key "kill persp")
    "TAB r" #'(persp-rename :which-key "rename")
    "TAB n" #'(persp-add-new :which-key "new")
    "TAB l" #'(persp-next :which-key "next persp")
    "TAB h" #'(persp-prev :which-key "prev persp"))

  (persp-mode))

(use-package helpful
  :straight t
  :config
  (pg/leader
    "h f" #'(helpful-function :which-key "function")
    "h v" #'(helpful-variable :which-key "variable")
    "h m" #'(helpful-macro :which-key "macro")
    "h V" #'(apropos-value :which-key "value")
    "h ." #'(helpful-at-point :which-key "this")
    "h k" #'(helpful-key :which-key "key")))

(provide 'pg-interface)

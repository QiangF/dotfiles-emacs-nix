(require 'pg-straight)
(require 'pg-keybinds)

(use-package undo-fu
  :straight t)

(use-package undo-fu-session
  :straight t
  :after undo-fu
  :config
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
  (global-undo-fu-session-mode))

(use-package evil
  :straight t
  :after undo-fu
  :init
  (setq evil-want-keybinding nil)
  (setq evil-undo-system #'undo-fu)
  (evil-mode 1)

  :config
  (pg/leader :states 'normal
   "b p" #'(evil-prev-buffer :which-key "previous")
   "b n" #'(evil-next-buffer :which-key "next")
   "b N" #'(evil-buffer-new :which-key "new"))

  (advice-add 'evil-forward-section-begin :after #'evil-scroll-line-to-center)
  (advice-add 'evil-backward-section-begin :after #'evil-scroll-line-to-center)

  (defun evil-close-fold-below ()
    "Close fold on current line instead of enclosing block at point"
    (interactive)
    (save-excursion
      (end-of-line)
      (evil-close-fold)))
  
  (defun evil-open-fold-save ()
    "Keep point in place when opening fold"
    (interactive)
    (save-excursion
      (evil-open-fold)))
  
  ;; Keep cursor in place when opening a fold
  (advice-add 'evil-open-fold
    :around
    (lambda (inner &rest _)  
      (save-excursion
        (funcall inner))))
  
  :general
  (:states 'normal
   "z c" #'evil-close-fold-below
   "z C" #'evil-close-fold)
  
  (:states 'normal
   "M-j" #'move-line-down
   "M-k" #'move-line-up
   "C-j" #'evil-forward-section-begin
   "C-k" #'evil-backward-section-begin)

  ;; Unbind SPC in Dired mode
  ;; Dired takes precendence for the ~SPC~ key. Don't like that
  (:states 'normal
   :keymaps 'dired-mode-map
   "SPC" nil)
    
  ;; I often press =C-w C-h= to go left (for example) instead of =C-w h= so I'll just bind both.
  (:states 'normal
   "C-w C-h" #'evil-window-left
   "C-w C-j" #'evil-window-down
   "C-w C-k" #'evil-window-up
   "C-w C-l" #'evil-window-right
   "C-<tab>" #'evil-switch-to-windows-last-buffer))

(use-package evil-surround
  :straight t
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-collection
  :straight t
  :after evil
  :config
  (setq evil-collection-outline-bind-tab-p t)
  (evil-collection-init))

(provide 'pg-evil)

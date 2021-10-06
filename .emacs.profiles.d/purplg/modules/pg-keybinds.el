(require 'pg-straight)
(require 'pg-basics)

(defun move-line-up ()
    (interactive)
    (transpose-lines 1)
    (forward-line -2))
  
(defun move-line-down ()
    (interactive)
    (forward-line 1)
    (transpose-lines 1)
    (forward-line -1))

(defun open-scratch-buffer ()
  (interactive)
  (switch-to-buffer "*scratch*"))
  
(use-package which-key
  :straight t
  :config
  (setq which-key-idle-delay 1)
  (which-key-mode 1))

(use-package general
  :straight t
  :config
  (defalias 'hook! 'general-add-hook)

  (general-create-definer pg/leader
   :states '(normal visual)
   :prefix "SPC")
  
  (general-create-definer pg/local-leader
   :states '(normal visual)
   :prefix "SPC m")
  
  (pg/leader
   "m" '(:ignore t :wk "local")
   "s" '(:ignore t :wk "search")
   "c" '(:ignore t :wk "code")
   "p" '(:ignore t :wk "project")
   "o" '(:ignore t :wk "open")
   "t" '(:ignore t :wk "toggle")
   "f" '(:ignore t :wk "file")
   "h" '(:ignore t :wk "help")
   "q" '(:ignore t :wk "quit")
   "w" '(:ignore t :wk "window")
   "b" '(:ignore t :wk "buffer")

   "o s" #'(open-scratch-buffer :wk "scratch")
   "t f" #'(display-fill-column-indicator-mode :wk "fill-column")
   "t n" #'(display-line-numbers-mode :wk "line numbers")
   "t w" #'(whitespace-mode :wk "whitespace")
  
   "f f" #'(find-file :wk "find")
   "f s" #'(save-buffer :wk "save")
   "f ." #'(find-file-at-point :wk "this")
   "f m" #'(pg/open-module :wk "module")
  
   "h k" #'(describe-key :wk "key")
   "h p" #'(describe-package :wk "package")
  
   "q w" #'(delete-window :wk "window")
   "q b" #'(kill-this-buffer :wk "buffer")
   "q q" #'(save-buffers-kill-terminal :wk "really quit?")
  
   "w d" #'delete-window
   "w s" #'split-window-below
   "w v" #'split-window-right
  
   "b b" #'(project-switch-to-buffer :wk open)
   "b d" #'kill-this-buffer
   "b r" #'revert-buffer
  
   ";" #'eval-expression)
  
  ;; Unbind SPC in Dired mode
  ;; Dired takes precendence for the ~SPC~ key. Don't like that
  (general-define-key
   :states 'normal
   :keymaps 'dired-mode-map
   "SPC" nil))

(use-package undo-fu
  :straight t)

(use-package undo-fu-session
  :straight t
  :config
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
  (global-undo-fu-session-mode))

(use-package evil
  :straight t
  :functions undo-fu
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
  (setq evil-undo-system 'undo-fu)

  :config
  (evil-mode 1)

  ;; Center buffer on point when jumping between sections
  (advice-add 'evil-forward-section-begin
              :after #'evil-scroll-line-to-center)
  (advice-add 'evil-backward-section-begin
              :after #'evil-scroll-line-to-center)
  
  ;; Keep cursor in place when opening a fold
  (advice-add 'evil-open-fold
              :around (lambda (inner &rest _)  
                        (save-excursion (funcall inner))))

  (pg/leader
   :states 'normal
   "b p" #'(evil-prev-buffer :wk "previous")
   "b n" #'(evil-next-buffer :wk "next")
   "b N" #'(evil-buffer-new :wk "new"))

  (defun evil-close-fold-below ()
    "Close fold on current line instead of enclosing block at point"
    (interactive)
    (save-excursion
      (end-of-line)
      (evil-close-fold)))

  (general-define-key
   :states 'normal
   "z c" #'evil-close-fold-below
   "z C" #'evil-close-fold)
    
  (general-define-key
   :states 'normal
   "M-j" #'move-line-down
   "M-k" #'move-line-up
   "C-j" #'evil-forward-section-begin
   "C-k" #'evil-backward-section-begin)
      
   ;; I often press =C-w C-h= to go left (for example) instead of =C-w h= so I'll just bind both.
  (general-define-key
   :states 'normal
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

(provide 'pg-keybinds)

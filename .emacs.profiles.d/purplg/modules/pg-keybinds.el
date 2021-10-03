(require 'pg-straight)

(use-package which-key
  :straight t
  :config
  (setq which-key-idle-delay 1)
  (which-key-mode 1))

(use-package general
  :straight t
  :config
  (defalias 'hook! 'general-add-hook))

(general-create-definer pg/leader
  :states '(normal visual)
  :prefix "SPC")

(general-create-definer pg/local-leader
  :states '(normal visual)
  :prefix "SPC m")

(pg/leader
  "m" '(:which-key "local")
  "o" '(:which-key "open")
  "s" '(:which-key "search")
  "c" '(:which-key "code")
  "p" '(:which-key "project")

  "t" '(:which-key "toggle")
  "t f" #'(display-fill-column-indicator-mode :which-key "fill-column")
  "t n" #'(display-line-numbers-mode :which-key "line numbers")
  "t w" #'(whitespace-mode :which-key "whitespace")

  "f" '(:which-key "file")
  "f f" #'(find-file :which-key "find")
  "f s" #'(save-buffer :which-key "save")
  "f ." #'(find-file-at-point :which-key "this")

  "h" '(:which-key "help")
  "h k" #'(describe-key :which-key "key")
  "h p" #'(describe-package :which-key "package")

  "q" '(:which-key "quit")
  "q w" #'(delete-window :which-key "window")
  "q b" #'(kill-this-buffer :which-key "buffer")
  "q q" #'(save-buffers-kill-terminal :which-key "really quit?")

  "w" '(:which-key "window")
  "w d" #'delete-window
  "w s" #'split-window-below
  "w v" #'split-window-right

  "b" '(:which-key "buffer")
  "b b" #'(project-switch-to-buffer :which-key open)
  "b d" #'kill-this-buffer
  "b r" #'revert-buffer

  ";" #'eval-expression)

(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

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
    (lambda ()
      (save-excursion (funcall inner))))
  
  (general-define-key
      :states 'normal
      "z c" #'evil-close-fold-below
      "z C" #'evil-close-fold)
  
  (general-define-key 
      :states 'normal
      :keymaps 'prog-mode-map
      "C-[" #'previous-error
      "C-]" #'next-error)
  
  :general
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

(provide 'pg-keybinds)

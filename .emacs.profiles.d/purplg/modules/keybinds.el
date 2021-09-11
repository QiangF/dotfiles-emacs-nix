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
  "t f" '(display-fill-column-indicator-mode :which-key "fill-column")
  "t n" '(pg/toggle-line-numbers :which-key "line numbers")
  "t w" '(whitespace-mode :which-key "whitespace")

  "f" '(:which-key "file")
  "f f" '(find-file :which-key "find")
  "f s" '(save-buffer :which-key "save")
  "f ." '(find-file-at-point :which-key "this")

  "h" '(:which-key "help")
  "h k" '(describe-key :which-key "key")
  "h p" '(describe-package :which-key "package")
  "h b" '(counsel-descbinds :which-key "binds")

  "q" '(:which-key "quit")
  "q w" '(delete-window :which-key "window")
  "q b" '(kill-this-buffer :which-key "buffer")
  "q q" '(save-buffers-kill-terminal :which-key "really quit?")

  "w" '(:which-key "window")
  "w d" 'delete-window
  "w s" 'split-window-below
  "w v" 'split-window-right

  "b" '(:which-key "buffer")
  "b b" '(project-switch-to-buffer :which-key open)
  "b d" 'kill-this-buffer
  "b r" 'revert-buffer

  ";" 'eval-expression)

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
  (setq evil-undo-system 'undo-fu)
  (evil-mode 1)

  (pg/leader :states 'normal
    "b p" '(evil-prev-buffer :which-key "previous")
    "b n" '(evil-next-buffer :which-key "next")
    "b N" '(evil-buffer-new :which-key "new"))

  (advice-add 'evil-forward-section-begin :after 'evil-scroll-line-to-center)
  (advice-add 'evil-backward-section-begin :after 'evil-scroll-line-to-center)

  :general
  (:states 'normal
    "M-j" 'move-line-down
    "M-k" 'move-line-up
    "C-j" 'evil-forward-section-begin
    "C-k" 'evil-backward-section-begin
    "C-<tab>" 'evil-switch-to-windows-last-buffer))

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

(general-define-key
  :states 'normal
  :keymaps 'dired-mode-map
  "SPC" nil)

(general-define-key
  :states 'normal
  "C-w C-h" 'evil-window-left
  "C-w C-j" 'evil-window-down
  "C-w C-k" 'evil-window-up
  "C-w C-l" 'evil-window-right)

;;; --- -*- lexical-binding: t; -*-

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

(defun save-all-buffers ()
  (interactive)
  (save-some-buffers t))

(defun yank-whole-buffer ()
  (interactive)
  (evil-yank (point-min) (point-max))
  (message "Yanked entire buffer."))

(defun toggle-maximize-buffer ()
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_)
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

(use-package which-key
  :straight t
  :init
  (setq which-key-idle-delay 1)
  (which-key-mode 1))

(use-package general
  :straight t
  :config
  (general-create-definer pg/leader
   :states '(normal visual)
   :prefix "SPC"
   :non-normal-prefix "M-SPC")

  (general-create-definer pg/local-leader
   :states '(normal visual)
   :prefix "C-SPC")

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

   "y" #'(yank-whole-buffer :wk "yank buffer")

   "t f" #'(display-fill-column-indicator-mode :wk "fill-column")
   "t n" #'(display-line-numbers-mode :wk "line numbers")
   "t w" #'(whitespace-mode :wk "whitespace")

   "f f" #'(find-file :wk "find")
   "f s" #'(save-buffer :wk "save")
   "f S" #'(save-all-buffers :wk "save all")
   "f ." #'(find-file-at-point :wk "this")
   "f m" #'(pg/open-module :wk "module")

   "h k" #'(describe-key :wk "key")
   "h p" #'(describe-package :wk "package")

   "q w" #'(delete-window :wk "window")
   "q b" #'(kill-this-buffer :wk "buffer")
   "q q" #'(save-buffers-kill-terminal :wk "really quit?")

   "w d" #'(delete-window :wk "delete")
   "w D" #'(kill-buffer-and-window :wk "delete with buffer")
   "w s" #'(split-window-below :wk "split below")
   "w v" #'(split-window-right :wk "split right")
   "w =" #'(balance-windows :wk "balance")

   "b b" #'(switch-to-buffer :wk "open")
   "b B" #'(switch-to-buffer :wk "open")
   "b d" #'(kill-this-buffer :wk "delete")
   "b D" #'(kill-buffer-and-window :wk "delete with window")
   "b r" #'(revert-buffer :wk "revert")
   "b s" #'(open-scratch-buffer :wk "scratch")
   "b m" #'(view-echo-area-messages :wk "messages")

   ";" #'eval-expression)

  ;; Unbind SPC in Dired mode
  ;; Dired takes precendence for the ~SPC~ key. Don't like that
  (general-define-key
   :states 'normal
   :keymaps 'dired-mode-map
   "SPC" nil))

(use-package evil
  :straight t
  :functions undo-tree
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-integration t)
  (setq evil-undo-system 'undo-tree)
  (setq evil-lookup-func #'eldoc)

  :config
  (defun pg/scroll-line-to-center ()
    (interactive)
    (evil-scroll-line-to-center 0))
  
  ;; Center buffer on point when jumping between sections
  (advice-add 'evil-forward-section-begin
              :after #'evil-scroll-line-to-center)
  (advice-add 'evil-backward-section-begin
              :after #'evil-scroll-line-to-center)

  (pg/leader
    :states 'normal
    "b p" #'(evil-prev-buffer :wk "previous")
    "b n" #'(evil-next-buffer :wk "next")
    "b N" #'(evil-buffer-new :wk "new")
    "`" #'(toggle-maximize-buffer :wk "fullscreen"))

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
   "C-<tab>" #'evil-switch-to-windows-last-buffer)

  (evil-mode 1))

(use-package evil-surround
  :straight t
  :after evil
  :init
  (global-evil-surround-mode 1))

(use-package evil-collection
  :straight t
  :after evil
  :init
  (setq evil-collection-outline-bind-tab-p t)
  :config
  (evil-collection-init))

(use-package evil-nerd-commenter
  :straight t
  :init
  (evilnc-default-hotkeys)
  :general
  ("C-:" #'evilnc-copy-and-comment-lines))

(provide 'pg-keybinds)
;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

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

(defun pg/erase-buffer ()
  (interactive)
  (if buffer-read-only
      (when (yes-or-no-p "Buffer is read-only. Erase anyway?")
        (let ((inhibit-read-only t))
          (erase-buffer)))
    (erase-buffer)))

(use-package which-key
  :config
  (setq which-key-idle-delay 1)
  (which-key-mode 1))

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-integration t)
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

  (evil-set-leader 'normal (kbd "SPC"))

  (evil-define-key* 'normal 'global
    (kbd "<leader> m") (cons "local" (make-sparse-keymap))
    (kbd "<leader> s") (cons "search" (make-sparse-keymap))
    (kbd "<leader> c") (cons "code" (make-sparse-keymap))
    (kbd "<leader> p") (cons "project" (make-sparse-keymap))
    (kbd "<leader> o") (cons "open" (make-sparse-keymap))
    (kbd "<leader> t") (cons "toggle" (make-sparse-keymap))
    (kbd "<leader> f") (cons "file" (make-sparse-keymap))
    (kbd "<leader> h") (cons "help" (make-sparse-keymap))
    (kbd "<leader> q") (cons "quit" (make-sparse-keymap))
    (kbd "<leader> w") (cons "window" (make-sparse-keymap))
    (kbd "<leader> b") (cons "buffer" (make-sparse-keymap))
    (kbd "<leader> g") (cons "git" (make-sparse-keymap)))

  (evil-define-key* 'normal 'global
    (kbd "<leader> b p") #'("previous" . evil-prev-buffer)
    (kbd "<leader> b n") #'("next" . evil-next-buffer)
    (kbd "<leader> b N") #'("new" . evil-buffer-new)
    (kbd "<leader> b e") #'("erase" . pg/erase-buffer))

  (evil-define-key* 'normal 'global
    (kbd "<leader> `") #'("fullscreen" . toggle-maximize-buffer))

  (evil-define-key '(normal insert visual motion) 'global
    (kbd "M-u") #'universal-argument)

  (evil-define-key* 'normal 'global
    (kbd "M-j") #'move-line-down
    (kbd "M-k") #'move-line-up
    (kbd "C-j") #'evil-forward-section-begin
    (kbd "C-k") #'evil-backward-section-begin)

  ;; I often press =C-w C-h= to go left (for example) instead of =C-w h= so I'll just bind both.
  (evil-define-key* '(normal insert) 'global
    (kbd "C-w") (make-sparse-keymap)
    (kbd "C-w C-h") #'evil-window-left
    (kbd "C-w C-j") #'evil-window-down
    (kbd "C-w C-k") #'evil-window-up
    (kbd "C-w C-l") #'evil-window-right
    (kbd "C-<tab>") #'evil-switch-to-windows-last-buffer)

  ;; (evil-define-key* '(normal insert) 'global
  ;;  "C-a" '(:ignore t :wk "avy")
  ;;  "C-a w" #'ace-window
  ;;  "C-a W" #'ace-swap-window
  ;;  "C-a l" #'evil-avy-goto-line
  ;;  "C-a c" #'evil-avy-goto-char)

  (evil-define-key* 'normal 'global
    (kbd "<leader> b b") #'("open" . switch-to-buffer)
    (kbd "<leader> b B") #'("open" . switch-to-buffer)
    (kbd "<leader> b d") #'("delete" . kill-this-buffer)
    (kbd "<leader> b D") #'("delete with window" . kill-buffer-and-window)
    (kbd "<leader> b r") #'("revert" . revert-buffer)
    (kbd "<leader> b s") #'("scratch" . open-scratch-buffer)
    (kbd "<leader> b m") #'("messages" . view-echo-area-messages))

  (evil-define-key* 'normal 'global
    (kbd "<leader> t f") #'("fill-column" . display-fill-column-indicator-mode)
    (kbd "<leader> t n") #'("line numbers" . display-line-numbers-mode)
    (kbd "<leader> t w") #'("whitespace" . whitespace-mode)
    (kbd "<leader> t d") #'("debug on error" . toggle-debug-on-error))

  (evil-define-key* 'normal 'global
    (kbd "<leader> f f") #'("find" . find-file)
    (kbd "<leader> f s") #'("save" . save-buffer)
    (kbd "<leader> f S") #'("save all" . save-all-buffers)
    (kbd "<leader> f .") #'("this" . find-file-at-point)
    (kbd "<leader> f m") #'("module" . pg/open-module))

  (evil-define-key* 'normal 'global
    (kbd "<leader> h k") #'("key" . describe-key)
    (kbd "<leader> h p") #'("package" . describe-package))

  (evil-define-key* 'normal 'global
    (kbd "<leader> q w") #'("window" . delete-window)
    (kbd "<leader> q b") #'("buffer" . kill-this-buffer)
    (kbd "<leader> q q") #'("really quit?" . save-buffers-kill-terminal))

  (evil-define-key* 'normal 'global
    (kbd "<leader> w d") #'("delete" . delete-window)
    (kbd "<leader> w D") #'("delete with buffer" . kill-buffer-and-window)
    (kbd "<leader> w s") #'("split below" . split-window-below)
    (kbd "<leader> w v") #'("split right" . split-window-right)
    (kbd "<leader> w =") #'("balance" . balance-windows)
    (kbd "<leader> w a") #'("ace-swap" . ace-swap-window))

  (evil-define-key* 'normal 'global
    (kbd "<leader> y") #'yank-whole-buffer
    (kbd "<leader> ;") #'eval-expression)

  (evil-define-key 'normal 'global
    (kbd "<leader> k j") #'evil-jump-forward
    (kbd "<leader> j k") #'evil-jump-backward)

  (evil-mode 1))

(use-package evil-surround
  :after evil
  :init
  (global-evil-surround-mode 1))

(use-package evil-collection
  :after evil
  :init
  (setq evil-collection-outline-bind-tab-p t)
  (setq evil-collection-want-unimpaired-p nil)
  (setq evil-collection-setup-minibuffer t)
  (setq evil-collection-calendar-want-org-bindings t)
  :config
  (evil-collection-init))

(use-package evil-nerd-commenter
  :config
  (evilnc-default-hotkeys)
  (evil-define-key* '(normal insert) 'global
   (kbd "C-:") #'evilnc-copy-and-comment-lines))

(use-package expand-region
  :config
  (evil-define-key* 'visual 'global
   (kbd "v") #'er/expand-region
   (kbd "V") (lambda () (interactive) (er/expand-region 2))))

(provide 'pg-keybinds)

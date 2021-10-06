(require 'pg-straight)
(require 'pg-basics)

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
  
  (defun open-scratch-buffer ()
      (interactive)
      (switch-to-buffer "*scratch*"))
  
  (pg/leader
     "m" '(:which-key "local")
     "s" '(:which-key "search")
     "c" '(:which-key "code")
     "p" '(:which-key "project")
  
     "o" '(:which-key "open")
     "o s" #'(open-scratch-buffer :which-key "scratch")
  
     "t" '(:which-key "toggle")
     "t f" #'(display-fill-column-indicator-mode :which-key "fill-column")
     "t n" #'(display-line-numbers-mode :which-key "line numbers")
     "t w" #'(whitespace-mode :which-key "whitespace")
  
     "f" '(:which-key "file")
     "f f" #'(find-file :which-key "find")
     "f s" #'(save-buffer :which-key "save")
     "f ." #'(find-file-at-point :which-key "this")
     "f m" #'(pg/open-module :which-key "module")
  
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
  
  ;; Unbind SPC in Dired mode
  ;; Dired takes precendence for the ~SPC~ key. Don't like that
  (general-define-key
     :states 'normal
     :keymaps 'dired-mode-map
     "SPC" nil))

(provide 'pg-keybinds)

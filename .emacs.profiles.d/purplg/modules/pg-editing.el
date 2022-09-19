;;; --- -*- lexical-binding: t; -*-

;; Disable global eldoc mode. I prefer an explicit keypress
(global-eldoc-mode -1)
(general-define-key
  :states '(normal insert visual)
  :keymaps 'prog-mode-map
  "S-k" #'eldoc)

(setq initial-major-mode 'emacs-lisp-mode)
(setq initial-scratch-message nil)
(setq auto-save-default nil) 
(setq vc-follow-symlinks t)
(setq-default fill-column 100)

;; Don't move point to cursor when right-clicking to paste.
(setq mouse-yank-at-point t)


;; Tooling
(use-package aggressive-indent
  :straight t)

(use-package expand-region
  :straight t
  :config
  (general-define-key
   :states 'visual
   "v" #'er/expand-region
   "V" (lambda () (interactive) (er/expand-region 2))))

(use-package auto-highlight-symbol
  :straight t
  :hook (prog-mode . auto-highlight-symbol-mode)
  :init
  (setq ahs-idle-interval 0.5))

(use-package just-mode
  :straight t)

(require 'pg-flycheck)
(require 'pg-folding)
(require 'pg-git)
(require 'pg-lsp)
(require 'pg-projects)
(require 'pg-restclient)
(require 'pg-snippets)
(require 'pg-undo)


;; Languages
(require 'pg-csharp)
(require 'pg-docker)
(require 'pg-elisp)
(require 'pg-lua)
(require 'pg-python)
(require 'pg-qml)
(require 'pg-rust)
(require 'pg-vim)
(require 'pg-yaml)
(require 'pg-web)

(provide 'pg-editing)

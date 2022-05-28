;;; --- -*- lexical-binding: t; -*-

;; Disable global eldoc mode. I prefer an explicit keypress
(global-eldoc-mode -1)
(general-define-key
  :states '(normal insert visual)
  :keymaps 'prog-mode-map
  "S-k" #'eldoc)

(setq initial-major-mode 'emacs-lisp-mode)
(setq initial-scratch-message nil)
(setq auto-save-default nil) ;; No autosave
(setq vc-follow-symlinks t)
(setq-default fill-column 100) ;; Wrap text at 100 characters

(setq mouse-yank-at-point t)

(use-package expand-region
  :straight t
  :config
  (general-define-key
   :states 'visual
   "v" #'er/expand-region
   "V" (lambda () (interactive) (er/expand-region 2))))

(require 'pg-lsp)
(require 'pg-git)

(require 'pg-docker)
(require 'pg-flycheck)
(require 'pg-folding)
(require 'pg-indent-guides)
(require 'pg-line-numbers)
(require 'pg-projects)
(require 'pg-restclient)
(require 'pg-snippets)
(require 'pg-vim)

(require 'pg-elisp)
(require 'pg-lua)
(require 'pg-python)
(require 'pg-rust)
(require 'pg-yaml)

(provide 'pg-editing)

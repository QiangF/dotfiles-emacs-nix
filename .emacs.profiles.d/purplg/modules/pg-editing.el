;;; --- -*- lexical-binding: t; -*-

(setq initial-major-mode 'emacs-lisp-mode)
(setq initial-scratch-message nil)
(setq auto-save-default nil) ;; No autosave
(setq vc-follow-symlinks t)
(setq-default fill-column 100) ;; Wrap text at 100 characters

(use-package expand-region
  :config
  (general-define-key
   :states 'visual
   "v" #'er/expand-region
   "V" (lambda () (interactive) (er/expand-region 2))))

(setq compilation-scroll-output t)

(require 'pg-elisp)
(require 'pg-flycheck)
(require 'pg-folding)
(require 'pg-git)
(require 'pg-indent-guides)
(require 'pg-line-numbers)
(require 'pg-lsp)
(require 'pg-outshine)
(require 'pg-projects)
(require 'pg-rust)
(require 'pg-restclient)
(require 'pg-snippets)
(require 'pg-yaml)

(provide 'pg-editing)

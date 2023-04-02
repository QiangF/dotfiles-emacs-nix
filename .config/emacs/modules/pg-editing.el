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
(use-package expand-region
  :config
  (general-define-key
   :states 'visual
   "v" #'er/expand-region
   "V" (lambda () (interactive) (er/expand-region 2))))

(use-package auto-highlight-symbol
  :hook (prog-mode . auto-highlight-symbol-mode)
  :init
  (setq ahs-idle-interval 0.5))

(use-package just-mode)

(pg/leader
  :states '(normal visual)
  "t s" #'scroll-all-mode)

(use-package puni
  :hook (prog-mode . puni-mode)
  :init
  (defun pg/puni-change-line ()
    (interactive)
    (puni-kill-line)
    (evil-insert 0))

  (evil-define-key* 'normal puni-mode-map
    (kbd "C") #'pg/puni-change-line
    (kbd "D") #'puni-kill-line
    (kbd "M-h") #'puni-barf-forward
    (kbd "M-l") #'puni-slurp-forward
    (kbd "M-d") #'puni-kill-line))

(use-package gitignore-templates
  :init
  (setq gitignore-templates-api 'github))

(use-package jinx
  :hook
  (org-mode . jinx-mode)
  (markdown-mode . jinx-mode)
  (text-mode . jinx-mode))

(use-package markdown-mode
  :init
  (add-hook 'markdown-mode-hook
            (lambda ()
              (setq visual-fill-column-center-text t)
              (setq visual-fill-column-fringes-outside-margins nil)
              (visual-fill-column-mode t))))

(require 'pg-environment)
(require 'pg-flycheck)
(require 'pg-folding)
(require 'pg-git)
(require 'pg-lsp)
(require 'pg-projects)
(require 'pg-restclient)
(require 'pg-snippets)
(require 'pg-sqlite)
(require 'pg-treesitter)
(require 'pg-undo)


;; Languages
(require 'pg-csharp)
(require 'pg-docker)
(require 'pg-elisp)
(require 'pg-json)
(require 'pg-lua)
(require 'pg-nix)
(require 'pg-python)
(require 'pg-qml)
(require 'pg-rust)
(require 'pg-vim)
(require 'pg-web)
(require 'pg-yaml)

(provide 'pg-editing)

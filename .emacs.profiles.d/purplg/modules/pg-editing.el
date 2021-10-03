(add-to-list 'load-path (expand-file-name "editing/" pg/module-dir))

(require 'pg-elisp)
(require 'pg-folding)
(require 'pg-git)
(require 'pg-indent-guides)
(require 'pg-line-numbers)
(require 'pg-lsp)
(require 'pg-projects)
(require 'pg-rust)
(require 'pg-snippets)
(require 'pg-undo)
(require 'pg-yaml)

(require 'pg-straight)
(require 'pg-basics)
(require 'pg-keybinds)

(setq auto-save-default nil) ;; No autosave
(setq-default fill-column 100) ;; Wrap text at 100 characters

(use-package company
  :straight t)

(use-package flycheck
  :straight t
  :config
  (hook! 'lsp-mode-hook #'flycheck-mode))

(use-package restclient
  :straight t)

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
(advice-add 'evil-open-fold :around #'save-excursion-wrapper)

(general-define-key
  :states 'normal
  "z c" #'evil-close-fold-below
  "z C" #'evil-close-fold)

(general-define-key 
  :states 'normal
  :keymaps 'prog-mode-map
  "C-[" #'previous-error
  "C-]" #'next-error)

(provide 'pg-editing)

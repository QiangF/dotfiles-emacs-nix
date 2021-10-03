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

(provide 'pg-editing)

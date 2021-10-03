(add-to-list 'load-path (expand-file-name "editing/" pg/module-dir))

(require 'pg-company)
(require 'pg-elisp)
(require 'pg-flycheck)
(require 'pg-folding)
(require 'pg-git)
(require 'pg-indent-guides)
(require 'pg-line-numbers)
(require 'pg-lsp)
(require 'pg-projects)
(require 'pg-rust)
(require 'pg-restclient)
(require 'pg-snippets)
(require 'pg-yaml)

(setq auto-save-default nil) ;; No autosave
(setq-default fill-column 100) ;; Wrap text at 100 characters

(provide 'pg-editing)

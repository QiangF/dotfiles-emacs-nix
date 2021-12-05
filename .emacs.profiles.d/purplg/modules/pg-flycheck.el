;;; --- -*- lexical-binding: t; -*-
(require 'pg-lsp)

(use-package flycheck
  :config
  (hook! 'lsp-mode-hook #'flycheck-mode)
  (general-define-key
   :states 'normal
   "M-h" #'(flycheck-previous-error :wk "prev error")
   "M-l" #'(flycheck-next-error :wk "next error")))
 

(provide 'pg-flycheck)

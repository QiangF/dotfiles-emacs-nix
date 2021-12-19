;;; --- -*- lexical-binding: t; -*-
(require 'pg-lsp)

(use-package flycheck
  :disabled
  :config
  (hook! 'lsp-mode-hook #'flycheck-mode)
  (general-define-key
   :states 'normal
   "M-h" #'(flycheck-previous-error :wk "prev error")
   "M-l" #'(flycheck-next-error :wk "next error")))
 
(use-package flymake
  :config
  (general-define-key
   :states 'normal
   "M-k" #'(flymake-goto-prev-error :wk "prev error")
   "M-j" #'(flymake-goto-next-error :wk "next error")))

(provide 'pg-flycheck)

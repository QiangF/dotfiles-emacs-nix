;;; --- -*- lexical-binding: t; -*-
(require 'pg-lsp)

(use-package flycheck
  :disabled
  :straight t
  :config
  (add-hook 'lsp-mode-hook #'flycheck-mode)
  (general-define-key
   :states 'normal
   "M-h" #'(flycheck-previous-error :wk "prev error")
   "M-l" #'(flycheck-next-error :wk "next error")))
 
(use-package flymake
  :straight t
  :init
  (add-hook 'prog-mode #'flymake-mode)

  :config
  (general-define-key
   :states 'normal
   "M-k" #'(flymake-goto-prev-error :wk "prev error")
   "M-j" #'(flymake-goto-next-error :wk "next error")))

(provide 'pg-flycheck)

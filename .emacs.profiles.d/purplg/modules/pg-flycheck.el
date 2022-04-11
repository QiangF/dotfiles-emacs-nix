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
  :hook (prog-mode . flymake-mode)

  :config
  (setq elisp-flymake-byte-compile-load-path load-path)
  (general-define-key
   :states 'normal
   "M-k" #'(flymake-goto-prev-error :wk "prev error")
   "M-j" #'(flymake-goto-next-error :wk "next error")))

(provide 'pg-flycheck)

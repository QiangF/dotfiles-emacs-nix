;;; --- -*- lexical-binding: t; -*-
(require 'pg-lsp)

(use-package flycheck
  :config
  (add-hook 'lsp-mode-hook #'flycheck-mode)
  (general-define-key
   :keymaps 'flycheck-mode-map
   :states 'normal
   "M-k" #'(flycheck-previous-error :wk "prev error")
   "M-j" #'(flycheck-next-error :wk "next error")))
 
(use-package flymake
  :hook (eglot--managed-mode . flymake-mode)
  :config
  (setq elisp-flymake-byte-compile-load-path load-path)
  (general-define-key
   :keymaps 'flymake-mode-map
   :states 'normal
   "M-k" #'(flymake-goto-prev-error :wk "prev error")
   "M-j" #'(flymake-goto-next-error :wk "next error")))

(provide 'pg-flycheck)

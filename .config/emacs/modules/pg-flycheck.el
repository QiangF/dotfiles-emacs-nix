;;; --- -*- lexical-binding: t; -*-
(require 'pg-lsp)

(use-package flycheck
  :config
  (add-hook 'lsp-mode-hook #'flycheck-mode)
  (evil-define-key* 'normal flycheck-mode-map
   (kbd "M-k") #'(flycheck-previous-error :wk "prev error")
   (kbd "M-j") #'(flycheck-next-error :wk "next error")))
 
(use-package flymake
  :disabled
  :hook (eglot--managed-mode . flymake-mode)
  :config
  (setq elisp-flymake-byte-compile-load-path load-path)
  (evil-define-key* 'normal flymake-mode-map
   (kbd "M-k") #'(flymake-goto-prev-error :wk "prev error")
   (kbd "M-j") #'(flymake-goto-next-error :wk "next error")))

(provide 'pg-flycheck)

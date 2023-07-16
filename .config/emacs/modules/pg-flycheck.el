;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)
(require 'pg-lsp)

(use-package flycheck
  :disabled
  :config
  (add-hook 'lsp-mode-hook #'flycheck-mode)
  (evil-define-key* 'normal flycheck-mode-map
   (kbd "M-k") #'("prev error" . flycheck-previous-error)
   (kbd "M-j") #'("next error" . flycheck-next-error)))
 
(use-package flymake
  :config
  (setq elisp-flymake-byte-compile-load-path load-path)
  (evil-define-key* 'normal flymake-mode-map
   (kbd "M-k") #'("prev error" . flymake-goto-prev-error)
   (kbd "M-j") #'("next error" . flymake-goto-next-error)))

(provide 'pg-flycheck)

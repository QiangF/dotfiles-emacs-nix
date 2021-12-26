;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package elisp-mode
   :after corfu
   :init
   (add-hook 'emacs-lisp-mode-hook #'corfu-mode))

(use-package rainbow-delimiters
  :config
  (hook! 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

(use-package parinfer-rust-mode
  :hook emacs-lisp-mode
  :init
  (setq parinfer-rust-auto-download t)
  
  :config
  (hook! 'parinfer-rust-mode-hook
         (lambda ()
           (electric-indent-mode 0)
           (indent-tabs-mode 0)))

  (pg/local-leader
   :keymaps 'emacs-lisp-mode-map
   "p" #'(parinfer-rust-toggle-paren-mode :wk "parinfer-toggle")))

(pg/leader
 :keymaps 'emacs-lisp-mode-map
 "e" '(:wk "eval")
 "e b" #'(eval-buffer :wk "buffer")
 "e f" #'(eval-defun :wk "function")
 "b c" #'(emacs-lisp-byte-compile-and-load :wk "compile and load"))

(pg/leader
 :states 'visual
 :keymaps 'emacs-lisp-mode-map
 "e" '(:wk "eval")
 "e r" #'(eval-region :wk "region"))

(use-package package-lint)

(use-package flycheck-package)

(use-package buttercup)

(use-package cask-mode :after emacs-lisp-mode)

(provide 'pg-elisp)

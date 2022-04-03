;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package elisp-mode
  :config
  (add-hook 'emacs-lisp-mode-hook (lambda () (setq indent-tabs-mode nil)))
  (pg/leader
      :keymaps 'emacs-lisp-mode-map
      "e" '(:wk "eval")
      "e b" #'(eval-buffer :wk "buffer")
      "e f" #'(eval-defun :wk "function")
      "e s" #'(eval-last-sexp :wk "sexp")
      "b c" #'(emacs-lisp-byte-compile-and-load :wk "compile and load"))

  (pg/leader
   :states 'visual
   :keymaps 'emacs-lisp-mode-map
   "e" '(:wk "eval")
   "e r" #'(eval-region :wk "region")))

(use-package rainbow-delimiters
  :after elisp-mode
  :straight t
  :init
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

(use-package lispy
  :straight t
  :after elisp-mode
  :init
  (add-hook 'emacs-lisp-mode-hook #'lispy-mode))

(use-package parinfer-rust-mode
  :straight t
  :after elisp-mode
  :init
  (setq parinfer-rust-auto-download t)
  
  (add-hook 'parinfer-rust-mode-hook
    (lambda ()
      (electric-indent-mode 0)))

  (add-hook 'emacs-lisp-mode-hook #'parinfer-rust-mode)

  :config
  (pg/local-leader
   :keymaps 'emacs-lisp-mode-map
   "p" #'(parinfer-rust-toggle-paren-mode :wk "parinfer-toggle")))

(use-package package-lint
  :straight t
  :after elisp-mode)

(use-package flycheck-package
  :straight t
  :after elisp-mode)

(use-package cask-mode
  :straight t
  :after elisp-mode)

(provide 'pg-elisp)

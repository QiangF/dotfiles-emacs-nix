;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package elisp-mode
  :straight nil
  :config
  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)
              (setq fill-column 80)
              (outline-minor-mode 1)))
  (add-hook 'emacs-lisp-mode-hook #'electric-pair-mode)

  (with-eval-after-load 'hs-minor-mode
    (add-hook 'emacs-lisp-mode-hook
              (lambda () (hs-hide-level 1))))

  (pg/leader
    :keymaps 'emacs-lisp-mode-map
    "e" '(:ignore t :wk "eval")
    "c" '(:ignore t :wk "code")
    "c e" #'(emacs-lisp-macroexpand :wk "expand")
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
  :hook (emacs-lisp-mode . rainbow-delimiters-mode))

(use-package lispy
  :after elisp-mode
  :hook (emacs-lisp-mode . lispy-mode)
  :init
  (setq lispy-eval-display-style 'message))

(use-package lispyville
  :hook (emacs-lisp-mode . lispyville-mode))

(use-package parinfer-rust-mode
  :disabled
  :after elisp-mode
  :hook (emacs-lisp-mode . parinfer-rust-mode)
  :init
  (setq parinfer-rust-auto-download t)

  (add-hook 'parinfer-rust-mode-hook
    (lambda ()
      (electric-indent-mode 0)))

  :config
  (pg/local-leader
   :keymaps 'emacs-lisp-mode-map
   "p" #'(parinfer-rust-toggle-paren-mode :wk "parinfer-toggle")))

(use-package package-lint
  :defer t
  :after elisp-mode)

(use-package flycheck-package
  :defer t
  :after elisp-mode)

(use-package cask-mode
  :defer t
  :after elisp-mode)

(use-package erefactor
  :straight (:type git :host github :repo "mhayashi1120/Emacs-erefactor")
  :hook (emacs-lisp-mode . erefactor-lazy-highlight-turn-on)
  :init
  (pg/leader
    :keymap 'erefactor-map
    :states 'normal
    "c r" #'(erefactor-rename-symbol-in-buffer :wk "rename")))

(provide 'pg-elisp)

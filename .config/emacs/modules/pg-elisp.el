;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package elisp-mode
  :elpaca nil
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

  (with-eval-after-load 'evil
    (evil-define-key* 'normal emacs-lisp-mode-map
      (kbd "<leader> c e") #'("expand" . emacs-lisp-macroexpand)
      (kbd "<leader> e b") #'("buffer" . eval-buffer)
      (kbd "<leader> e f") #'("function" . eval-defun)
      (kbd "<leader> e s") #'("sexp" . eval-last-sexp)
      (kbd "<leader> b c") #'("compile and load" . emacs-lisp-byte-compile-and-load))

    (evil-define-key* 'visual emacs-lisp-mode-map
      (kbd "<leader> e r") #'("region" . eval-region))))

(use-package rainbow-delimiters
  :after elisp-mode
  :hook (emacs-lisp-mode . rainbow-delimiters-mode))

(use-package lispy
  :after elisp-mode
  :hook (emacs-lisp-mode . lispy-mode)
        (lisp-data-mode . lispy-mode)
        (cask-mode . lispy-mode)
  :init
  (setq lispy-eval-display-style 'message))

(use-package lispyville
  :hook (emacs-lisp-mode . lispyville-mode))

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
  :elpaca (:type git :host github :repo "mhayashi1120/Emacs-erefactor")
  :hook (emacs-lisp-mode . erefactor-lazy-highlight-turn-on)
  :init
  (evil-define-key* 'normal emacs-lisp-mode-map
    (kbd "<leader> c r") #'("rename" . erefactor-rename-symbol-in-buffer)))

(provide 'pg-elisp)

;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

;; Disable global eldoc mode. I prefer an explicit keypress
(global-eldoc-mode -1)
(with-eval-after-load 'evil
  (evil-define-key* '(normal insert visual) prog-mode-map
    (kbd "S-k") #'eldoc))

(setq initial-major-mode 'emacs-lisp-mode)
(setq initial-scratch-message nil)
(setq auto-save-default nil) 
(setq vc-follow-symlinks t)
(setq-default fill-column 100)

;; Don't move point to cursor when right-clicking to paste.
(setq mouse-yank-at-point t)

;; Max width
(with-eval-after-load 'visual-fill-column
  (dolist (hook '(text-mode-hook prog-mode-hook))
    (add-hook hook
              (lambda ()
                (setq visual-fill-column-width 150)
                (setq visual-fill-column-center-text t)
                (setq visual-fill-column-fringes-outside-margins nil)
                (visual-fill-column-mode)))))

(with-eval-after-load 'evil
  (evil-define-key '(normal visual) 'global
    (kbd "<leader> t s") #'scroll-all-mode))

(provide 'pg-editing)

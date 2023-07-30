;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)
(require 'pg-keybinds)

(use-package hideshow
  :elpaca nil
  :hook (prog-mode . hs-minor-mode)
  :init
  (setq hs-allow-nesting t)

  (with-eval-after-load 'evil
    (defun evil-close-fold-below ()
      "Close fold on current line instead of enclosing block at point"
      (interactive)
      (save-excursion
        (end-of-line)
        (evil-close-fold)))

    (evil-define-key* 'normal 'global
     (kbd "z c") #'evil-close-fold-below
     (kbd "z m") #'hs-hide-level
     (kbd "z C") #'evil-close-fold)

    ;; Keep cursor in place when opening a fold
    (advice-add #'evil-open-fold
                :around (lambda (inner &rest _)
                          (save-excursion (funcall inner))))))

(use-package origami
  :disabled
  :straight (:type git :host github :repo "elp-revive/origami.el")
  :hook (prog-mode . origami-mode))

(provide 'pg-folding)

;;; --- -*- lexical-binding: t; -*-

(defvar current-theme nil)

(defun set-theme (theme-name)
  (setq current-theme theme-name)
  (load-theme current-theme t))

(use-package modus-themes
  :disabled
  :bind ("<f5>" . modus-themes-toggle)
  :config
  (advice-add 'modus-themes-toggle
              :after
              (lambda (&rest _) (setq current-theme (modus-themes--current-theme)))))

(use-package ef-themes
  :disabled
  :init
  (set-theme 'ef-winter)
  (with-eval-after-load 'auto-highlight-symbol
    (let ((set-ahs-faces
           (lambda ()
             ;; Set inner border for symbol highlights
             (set-face-attribute 'ahs-face nil
                                 :box `(:line-width (-1 . -1)
                                                    :color ,(face-attribute 'cursor :background) ;; Set the border color the same as the cursor
                                                    :style nil)
                                 :background 'unspecified :foreground 'unspecified)

             ;; Make the highlight at point look the same as any highlight.
             (set-face-attribute 'ahs-plugin-default-face nil
                                 :background 'unspecified
                                 :foreground 'unspecified)

             ;; Do not show any symbol highlights when buffer isn't focused
             (set-face-attribute 'ahs-face-unfocused nil
                                 :box nil)

             (set-face-attribute 'ahs-plugin-default-face-unfocused nil
                                 :background 'unspecified
                                 :foreground 'unspecified))))
      (funcall set-ahs-faces)
      (add-hook 'server-after-make-frame-hook set-ahs-faces)))

  (with-eval-after-load 'hl-line
    (set-face-background 'hl-line "#150f1e")))

(use-package org-modern
  :hook (org-mode . org-modern-mode))

(use-package doom-themes
  :init
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)
  (set-theme 'doom-monokai-pro))

(provide 'pg-theme)

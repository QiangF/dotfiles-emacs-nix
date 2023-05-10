;;; --- -*- lexical-binding: t; -*-

(defvar current-theme nil)
(defvar theme-dark nil)
(defvar theme-light nil)

(defvar after-theme-set-hook '())

(add-hook 'server-after-make-frame-hook
          (lambda () (run-hooks 'after-theme-set-hook)))

(with-eval-after-load 'hl-line
(add-hook 'after-theme-set-hook
            (lambda ()
              (set-face-background
               'hl-line
               (pcase current-theme
                 ('ef-light (color-darken-name (face-background 'default) 5))
                 ('ef-winter (color-lighten-name (face-background 'default) 50))
                 ('modus-vivendi (color-lighten-name (face-background 'default) 10)))))))

(defun set-theme (theme-name)
  (setq current-theme theme-name)
  (load-theme current-theme t)
  (run-hooks 'after-theme-set-hook))

(defun toggle-theme ()
    (interactive)
    (if (eq pg/theme-light current-theme)
        (set-theme pg/theme-dark)
      (set-theme pg/theme-light)))

(use-package modus-themes
  :disabled
  :bind ("<f5>" . modus-themes-toggle)
  :init
  (set-theme 'modus-vivendi-tinted)
  (setq pg/theme-dark 'modus-vivendi)
  (setq pg/theme-light 'modus-operandi)
  :config
  (advice-add 'modus-themes-toggle
              :after
              (lambda (&rest _)
                (run-hooks 'modus-themes-post-toggle-hook))))

(use-package ef-themes
  :bind ("<f5>" . toggle-theme)
  :init
  (set-theme 'ef-winter)
  (setq pg/theme-light 'ef-light)
  (setq pg/theme-dark 'ef-winter))

(use-package org-modern
  :hook (org-mode . org-modern-mode))

(use-package doom-themes
  :disabled
  :bind ("<f5>" . toggle-theme)
  :init
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)
  (set-theme 'doom-monokai-pro)
  (setq pg/theme-dark 'doom-monokai-pro)
  (setq pg/theme-light 'doom-acario-light))

(with-eval-after-load 'auto-highlight-symbol
  (defun pg/set-ahs-faces ()
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
                        :foreground 'unspecified))
  (pg/set-ahs-faces)
  (add-hook 'after-theme-set-hook #'pg/set-ahs-faces))

(provide 'pg-theme)

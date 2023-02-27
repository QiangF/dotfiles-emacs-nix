;;; --- -*- lexical-binding: t; -*-

(use-package visual-fill-column
  :demand t)

(use-package org-present
  :after visual-fill-column
  :init
  (require 'org-faces)
  (dolist (face '((org-level-1 . 1.0)
                  (org-level-2 . 1.0)
                  (org-level-3 . 1.0)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font "Iosevka Aile" :weight 'bold :height (cdr face)))

  (defun pg/org-present-start ()
    (org-modern-mode 0)
    (setq header-line-format nil)
    (org-display-inline-images)

    (setq org-link-descriptive t)
    (org-link-descriptive-ensure)

    (setq-local visual-fill-column-width 200)
    (setq-local visual-fill-column-center-text t)
    (visual-fill-column-mode 1)
    (setq-local face-remapping-alist '((default (:height 3.0) variable-pitch)
                                       (header-line (:height 1.0) variable-pitch)
                                       (org-code (:height 1.55) org-code)
                                       (org-verbatim (:height 1.2) org-verbatim)
                                       (org-block (:height 1.0) org-block)
                                       (org-block-begin-line (:height 0.7) org-block)))
    (org-present-read-only))
  
  (defun pg/org-present-end ()
    (setq header-line-format nil)
    (visual-fill-column-mode -1)
    (setq org-link-descriptive t)
    (org-link-descriptive-ensure)
    (setq-local face-remapping-alist nil)
    (org-modern-mode 1))

  (add-hook 'org-present-mode-hook #'pg/org-present-start)
  (add-hook 'org-present-mode-quit-hook #'pg/org-present-end)

  (setq visual-fill-column-mode 110)
  (setq visual-fill-column-center-text t)

  :config
  (defun org-present-toggle-cursor ()
    (interactive)
    (if (internal-show-cursor-p (get-buffer-window (current-buffer)))
        (org-present-hide-cursor)
      (org-present-show-cursor)))

  (defun org-present-toggle-big ()
    (interactive)
    (if text-scale-mode
        (org-present-small)
      (org-present-big)))

  (general-define-key
   :states 'normal
   :keymaps 'org-present-mode-keymap
   "SPC" nil
   "g g" #'org-previous-visible-heading)

  (pg/leader
    :states 'normal
    :keymaps 'org-present-mode-keymap
    "t c" #'(org-present-toggle-cursor :wk "cursor")
    "t b" #'(org-present-toggle-big :wk "big")))

(provide 'pg-present)

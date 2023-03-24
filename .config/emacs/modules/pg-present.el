;;; --- -*- lexical-binding: t; -*-

(use-package visual-fill-column
  :demand t)

(use-package org-present
  :straight (:type git :host github :repo "purplg/org-present" :branch "show-options-var")
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
  ;; (set-face-attribute 'org-block-begin-line nil :inherit 'unspecified :foreground "#00ff00" :background "#ff0000")

  ;; Show these options
  (defvar org-present-show-options '("title:" "author:" "date:" "email:"))
  (dolist (item '("name:" "begin_src" "end_src"))
    (add-to-list 'org-present-show-options item))

  (defun pg/org-present-start ()
    (org-modern-mode 0)
    (setq header-line-format nil)
    (org-display-inline-images)

    (setq org-link-descriptive t)
    (org-link-descriptive-ensure)

    (setq-local visual-fill-column-width 200)
    (setq-local visual-fill-column-center-text t)
    (setq-local scroll-margin 0)
    (visual-fill-column-mode 1)
    (setq-local face-remapping-alist `((default (:height 3.0) variable-pitch)
                                       (header-line (:height 1.0) variable-pitch)
                                       (org-code (:height 1.0) org-code)
                                       (org-verbatim (:height 1.0) org-verbatim)
                                       (org-block (:height 1.0) org-block)
                                       (org-block-begin-line (:height 1.0
                                                              :extend t
                                                              :foreground ,(face-foreground 'default)
                                                              :background ,(color-darken-name (face-background 'org-block) 10))
                                                              org-block)))
    (org-present-read-only))
  
  (defun pg/org-present-end ()
    (setq header-line-format nil)
    (visual-fill-column-mode -1)
    (setq org-link-descriptive t)
    (org-link-descriptive-ensure)
    (setq-local face-remapping-alist nil)
    (org-modern-mode 1))

  (defun pg/org-present-prepare-slide (buffer-name heading)
    ;; (org-overview)
    (org-fold-show-entry)
    (org-fold-show-children))

  (add-hook 'org-present-mode-hook #'pg/org-present-start)
  (add-hook 'org-present-mode-quit-hook #'pg/org-present-end)
  (add-hook 'org-present-after-navigate-functions #'pg/org-present-prepare-slide)

  (with-eval-after-load 'hide-mode-line
    (add-hook 'org-present-mode-hook #'turn-on-hide-mode-line-mode)
    (add-hook 'org-present-mode-quit-hook #'turn-off-hide-mode-line-mode))

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

  (defun org-present-next-heading ()
    (interactive)
    (call-interactively #'org-forward-heading-same-level)
    (call-interactively #'evil-scroll-line-to-top))

  (defun org-present-previous-heading ()
    (interactive)
    (call-interactively #'org-backward-heading-same-level)
    (call-interactively #'evil-scroll-line-to-top))
  
  (general-define-key
   :states 'normal
   :keymaps 'org-present-mode-keymap
   "SPC" nil
   "g g" (lambda () (interactive) (org-up-heading-all 99))
   "C-k" #'org-present-previous-heading
   "C-j" #'org-present-next-heading)

  (pg/leader
    :states 'normal
    :keymaps 'org-present-mode-keymap
    "t c" #'(org-present-toggle-cursor :wk "cursor")
    "t b" #'(org-present-toggle-big :wk "big")))

(use-package hide-mode-line)

(provide 'pg-present)

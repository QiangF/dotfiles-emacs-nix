;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package visual-fill-column
  :demand t)

(use-package org-present
  :elpaca (:type git :host github :repo "purplg/org-present" :branch "show-options-var")
  :after visual-fill-column
  :init
  (require 'org-faces)

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

    (setq-local visual-fill-column-width 150)
    (setq-local visual-fill-column-center-text t)
    (setq-local scroll-margin 0)
    (visual-fill-column-mode 1)
    (setq-local face-remapping-alist `((default (:height 3.0) variable-pitch)
                                       (header-line (:height 1.0) variable-pitch)
                                       (org-code (:height 1.0 :family "JetBrainsMono Nerd Font") org-code)
                                       (org-verbatim (:height 1.0 :family "Iosevka Aile") org-verbatim)
                                       (org-meta-line (:height 0.9) org-meta-line)
                                       (org-block (:height 1.0 :family "JetBrainsMono Nerd Font") org-block)
                                       (org-block-begin-line (:height 0.7
                                                              :extend t
                                                              :family "Iosevka Aile"
                                                              :foreground ,(color-darken-name (face-foreground 'default) 30)
                                                              :background ,(color-darken-name (face-background 'org-block) 30))
                                                             org-block))))
  
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
  
  (evil-define-key 'normal org-present-mode-keymap
   ;; "SPC" nil
   "g g" (lambda () (interactive) (org-up-heading-all 99))
   (kbd "C-k") #'org-present-previous-heading
   (kbd "C-j") #'org-present-next-heading)

  (evil-define-key* 'normal org-present-mode-keymap
    "<leader> t c" #'(org-present-toggle-cursor :wk "cursor")
    "<leader> t b" #'(org-present-toggle-big :wk "big")))

(use-package hide-mode-line)

(provide 'pg-present)

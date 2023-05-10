;;; --- -*- lexical-binding: t; -*-

;; Don't show startup page
(setq inhibit-startup-message t)

;; Use `y-or-n-p' instead of `yes-or-no-p'
(setq use-short-answers t)

(recentf-mode 1)

;; Fix scrolling so that it doesn't jump by pages
(setq scroll-conservatively 101)

;; Scroll buffer when point is 15 lines from edge of window
(setq scroll-margin 15)

(setq compilation-scroll-output t)

(add-to-list 'recentf-exclude (concat user-emacs-directory "bookmarks") t)

;; Highlight line of point
(add-hook 'prog-mode-hook #'hl-line-mode)

;; Scroll message buffer to bottom on update
(add-hook 'post-command-hook
  (lambda ()
    (let ((messages-buffer (get-buffer "*Messages*")))
      (unless (eq (current-buffer) messages-buffer)
        (with-current-buffer messages-buffer
          (goto-char (point-max)))))))

;; Prevent the scratch buffer from being deleted
(with-current-buffer "*scratch*" (emacs-lock-mode 'kill))

(defun pg/config-frame ()
  (setq frame-title-format "PurplEmacs")
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (set-fringe-mode 10)
  ;; SVG-LIB workaround
  ;; https://github.com/rougier/svg-lib/issues/18
  (with-eval-after-load 'svg-lib
    (setq svg-lib-style-default (svg-lib-style-compute-default))))

(pg/config-frame)
(add-hook 'server-after-make-frame-hook #'pg/config-frame)

(use-package hl-todo
  :init
  (add-hook 'prog-mode-hook #'hl-todo-mode))

(use-package share-path
  :elpaca (:type git :host nil :repo "https://codeberg.org/purplg/share-path.el")
  :init
  (share-path-mode 1))

(use-package rfc-mode
  :init
  (evil-define-key 'normal 'global
    (kbd "<leader> o r") #'("RFC" . rfc-mode-browse)))

(use-package auto-highlight-symbol
  :hook (prog-mode . auto-highlight-symbol-mode)
  :init
  (setq ahs-idle-interval 0.5))

(provide 'pg-interface)

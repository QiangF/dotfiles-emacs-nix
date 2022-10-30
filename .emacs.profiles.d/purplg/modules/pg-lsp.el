;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package eglot
  :disabled
  :straight t
  :defer t
  :config

  (with-eval-after-load 'rustic-mode
    (add-hook 'eglot-managed-mode-hook (lambda () (eldoc-mode -1))))

  (pg/leader
    :keymaps 'eglot-mode-map
    "c a" #'(eglot-code-actions :wk "execute action")
    "c r" #'(eglot-rename :wk "rename")))

(use-package lsp-mode
  :straight t
  :config
  (setq evil-lookup-func #'lsp-describe-thing-at-point)
  (setq lsp-auto-execute-action nil)

  (pg/leader
   :keymaps 'lsp-mode-map
   "c a" #'(lsp-execute-code-action :wk "execute action")
   "c r" #'(lsp-rename :wk "rename"))

  :general
  (:keymaps 'evil-motion-state-map
   "g D" #'lsp-find-references
   "g r" #'lsp-find-references)
  :init
  (setq lsp-enable-snippet nil))

(use-package lsp-ui
  :straight t
  :after lsp-mode
  :init
  (pg/leader
    :keymaps 'lsp-mode-map
    "o i" #'(lsp-ui-imenu :wk "imenu"))

  :config
  ;; recommended performance tweak
  (setq read-process-output-max (* 1024 1024))

  ;; Disable because it causes input lag
  (setq lsp-ui-doc-enable nil)

  (setq lsp-ui-sideline-show-hover t)

  (setq lsp-ui-sideline-delay 1.0)

  (setq lsp-ui-imenu-auto-refresh t)
  (setq lsp-ui-imenu-auto-refresh-delay 0.5)
  (setq lsp-ui-imenu-buffer-position 'left)

  :general
  (:keymaps 'lsp-ui-peek-mode-map
            "j" #'lsp-ui-peek--select-next
            "h" #'lsp-ui-peek--select-prev-file
            "l" #'lsp-ui-peek--select-next-file
            "k" #'lsp-ui-peek--select-prev
            "C-<return>" #'lsp-ui-peek--goto-xref-other-window))

(provide 'pg-lsp)

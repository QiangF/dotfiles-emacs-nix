;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package lsp-mode
  :config
  (setq evil-lookup-func #'lsp-describe-thing-at-point)

  (pg/leader
   :keymaps 'lsp-mode-map
   "c a" #'(lsp-execute-code-action :wk "execute action")
   "c f" #'(lsp-format-buffer :wk "format")
   "c r" #'(lsp-rename :wk "rename"))

  :general
  (:keymaps 'evil-motion-state-map
   "g D" #'lsp-find-references))

(use-package lsp-ui
  :after lsp-mode
  :config
  ;; recommended performance tweak
  (setq read-process-output-max (* 1024 1024))
  
  ;; Disable because it causes input lag
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-sideline-show-hover t)
  (setq lsp-ui-sideline-delay 1.0)

  :general
  (:keymaps 'lsp-ui-peek-mode-map
   "j" #'lsp-ui-peek--select-next
   "h" #'lsp-ui-peek--select-prev-file
   "l" #'lsp-ui-peek--select-next-file
   "k" #'lsp-ui-peek--select-prev
   "C-<return>" #'lsp-ui-peek--goto-xref-other-window))

(provide 'pg-lsp)

;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)
(require 'pg-keybinds)

(use-package eglot
  :init
  (setq eglot-stay-out-of '(eldoc))

  (with-eval-after-load 'corfu
    (add-hook 'eglot-managed-mode-hook #'corfu-mode))

  (add-hook 'eglot-managed-mode-hook (lambda () (flycheck-mode -1)))
  :config
  (evil-define-key* 'normal eglot-mode-map
    (kbd "<leader> c a") #'("execute action" . eglot-code-actions)
    (kbd "<leader> c r") #'("rename" . eglot-rename))

  (defun eglot-rename (newname)
    "Rename the current symbol to NEWNAME."
    (interactive
     (list (read-from-minibuffer
            (format "Rename `%s' to: " (or (thing-at-point 'symbol t)
                                           "unknown symbol"))
            (symbol-name (symbol-at-point))
            nil nil nil
            (symbol-name (symbol-at-point)))))
    (eglot--server-capable-or-lose :renameProvider)
    (eglot--apply-workspace-edit
     (eglot--request (eglot--current-server-or-lose)
                     :textDocument/rename `(,@(eglot--TextDocumentPositionParams)
                                            :newName ,newname))
     current-prefix-arg)))


(provide 'pg-lsp)

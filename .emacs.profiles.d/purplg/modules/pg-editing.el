;;; pg-editing.el --- -*- lexical-binding: t; -*-
(require 'pg-straight)
(require 'pg-config)
(require 'pg-basics)
(require 'pg-keybinds)

(defun pg/auto-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (file-truename pg/module-dir))
    (org-babel-tangle)
    (pg/compile-modules)))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'pg/auto-tangle-config)))

(setq-default display-line-numbers-type 'visual
              display-line-numbers-current-absolute t)

(use-package highlight-indent-guides
  :straight t
  :config
  (setq highlight-indent-guides-method 'column
        highlight-indent-guides-responsive 'top)
  (hook! 'prog-mode-hook #'highlight-indent-guides-mode))

(setq auto-save-default nil) ;; No autosave
(setq-default fill-column 100) ;; Wrap text at 100 characters

(hook! '(prog-mode-hook org-mode-hook) #'display-line-numbers-mode)

(use-package undo-fu
  :straight t)

(use-package undo-fu-session
  :straight t
  :after undo-fu
  :config
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
  (global-undo-fu-session-mode))

(use-package yasnippet-snippets
  :straight t)

(use-package yasnippet
  :after yasnippet-snippets
  :straight t
  :config
  (push (expand-file-name "snippets" pg/config-dir) yas-snippet-dirs)
  (yas-global-mode 1))

(use-package magit
  :straight t
  :config
  (pg/leader
    "g" '(:which-key "git")
    "g g" #'(magit-status :which-key "status")))

(use-package git-gutter
  :straight t

  :config
  (hook! 'prog-mode-hook #'git-gutter-mode))

(use-package company
  :straight t)

(use-package flycheck
  :straight t
  :config
  (hook! 'lsp-mode-hook #'flycheck-mode))

(use-package lsp-mode
  :straight t
  :config
  (setq evil-lookup-func #'lsp-describe-thing-at-point)

  (pg/leader
    :keymaps 'lsp-mode-map
    "c a" #'(lsp-execute-code-action :which-key "execute action")
    "c f" #'(lsp-format-buffer :which-key "format")
    "c r" #'(lsp-rename :which-key "rename"))

  :general
  (:keymaps 'evil-motion-state-map
    "g D" #'lsp-find-references))

(use-package lsp-ui
  :straight t
  :after lsp-mode
  :config
  ;; recommended performance tweaks
  (setq gc-cons-threshold 100000000
        read-process-output-max (* 1024 1024))
  
  ;; Disable because it causes input lag
  (setq lsp-ui-doc-enable nil
        lsp-ui-sideline-show-hover t)

  :general
  (:keymaps 'lsp-ui-peek-mode-map
    "j" #'lsp-ui-peek--select-next
    "h" #'lsp-ui-peek--select-prev-file
    "l" #'lsp-ui-peek--select-next-file
    "k" #'lsp-ui-peek--select-prev
    "C-<return>" #'lsp-ui-peek--goto-xref-other-window))

(use-package treemacs
  :demand t
  :straight t
  :init
  (pg/leader
    "o p" 'treemacs)

  :config
  (treemacs-resize-icons 16)
  (treemacs-set-width 30)
  :general
  (:states 'normal
   :keymaps 'treemacs-mode-map
   "C-j" #'treemacs-next-neighbour
   "C-k" #'treemacs-previous-neighbour
   "M-j" #'treemacs-move-project-down
   "M-k" #'treemacs-move-project-up))

(use-package treemacs-all-the-icons
  :straight t
  :after treemacs
  :config
  (treemacs-load-theme "all-the-icons"))

(use-package projectile
  :straight t
  :config
  (pg/leader
    "p f" #'(projectile-find-file :which-key "file")
    "p a" #'(projectile-add-known-project :which-key "add")
    "p d" #'(projectile-remove-known-project :which-key "remove")
    "p p" #'(projectile-switch-project :which-key "open"))
  (projectile-mode +1))

(use-package restclient
  :straight t)

(defun evil-close-fold-below ()
  "Close fold on current line instead of enclosing block at point"
  (interactive)
  (save-excursion
    (end-of-line)
    (evil-close-fold)))

(defun evil-open-fold-save ()
  "Keep point in place when opening fold"
  (interactive)
  (save-excursion
    (evil-open-fold)))

;; Keep cursor in place when opening a fold
(advice-add 'evil-open-fold :around #'save-excursion-wrapper)

(general-define-key
  :states 'normal
  "z c" #'evil-close-fold-below
  "z C" #'evil-close-fold)

(hook! 'prog-mode-hook #'hs-minor-mode)

(use-package tree-sitter
  :straight t)

(use-package tree-sitter-langs
  :straight t
  :after tree-sitter
  :config
  (hook! 'rustic-mode-hook #'tree-sitter-mode)
  (hook! 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package rustic
  :straight t

  :config
  (setq rustic-format-on-save nil
        rustic-lsp-format nil)

  (defun rustic-cargo-run-no-args () 
    (interactive)
    (rustic-run-cargo-command "cargo run"))
    
  (hook! 'rustic-mode-hook #'electric-indent-mode)

  (pg/local-leader
    :keymaps 'rustic-mode-map
    "c" '(:which-key "cargo")
    "c r" #'(rustic-cargo-run-no-args :which-key "run")
    "c R" #'(rustic-cargo-run :which-key "run w/ args")
    "c a" #'(rustic-cargo-add :which-key "add dep")
    "c x" #'(rustic-cargo-rm :which-key "rm dep")
    "c c" #'(rustic-cargo-check :which-key "check")
    "c t" #'(rustic-cargo-test :which-key "test")))

(general-define-key 
  :states 'normal
  :keymaps 'prog-mode-map
  "C-[" #'previous-error
  "C-]" #'next-error)

(use-package rainbow-delimiters
  :straight t
  :config
  (hook! 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

(use-package parinfer-rust-mode
  :straight t
  :hook emacs-lisp-mode
  :init
  (setq parinfer-rust-auto-download t)
  
  :config
  (hook! 'parinfer-rust-mode-hook (lambda () (electric-indent-mode 0)))
  (pg/local-leader
    :keymaps 'org-mode-map
    "p" #'(parinfer-rust-toggle-paren-mode :which-key "parinfer")))

(use-package erefactor
  :straight t
  :defer t
  :init
  (pg/leader
    :keymaps 'emacs-lisp-mode-map
    "c r" #'(erefactor-rename-symbol-in-buffer :which-key rename)))

(pg/leader
  :keymaps 'emacs-lisp-mode-map
  "e" '(:which-key "eval")
  "e b" #'(eval-buffer :which-key "buffer")
  "e f" #'(eval-defun :which-key "function")
  "b c" #'(emacs-lisp-byte-compile-and-load :which-key "compile and load"))

(pg/leader
  :states 'visual
  :keymaps 'emacs-lisp-mode-map
  "e" '(:which-key "eval")
  "e r" #'(eval-region :which-key "region"))

(use-package package-lint
  :straight t)

(use-package flycheck-package
  :straight t)

(use-package yaml-mode
  :straight t)

(provide 'pg-editing)

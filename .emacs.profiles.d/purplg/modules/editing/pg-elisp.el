(require 'pg-straight)
(require 'pg-keybinds)

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

(provide 'pg-elisp)

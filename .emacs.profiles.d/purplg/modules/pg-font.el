;;; --- -*- lexical-binding: t; -*-

(defvar font nil)

(defun set-font-face (font-spec)
  (setq font font-spec)
  (set-face-attribute 'default nil :font font) 
  (add-to-list 'default-frame-alist `(font . ,font)))

(provide 'pg-font)

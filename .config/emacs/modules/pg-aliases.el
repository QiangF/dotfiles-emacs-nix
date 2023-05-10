;;; --- -*- lexical-binding: t; -*-

(defun advice-unadvice (sym)
  "Remove all advices from symbol SYM."
  (interactive "aFunction symbol: ")
  (advice-mapc (lambda (advice _props) (advice-remove sym advice)) sym))

(defun pg/try-load-file (file &optional dir)
  (let ((file (expand-file-name file (or dir pg/config-dir))))
    (when (file-exists-p file)
      (load-file file))))

(provide 'pg-aliases)

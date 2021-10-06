;;; --- -*- lexical-binding: t; -*-

(defalias 'after! 'with-eval-after-load)

(setq native-comp-async-report-warnings-errors nil
      ring-bell-function 'ignore
      scroll-conservatively 101
      initial-major-mode 'emacs-lisp-mode)

(provide 'pg-basics)

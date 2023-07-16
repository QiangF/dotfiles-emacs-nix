;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package jsonian
  :init
  (with-eval-after-load 'flycheck
    (jsonian-enable-flycheck)))

(provide 'pg-json)

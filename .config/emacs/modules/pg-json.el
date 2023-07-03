;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package jsonian
  :init
  (jsonian-enable-flycheck))

(provide 'pg-json)

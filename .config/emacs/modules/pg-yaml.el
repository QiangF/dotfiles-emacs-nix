;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package yaml-mode
  :mode ("\\.\\(e?ya?\\|ra\\)ml\\'" . yaml-mode))

(provide 'pg-yaml)

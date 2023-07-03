;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package dockerfile-mode
  :mode (("\\.dockerfile\\'" . dockerfile-mode)
         ("/Dockerfile\\(?:\\.[^/\\]*\\)?\\'" . dockerfile-mode)))

(provide 'pg-docker)

;;; --- -*- lexical-binding: t; -*-

(use-package dockerfile-mode
  :mode (("\\.dockerfile\\'" . dockerfile-mode)
         ("/Dockerfile\\(?:\\.[^/\\]*\\)?\\'" . dockerfile-mode)))

(provide 'pg-docker)

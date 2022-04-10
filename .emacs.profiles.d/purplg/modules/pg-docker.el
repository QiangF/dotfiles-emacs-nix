;;; --- -*- lexical-binding: t; -*-

(use-package dockerfile-mode
  :straight t
  :mode (("\\.dockerfile\\'" . dockerfile-mode)
         ("/Dockerfile\\(?:\\.[^/\\]*\\)?\\'" . dockerfile-mode)))

(provide 'pg-docker)

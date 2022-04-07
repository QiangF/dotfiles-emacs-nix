;;; --- -*- lexical-binding: t; -*-

(use-package restclient
  :straight t)

(use-package ob-restclient
  :straight t
  :after restclient)

(provide 'pg-restclient)

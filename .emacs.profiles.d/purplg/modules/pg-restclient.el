;;; --- -*- lexical-binding: t; -*-

(use-package restclient
  :straight t
  :defer t)

(use-package ob-restclient
  :straight t
  :defer t
  :after ob restclient)

(provide 'pg-restclient)

;;; --- -*- lexical-binding: t; -*-

(use-package restclient
  :defer t)

(use-package ob-restclient
  :defer t
  :after ob restclient)

(provide 'pg-restclient)

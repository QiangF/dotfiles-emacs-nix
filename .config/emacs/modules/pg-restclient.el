;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package restclient
  :defer t)

(use-package ob-restclient
  :defer t
  :after ob restclient)

(provide 'pg-restclient)

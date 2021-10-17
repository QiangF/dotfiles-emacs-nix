;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)

(use-package elfeed
  :straight t
  :config
  (setq elfeed-feeds
        '(("https://planet.emacslife.com/atom.xml")
          ("https://protesilaos.com/codelog.xml")))
  (pg/leader
   :states 'normal
   "o r" #'(elfeed :wk "rss")))

(provide 'pg-rss)

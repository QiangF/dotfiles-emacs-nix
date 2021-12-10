;;; --- -*- lexical-binding: t; -*-

(use-package elfeed
  :config
  (setq elfeed-feeds
        '(("https://planet.emacslife.com/atom.xml")
          ("https://protesilaos.com/codelog.xml")
          ("https://www.guildwars2.com/en/feed/")))
  (pg/leader
   :states 'normal
   "o r" #'(elfeed :wk "rss")))

(provide 'pg-rss)

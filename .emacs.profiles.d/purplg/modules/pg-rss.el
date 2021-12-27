;;; --- -*- lexical-binding: t; -*-

(use-package elfeed
  :defer t
  :straight t
  :init
  (add-to-list 'recentf-exclude "/home/purplg/.elfeed/index" t)

  (setq elfeed-feeds
        '(("https://planet.emacslife.com/atom.xml")
          ("https://protesilaos.com/codelog.xml")
          ("https://www.guildwars2.com/en/feed/")))

  (pg/leader
   :states 'normal
   "o r" #'(elfeed :wk "rss")))

(provide 'pg-rss)

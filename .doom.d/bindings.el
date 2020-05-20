;;; ~/.doom.d/bindings.el -*- lexical-binding: t; -*-

(defun lsp-import-and-format ()
  (interactive)
  (lsp-organize-imports)
  (lsp-format-buffer))

(map! :desc "LSP Format"
 :leader
 :n "c f"
 'lsp-import-and-format)

(map! :desc "Clear search highlight"
 :leader
 :n "s c"
 'evil-ex-nohighlight )

(map! :desc "Open terminal"
 :leader
 :n "o t"
 'eshell )

(map! :desc "Applications"
 :leader
 :n "a" )

(map! :desc "Docker compose"
 :leader
 :n "a d d"
 'docker-compose )

(map! :desc "Docker compose up"
 :leader
 :n "a d u"
 'docker-compose-up )

(map! :desc "File at point"
 :leader
 :n "f h"
 'find-file-at-point )

(map! :ni "^j" 'evil-scroll-line-down)
(map! :ni "^k" 'evil-scroll-line-up)

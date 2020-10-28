(setq user-full-name "Ben Whitley"
      user-mail-address "dev@purplg.com")
(setq require-final-newline nil)

(setq doom-font (font-spec :family "Source Code Pro" :size 14))

(setq doom-theme 'doom-one)

(setq display-line-numbers-type 'relative)

(map! :desc "File at point"
 :leader
 :n "f h"
 'find-file-at-point )

(defun lsp-import-and-format ()
  (interactive)
  (lsp-organize-imports)
  (lsp-format-buffer))

(map! :desc "LSP Format"
 :leader
 :n "c f"
 'lsp-import-and-format)

(defun scroll-page-line-down ()
  (interactive)
  (evil-scroll-line-down 1)
  (evil-next-line 1))
(map! :ni "^j" 'scroll-page-line-down)

(defun scroll-page-line-up ()
  (interactive)
  (evil-scroll-line-up 1)
  (evil-next-line -1))
(map! :ni "^k" 'scroll-page-line-up)

(map! :desc "Clear search highlight"
 :leader
 :n "s c"
 'evil-ex-nohighlight )

(defun +fold/close-all-level-2 ()
  (interactive)
  (+fold/close-all 2))

(map!
 :n "z m"
 '+fold/close-all-level-2)

(map! :desc "Journal"
  :leader
  :n "j")

(map! :desc "New entry"
  :leader
  :n "j n"
  'org-journal-new-entry)

(map! :desc "Next journal"
  :leader
  :n "j l"
  'org-journal-next-entry)

(map! :desc "Previous journal"
  :leader
  :n "j h"
  'org-journal-previous-entry)

(map! :desc "Open terminal"
 :leader
 :n "o t"
 'eshell )

(map! :desc "Applications"
 :leader
 :n "a" )

(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

(setq which-key-idle-delay 0.3)

(setq org-directory "~/.org/")

(use-package! org-journal
  :custom
  (org-journal-date-prefix "#+TITLE: ")
  (org-journal-file-format "%Y-%m-%d.org")
  (org-journal-dir "~/.org-roam")
  (org-journal-date-format "%A, %d %B %Y"))

(use-package! org-roam
  :commands (org-roam-insert org-roam-find-file org-roam)
  :init
  (setq org-roam-directory "~/.org")
  (setq org-roam-graph-viewer "/usr/bin/open")
;;  (map! :leader
;;        :prefix "n"
;;        :desc "Org-Roam-Insert" "i" #'org-roam-insert
;;        :desc "Org-Roam-Find"   "/" #'org-roam-find-file
;;        :desc "Org-Roam-Buffer" "r" #'org-roam)
  :config
  (org-roam-mode +1))

(after! company
  :config
  (setq! company-idle-delay 0.1
         company-minimum-prefix-length 3))

;(after! counsel
;  (setq counsel-find-file-ignore-regexp "\\(?:^[#.]\\)\\|\\(?:[#~]$\\)\\|\\(?:^Icon?\\)\\|\\(?:.meta$\\)\\|\\(?:.asset$\\)\\|\\(?:.prefab$\\)"))

(after! treemacs
  :config
  (defun treemacs-ignore-unity (filename absolute-path)
    (or (string-suffix-p ".meta" filename t)
        (string-suffix-p ".asset" filename t)))
  (add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-unity)
  (treemacs-follow-mode))

(use-package! deft
  :after org
;;  :bind
;;  ("C-c n d" . deft)
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory "~/.org"))

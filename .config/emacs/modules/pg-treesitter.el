;;; --- -*- lexical-binding: t; -*-

(defun pg/native-treesitter-p ()
  (and (version< "29" emacs-version)
       (treesit-available-p)))

;; https://www.nathanfurnal.xyz/posts/building-tree-sitter-langs-emacs/
(use-package treesit
  :straight nil
  :commands (treesit-install-language-grammar)
  :if (pg/native-treesitter-p)
  :init
  (setq treesit-language-source-alist
        '((bash . ("https://github.com/tree-sitter/tree-sitter-bash"))
          (c . ("https://github.com/tree-sitter/tree-sitter-c"))
          (cpp . ("https://github.com/tree-sitter/tree-sitter-cpp"))
          (css . ("https://github.com/tree-sitter/tree-sitter-css"))
          (go . ("https://github.com/tree-sitter/tree-sitter-go"))
          (html . ("https://github.com/tree-sitter/tree-sitter-html"))
          (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
          (json . ("https://github.com/tree-sitter/tree-sitter-json"))
          (lua . ("https://github.com/Azganoth/tree-sitter-lua"))
          (make . ("https://github.com/alemuller/tree-sitter-make"))
          (ocaml . ("https://github.com/tree-sitter/tree-sitter-ocaml" "ocaml/src" "ocaml"))
          (python . ("https://github.com/tree-sitter/tree-sitter-python"))
          (php . ("https://github.com/tree-sitter/tree-sitter-php"))
          (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "typescript/src" "typescript"))
          (ruby . ("https://github.com/tree-sitter/tree-sitter-ruby"))
          (rust . ("https://github.com/tree-sitter/tree-sitter-rust"))
          (sql . ("https://github.com/m-novikov/tree-sitter-sql"))
          (toml . ("https://github.com/tree-sitter/tree-sitter-toml"))
          (yaml . ("https://github.com/panekj/tree-sitter-yaml"))
          (zig . ("https://github.com/GrayJack/tree-sitter-zig"))))

  (setq major-mode-remap-alist
        '((sh-mode         . bash-ts-mode)
          (c-mode          . c-ts-mode)
          (c++-mode        . c++-ts-mode)
          (csharp-mode     . csharp-ts-mode)
          (cmake-mode      . cmake-ts-mode)
          (css-mode        . css-ts-mode)
          (dockerfile-mode . dockerfile-ts-mode)
          (go-mode         . go-ts-mode)
          (java-mode       . java-ts-mode)
          (javascript-mode . js-ts-mode)
          (js-json-mode    . json-ts-mode)
          (python-mode     . python-ts-mode)
          (ruby-mode       . ruby-ts-mode)
          (rust-mode       . rust-ts-mode)
          (conf-toml-mode  . toml-ts-mode)
          (rjsx-mode       . tsx-ts-mode)
          (typescript-mode . typescript-ts-mode)
          (yaml-mode       . yaml-ts-mode)))

  (defun pg/treesit-install-all-grammars ()
    (dolist (grammar treesit-language-source-alist)
      (let ((lang (car grammar)))
        (treesit-install-language-grammar lang)))))

(use-package tree-sitter
  :if (and (not (pg/native-treesitter-p))
           (string= "x86_64" (car (split-string system-configuration "-")))))

(use-package tree-sitter-langs
  :if (not (pg/native-treesitter-p))
  :after tree-sitter
  :config
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(provide 'pg-treesitter)

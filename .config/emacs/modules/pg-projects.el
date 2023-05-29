;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(with-eval-after-load 'evil
  (evil-define-key* 'normal 'global
    (kbd "<leader> TAB") (make-sparse-keymap)))

(use-package tab-bar
  :elpaca nil
  :after evil
  :init
  (setq tab-bar-show 1)
  (tab-bar-mode)
  (tab-bar-rename-tab "Default" 1)
  :config
  (evil-define-key* 'normal 'global
    (kbd "<leader> TAB h") #'("prev" . tab-bar-switch-to-prev-tab)
    (kbd "<leader> TAB l") #'("next" . tab-bar-switch-to-next-tab)
    (kbd "<leader> TAB x") #'("close" . tab-bar-close-tab)
    (kbd "<leader> TAB n") #'("new tab" . tab-bar-new-tab))

  (evil-define-key* '(normal motion) 'global
    (kbd "M-1") (lambda () (interactive) (tab-bar-select-tab 1))
    (kbd "M-2") (lambda () (interactive) (tab-bar-select-tab 2))
    (kbd "M-3") (lambda () (interactive) (tab-bar-select-tab 3))
    (kbd "M-4") (lambda () (interactive) (tab-bar-select-tab 4))
    (kbd "M-5") (lambda () (interactive) (tab-bar-select-tab 5))))

(use-package project
  :after evil
  :init
  (setq project-switch-commands 'project-find-file)

  :config
  ;; Add an optional `starting-directory' argument
  (advice-add
   'project-prompt-project-dir
   :around
   (lambda (inner &optional starting-directory)
     (let ((default-directory (or starting-directory default-directory)))
       (funcall inner))))
  (evil-define-key* 'normal 'global
    (kbd "<leader> p f") #'("find file" . project-find-file)
    (kbd "<leader> f p") #'("find file" . project-find-file)))

(use-package treebund
  :after evil
  ;; :elpaca (:type git :host github :repo "purplg/treebund.el")
  :elpaca (:repo "~/workspaces/treebund.el/main/")
  :config
  (with-eval-after-load 'tab-bar
    (add-hook 'treebund-before-project-open-functions
              (lambda (project-path)
                (when-let* ((workspace-path (treebund-current-workspace project-path))
                            (workspace-name (treebund--workspace-name workspace-path))
                            (project-name (treebund--project-name project-path)))
                  (tab-bar-select-tab-by-name
                   (format "%s/%s" workspace-name project-name))))))

  (defun pg/open-project-notes ()
    (interactive)
    (if-let ((workspace-path (or (treebund-current-workspace)
                                 (treebund--read-workspace))))
        (find-file-other-window
         (file-name-concat org-directory
                           "projects"
                           (file-name-with-extension (treebund--workspace-name workspace-path) "org")))
      (user-error "Not in a workspace")))

  (evil-define-key* 'normal 'global
    (kbd "<leader> p /") #'("debug" . (lambda ()
                                        (interactive)
                                        (switch-to-buffer-other-window (treebund--gitlog-buffer))))
    (kbd "<leader> p o") #'("open" . treebund-open)
    (kbd "<leader> p x") #'("todos" . pg/open-project-notes)
    (kbd "<leader> p a") #'("add" . treebund-add-project)
    (kbd "<leader> p r") #'("remove" . treebund-remove-project)
    (kbd "<leader> p p") #'("open" . treebund-open-project)
    (kbd "<leader> p d") #'("delete workspace" . treebund-delete-workspace)))

(provide 'pg-projects)

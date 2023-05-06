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
    (kbd "<leader> TAB x") #'("close" . tab-bar-close-tab))

  (evil-define-key* '(normal motion) 'global
    (kbd "M-1") (lambda () (interactive) (tab-bar-select-tab 1))
    (kbd "M-2") (lambda () (interactive) (tab-bar-select-tab 2))
    (kbd "M-3") (lambda () (interactive) (tab-bar-select-tab 3))
    (kbd "M-4") (lambda () (interactive) (tab-bar-select-tab 4))
    (kbd "M-5") (lambda () (interactive) (tab-bar-select-tab 5))))

(use-package project
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
  ;; :elpaca (:type git :host github :repo "purplg/treebund.el")
  :elpaca (:repo "~/workspaces/treebund.el/main/")
  :config
  (with-eval-after-load 'tab-bar
    (add-hook 'treebund-before-project-open-functions
              (lambda (project-path)
                (when-let ((workspace-path (treebund--workspace-current project-path))
                           (bare-path project-path))
                  (tab-bar-select-tab-by-name
                   (format "%s/%s"
                           (treebund--workspace-name workspace-path)
                           (treebund--bare-name bare-path)))))))

  (defun pg/open-project-notes ()
    (interactive)
    (if-let ((workspace-path (or (treebund--workspace-current) (treebund--read-workspace "Open notes for project: "))))
        (find-file-other-window (expand-file-name "project.org" workspace-path))
      (message "Not in a workspace")))

  (evil-define-key* 'normal 'global
    (kbd "<leader> TAB TAB") #'("prev tab" . tab-bar-switch-to-prev-tab)
    (kbd "<leader> TAB /") (lambda ()
                             (interactive)
                             (switch-to-buffer-other-window (treebund--gitlog-buffer)))
    (kbd "<leader> TAB o") #'("open" . treebund-open)
    (kbd "<leader> TAB c") #'("clone" . treebund-clone)
    (kbd "<leader> TAB C") #'("remove bare" . treebund-delete-bare)
    (kbd "<leader> TAB n") #'("todos" . pg/open-project-notes)
    (kbd "<leader> TAB a") #'("add" . treebund-add-project)
    (kbd "<leader> TAB r") #'("remove-project" . treebund-remove-project)
    (kbd "<leader> TAB p") #'("open-project" . treebund-open-project)
    (kbd "<leader> TAB d") #'("delete workspace" . treebund-delete-workspace)))

(use-package persp-mode
  :disabled
  :config
  (setq persp-auto-resume-time -1)
  (add-to-list 'recentf-exclude (concat user-emacs-directory "persp-confs/persp-auto-save") t)
  (setq persp-autokill-buffer-on-remove t)

  (defun project-switch-with-workspace (project-path)
    (interactive (list (project-prompt-project-dir "~/code/")))
    (let ((project-name (car (last (split-string (directory-file-name project-path) "/")))))
      (persp-switch (persp-name (persp-add-new project-name)))
      (project-switch-project project-path)))

  (evil-define-key* 'normal persp-mode-map
   (kbd "<leader> TAB") (make-sparse-keymap)
   (kbd "<leader> b b") #'("buffer" . persp-switch-to-buffer)
   (kbd "<leader> TAB TAB") #'("list" . persp-list)
   (kbd "<leader> TAB s") #'("switch" . persp-switch)
   (kbd "<leader> TAB a") #'("add buffer" . persp-add-buffer)
   (kbd "<leader> TAB x") #'("remove buffer" . persp-remove-buffer)
   (kbd "<leader> TAB d") #'("kill persp" . persp-kill)
   (kbd "<leader> TAB r") #'("rename" . persp-rename)
   (kbd "<leader> TAB n") #'("new and switch" . persp-switch-to-new)
   (kbd "<leader> TAB N") #'("new" . persp-add-new)
   (kbd "<leader> TAB l") #'("next persp" . persp-next)
   (kbd "<leader> TAB h") #'("prev persp") . persp-prev)

  (evil-define-key* 'normal 'global
    (kbd "M-1") (lambda () (interactive) (persp-switch (nth 0 persp-names-cache)) (persp-list))
    (kbd "M-2") (lambda () (interactive) (persp-switch (nth 1 persp-names-cache)) (persp-list))
    (kbd "M-3") (lambda () (interactive) (persp-switch (nth 2 persp-names-cache)) (persp-list))
    (kbd "M-4") (lambda () (interactive) (persp-switch (nth 3 persp-names-cache)) (persp-list))
    (kbd "M-5") (lambda () (interactive) (persp-switch (nth 4 persp-names-cache)) (persp-list)))

  (add-hook 'after-init-hook
   (lambda () (persp-switch (persp-name (persp-add-new "Session")))))

  (with-eval-after-load 'doom-modeline
    ;; Modified from Doom's `+workspace--tabline`
    (defun persp--format-tab (label active)
      (propertize label
                  'face (if active
                            'doom-modeline-panel
                          'doom-modeline-bar-inactive)))

    (defun persp-list ()
      "Display a list of perspectives"
      (interactive)
      (message "%s"
               (let ((names persp-names-cache)
                     (current-name (safe-persp-name (get-current-persp
                                                     (selected-frame)
                                                     (selected-window)))))
                 (mapconcat
                  #'identity
                  (cl-loop for name in names
                           for i to (length names)
                           collect
                           (persp--format-tab
                            (format " %d:%s " (1+ i) name)
                            (equal current-name name)))
                  nil))))

    ;; Show list of perspectives after switching
    (advice-add 'persp-next :after #'persp-list)
    (advice-add 'persp-prev :after #'persp-list))

  (persp-mode))

(provide 'pg-projects)

;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package tab-bar
  :init
  (setq tab-bar-show 1)
  (tab-bar-mode)
  :config
  (pg/leader
    :keymap 'tab-bar-map
    :states 'normal
    "TAB h" #'(tab-bar-switch-to-prev-tab :wk "prev")
    "TAB l" #'(tab-bar-switch-to-next-tab :wk "next")
    "TAB d" #'(tab-bar-close-tab :wk "close")))

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
  (pg/leader
    :states 'normal
    "p" #'(:ignore t :wk "project")
    "p f" #'(project-find-file :wk "find file")
    "p b" #'(project-find-file :wk "find file")
    "f p" #'(project-find-file :wk "find file")))

(use-package treebund
  :straight (:type git :host github :repo "purplg/treebund.el")
  :config
  (with-eval-after-load 'tab-bar
    (add-hook 'treebund-before-project-open-hook #'tab-bar-new-tab)
    (add-hook 'treebund-after-project-open-hook
              (lambda ()
                (when-let ((workspace (treebund--workspace-current))
                           (project (project-current)))
                  (tab-bar-rename-tab
                   (format "%s/%s"
                           (treebund--workspace-name workspace)
                           (treebund--bare-name
                            (treebund--project-bare
                             (project-root project)))))))))

  (defun pg/open-project-notes ()
    (interactive)
    (if-let ((workspace-path (or (treebund--workspace-current) (treebund--read-workspace "Open notes for project: "))))
        (find-file-other-window (expand-file-name "project.org" workspace-path))
      (message "Not in a workspace")))

  (pg/leader
    :keymap 'treebund-map
    :states 'normal
    "TAB" '(:ignore t :wk "workspaces")
    "TAB TAB" #'(treebund-open :wk "open")
    "TAB o" #'(treebund-open :wk "open")
    "TAB c" #'(treebund-clone :wk "clone")
    "TAB C" #'(treebund-bare-delete :wk "rm bare")

    "TAB n" #'(pg/open-project-notes :wk "notes")

    "TAB p" '(:ignore t :wk "projects")
    "TAB p a" #'(treebund-project-add :wk "add")
    "TAB p A" #'(treebund-project-add-detailed :wk "add")
    "TAB p r" #'(treebund-project-remove :wk "remove")

    "TAB w" '(:ignore t :wk "workspace")
    "TAB w n" #'(treebund-workspace-new :wk "new")
    "TAB w d" #'(treebund-workspace-delete :wk "delete")))

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

  (pg/leader
   :keymaps 'persp-mode-map
   "b b" #'(persp-switch-to-buffer :wk "buffer")
   "TAB" #'(:wk "perspectives")
   "TAB TAB" #'(persp-list :wk "list")
   "TAB s" #'(persp-switch :wk "switch")
   "TAB a" #'(persp-add-buffer :wk "add buffer")
   "TAB x" #'(persp-remove-buffer :wk "remove buffer")
   "TAB d" #'(persp-kill :wk "kill persp")
   "TAB r" #'(persp-rename :wk "rename")
   "TAB n" #'(persp-switch-to-new :wk "new and switch")
   "TAB N" #'(persp-add-new :wk "new")
   "TAB l" #'(persp-next :wk "next persp")
   "TAB h" #'(persp-prev :wk "prev persp"))

  (evil-define-key* 'normal global-map
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

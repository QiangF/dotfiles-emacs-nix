;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)
(require 'pg-modeline)

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
   "TAB p" #'(project-switch-with-workspace :wk "new with project")
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

  (persp-mode))

(use-package persp-mode
  :disabled
  :after doom-modeline
  :config
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

(use-package tabspaces
  :init
  (setq tab-bar-show 1)
  (tabspaces-mode)
  :config
  (pg/leader
    :keymaps 'tabspaces-mode-map
    "b b" #'(tabspaces-switch-to-buffer :wk "buffer")
    "TAB" #'(:wk "spaces")
    ;; "TAB TAB" #'(persp-list :wk "list")
    "TAB s" #'(tabspaces-switch-buffer-and-tab :wk "switch")
    ;; "TAB a" #'(persp-add-buffer :wk "add buffer")
    "TAB x" #'(tabspaces-remove-selected-buffer :wk "remove buffer")
    "TAB d" #'(tabspaces-kill-buffers-close-workspace :wk "kill")
    ;; "TAB r" #'(persp-rename :wk "rename")
    ;; "TAB n" #'(persp-switch-to-new :wk "new and switch")
    ;; "TAB N" #'(persp-add-new :wk "new")
    "TAB p" #'(tabspaces-open-or-create-project-and-workspace :wk "new with project")
    "TAB l" #'(tab-next :wk "next")
    "TAB h" #'(tab-previous :wk "prev")
    ))

(provide 'pg-workspaces)

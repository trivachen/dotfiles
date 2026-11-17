;;; scripts.el --- User scripts -*- lexical-binding: t; -*-

;;; Commentary:

;; Just scripts that are used in the configuration

;;; Code:

;; Macros:

(defmacro add-hooks (function &rest hooks)
  "Add FUNCTION to each of the HOOKS."
  `(dolist
       (hook (list ,@hooks))
     (add-hook hook ,function)))

(defmacro add-elements-to-list (list-var &rest elements)
  "Add ELEMENTS to LIST-VAR."
  `(dolist
       (element (list ,@elements))
     (add-to-list ',list-var element)))

;; C

(add-hooks
 (lambda ()
   "Settings for `c-mode' and other."
   (c-toggle-auto-newline 1)
   (c-set-style "gnu")
   (setopt c-basic-offset 4))
 'c-mode-hook
 'c++-mode-hook
 'objc-mode-hook)

;; Emacs startup

(add-hooks
 'ibuffer
 'server-after-make-frame-hook)

;; Org-mode

(add-hooks
 (lambda ()
   "Settings for `org-mode'."
   (display-line-numbers-mode -1)
   (company-mode -1)
   (variable-pitch-mode -1))
 'org-mode-hook)

(global-set-key (kbd "C-x C-a") 'org-agenda-list)

;; Faces

(defun user/setup-faces ()
  "Set faces."
  (custom-set-faces
   '(default ((t :font "Iosevka Nerd Font" :height 140)))
   '(variable-pitch ((t :font "Iosevka Etoile" :height 140)))
   '(fixed-pitch ((t :font "Iosevka Nerd Font" :height 140)))
   '(fixed-pitch-serif ((t :font "Iosevka Nerd Font" :height 140)))
   '(org-level-1 ((t :height 1.4)))
   '(org-level-2 ((t :height 1.2)))
   '(org-code ((t :font "Iosevka Nerd Font" :inherit 'default)))
   '(org-block-begin-line ((t :background "background")))
   '(org-block-end-line ((t :background "background")))))

(add-elements-to-list
 default-frame-alist
 '(alpha-background . 95))

(add-hooks
 'user/setup-faces
 'emacs-startup-hook
 'server-after-make-frame-hook)

;; Dired

(with-eval-after-load 'dired
  (defun dired-filter ()
    "Filter files by regexp."
    (interactive)
    (dired-unmark-all-marks)
    (revert-buffer)
    (call-interactively 'dired-mark-files-regexp)
    (dired-toggle-marks)
    (dired-do-kill-lines))

  (define-key dired-mode-map (kbd "C-c f") 'dired-filter))

;; Typst

(defun typst-preview ()
  "Reload typst buffer in the browser."
  (async-shell-command
   (concat "tinymist preview " (buffer-file-name (current-buffer))) nil nil))

(add-hook 'typst-ts-mode-hook 'typst-preview)

;; Tramp

(with-eval-after-load 'tramp
  (defun tramp-cleanup-all ()
    "Cleanup all buffers and connections."
    (interactive)
    (tramp-cleanup-all-buffers)
    (tramp-cleanup-all-connections)))

(provide 'scripts)

;;; scripts.el ends here

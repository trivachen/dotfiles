;; -*- lexical-binding: t; -*-
(use-package emacs-everywhere
  :ensure t)

(with-eval-after-load 'emacs-everywhere
  (setq emacs-everywhere-system-configs
        (append emacs-everywhere-system-configs
                '(((wayland . sway)
                   :paste-command
                   ("sh" "-c" "sleep 0.15; wtype -M ctrl -k v -m ctrl"))))))

(defun user/emacs-everywhere-small-frame ()
  (set-frame-size (selected-frame) 80 12))

(add-hook 'emacs-everywhere-init-hooks
          #'user/emacs-everywhere-small-frame t)


(setenv "XDG_CURRENT_DESKTOP" "sway")

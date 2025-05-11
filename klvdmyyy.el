(load-theme 'modus-vivendi) ; Load default dark theme (light version: modus-operandi)

(defun klvdmyyy/open-config ()
  (interactive)
  (find-file config-file))

(setq user-full-name "Klementiev Dmitry")
(setq user-email-address "klementievd08@yandex.ru")

(setq frame-title-format "klvdmyyy's GNU Emacs: %b")
(setq inhibit-splash-screen t)
(setq ingibit-startup-message t)
(tooltip-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(setq use-dialog-box nil)
(setq redisplay-dont-pause t)
(setq ring-bell-function 'ignore) ; TODO: Custom ring-bell function

(set-frame-font "JetBrains Mono 12" nil t)
(setq word-wrap t)
(global-visual-line-mode t)
(setq display-time-24hr-format t)
(display-time-mode t)
(size-indication-mode t)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-name nil)

(defvar bootstrap-version)
(setq straight-repository-branch "develop")
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq use-package-always-ensure nil
      use-package-verbose 'debug)

(use-package straight
  :custom
  (straight-host-usernames '((github . "klvdmyyy")))
  (straight-use-package-by-default t)
  (straight-register-package 'org)
  (straight-register-package 'org-contrib))

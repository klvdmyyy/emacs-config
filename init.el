(defvar my/theme 'gruber-darker)
(defvar my/font "JetBrainsMono Nerd Font")
(defvar my/font-height 140)

;; Load default theme file
(let ((file-name-handler-alist nil)
      (load-suffixes '(".el")))
  (load (expand-file-name "themes/gruber-darker-theme.el" user-emacs-directory)))

;;; First Startup checking:

(defcustom first-startup--lock-file
  (expand-file-name ".first-startup-lock" user-emacs-directory)
  "First startup lock file."
  :group 'first-startup
  :type 'file)

(defun first-startup--lock ()
  "Lock startup"
  (require 'dired-aux)
  (unless (file-exists-p first-startup--lock-file)
    (dired-create-empty-file first-startup--lock-file)))

(defun first-startup-p ()
  "Return non-nil if user start Emacs at first time.

Creates .first-startup-lock in `user-emacs-directory'.
If you delete it this function returns `t' at next startup"
  (if (file-exists-p first-startup--lock-file)
      nil
    (add-hook 'kill-emacs-hook #'first-startup--lock)
    t))

;;; Helper functions:

;; Helper function for fonts loading
(defun load-face-attributes (name height)
  (when (find-font (font-spec :name name))
    (let ((choosen-font name)
          (font-height (or height 130)))
      (set-face-attribute 'default nil :font choosen-font :height font-height)
      (set-face-attribute 'fixed-pitch nil :font choosen-font :height font-height)
      (set-face-attribute 'variable-pitch nil :font choosen-font :height font-height :weight 'regular))))

;; Load theme
(defun my/load-theme ()
  (if (daemonp)
      (add-hook 'after-make-frame-functions
		(lambda (frame)
		  (with-selected-frame frame
		    (load-theme my/theme :no-confirm))))
    (load-theme my/theme :no-confirm)))

;; Load font
(defun my/load-font ()
  (if (daemonp)
      (add-hook 'after-make-frame-functions
		(lambda (frame)
		  (with-selected-frame frame
		    (load-face-attributes my/font my/font-height))))
    (load-face-attributes my/font my/font-height)))

;; Load custom file
(defun my/load-custom ()  
  (load custom-file :no-error :no-message :no-suffix :must-suffix))

;;; Internal Packages:

(use-package emacs
  :ensure nil
  :custom
  (ring-bell-function 'ignore)
  (make-backup-files nil)
  (custom-file (expand-file-name "custom.el" user-emacs-directory))

  :init
  (my/load-custom)
  (package-activate-all)

  :config
  (my/load-theme)
  (my/load-font)
  (blink-cursor-mode 0)

  (when (first-startup-p)
    (package-install-selected-packages :no-confirm)
    (package-vc-install-selected-packages)))

(use-package editorconfig
  :ensure nil
  :defer t
  :hook ((emacs-startup . editorconfig-mode)))

(use-package editorconfig-tools
  :ensure nil
  :defer t
  :hook ((prog-mode . editorconfig-mode-apply)))

(use-package simple
  :ensure nil
  :defer t
  :hook ((emacs-startup . column-number-mode)))

(use-package display-line-numbers
  :ensure nil
  :defer t
  :hook ((prog-mode . display-line-numbers-mode)))

(use-package elec-pair
  :ensure nil
  :defer t
  :hook ((prog-mode . electric-pair-mode)))

(use-package electric
  :ensure nil
  :defer t
  :hook ((prog-mode . electric-indent-mode)))

(use-package project
  :ensure nil
  :defer t
  :autoload (project-root))

(define-minor-mode eshell-mode-setup
  "Setting up environment on `eshell-mode' invocation."
  :group 'eshell
  (if eshell-mode-setup
      (progn
	(if (and (boundp 'envrc-global-mode) envrc-global-mode)
	    (add-hook 'envrc-mode-hook (lambda () (setenv "PAGER" "")))
	  (setenv "PAGER" ""))
	(eshell/alias "x" "exit")
	(eshell/alias "ff" "project-find-file")
	(eshell/alias "fd" "find-dired $PWD \"\"")
	(eshell/alias "rg" "consult-ripgrep")
	(eshell/alias "gg" "consult-git-grep")
	(eshell/alias "l" "ls -al $1")
	(eshell/alias "e" "find-file $1")
	(eshell/alias "ee" "find-file-other-window $1")
	(eshell/alias "d" "dired $1")
	(eshell/alias "gd" "magit-diff-unstaged")
	(eshell/alias "clear" "clear-scrollback"))
    t))

(defun project-eshell-or-eshell (&optional arg)
  (interactive "P")
  (if (project-current)
      (project-eshell)
    (eshell arg)))

(defun switch-to-prev-buffer-or-eshell (arg)
  (interactive "P")
  (if arg
      (eshell arg)          ; or `project-eshell-or-eshell'
    (switch-to-buffer (other-buffer (current-buffer) 1))))

(defun eshell/shortened-pwd ()
  "Return the shortened PWD.

~/.config/emacs -> ~/.c/emacs

~/.config/emacs/lisp -> ~/.c/e/lisp"
  (let ((splited (string-split
                  ;; TEMP: Temporary fix because `file-name-directory' sometimes
                  ;; can provide nil value. (for example with "~" abbreviated directory)
                  (or (file-name-directory (abbreviate-file-name (eshell/pwd))) "")
                  "/")))
    (concat
     (string-join
      (seq-map
       (lambda (name)
         (if (<= (length name) 2)
             name
           (if (string-equal (substring name 0 1) ".")
               (substring name 0 2)
             (substring name 0 1))))
       splited)
      "/")
     (file-name-base (abbreviate-file-name
                      (eshell/pwd))))))

(defun my-eshell-prompt ()
  "My custom prompt for Emacs' eshell."
  (concat
   ;; "\n"
   "(" user-login-name ") "
   (eshell/shortened-pwd) " "
   (concat "[" (format-time-string "%H:%M:%S") "] ")
   ;; TODO: Pretty Printed Last Status (from archive branch of repository)
   ;; (eshell/pp-last-status)
   "\n$ "))

(use-package eshell
  :ensure nil
  :hook ((eshell-mode . eshell-mode-setup))
  :custom
  (eshell-prompt-function #'my-eshell-prompt)
  :bind (("s-e" . project-eshell-or-eshell)
	 :map eshell-mode-map
	 ("s-e" . switch-to-prev-buffer-or-eshell)
	 :map eshell-hist-mode-map
	 ("M-r" . consult-history))
  :config
  (require 'em-alias)
  (require 'em-hist))

;;; External Packages:

(use-package multiple-cursors
  :ensure nil
  :defer t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
	 ("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-like-this)
	 ("C-c C-<" . mc/mark-all-like-this)))

(use-package vertico
  :ensure nil
  :defer (not (daemonp))
  :hook (emacs-startup . vertico-mode))

(use-package marginalia
  :ensure nil
  :defer t
  :after vertico
  :hook (vertico-mode . marginalia-mode))

(use-package consult
  :ensure nil
  :defer (not (daemonp))
  ;; For eshell configuration
  :commands (consult-history)
  :bind (("C-s" . consult-line)
	 ("C-x b" . consult-buffer)
	 ("M-g M-g" . consult-goto-line)))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :ensure nil
  :defer t
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

(use-package magit
  :ensure nil
  :defer t
  :bind (("C-x g" . magit-status)))

(use-package ace-window
  :ensure nil
  :defer t
  :bind (("M-o" . ace-window)))

;;; Major modes (Languages):

(use-package cmake-mode
  :ensure nil
  :defer t
  :mode ("CMakeLists.txt\\'" "\\.cmake\\'"))

(use-package glsl-mode
  :ensure nil
  :defer t
  :mode ("\\.glsl\\'" "\\.frag\\'" "\\.vert\\'"))

(use-package slang-mode
  :ensure nil
  :defer t
  :mode ("\\.slang\\'"))

(use-package yaml-mode
  :ensure nil
  :defer t
  :mode ("\\.yml\\'" "\\.yaml\\'"))

(use-package markdown-mode
  :ensure nil
  :defer t
  :mode "\\.md\\'")

(use-package toml-mode
  :ensure nil
  :defer t
  :mode "\\.toml\\'")

(use-package rust-mode
  :ensure nil
  :defer t)

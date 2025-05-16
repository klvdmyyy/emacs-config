;; -*- lexical-binding: t -*-

;; Moved to org-babel configuration
;;
;; readme.org - Named for github only
(org-babel-load-file
 (expand-file-name
  "readme.org"
  user-emacs-directory))

;; Other appearance stuff
(require 'monokai-pro-theme)
(load-theme 'monokai-pro t nil)

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Smartparens
(eval-when-compile
  (require 'smartparens))

(autoload 'smartparens-mode "smartparens-autoloads")
(autoload 'smartparens-strict-mode "smartparens-autoloads")

(add-hook 'prog-mode-hook 'smartparens-mode)
(add-hook 'prog-mode-hook 'smartparens-strict-mode)

(sp-local-pair 'emacs-lisp-mode "'" nil :when '(sp-in-string-p))

;; Terminal emulation
;;
;; I think about switching to `vterm'
;; or keep only `eshell'
;;
;; I use `eat' only for integration with eshell
;;
(autoload 'eat "eat") ; Check in source code
(autoload 'eat-eshell-mode "eat") ; Check in source code
(autoload 'eat-eshell-visual-command-mode "eat") ; Check in source code
(add-hook 'eshell-load-hook #'eat-eshell-mode)
(add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode)

;; Completion feature
(eval-when-compile
  (require 'marginalia)
  (require 'consult))

(with-eval-after-load 'minibuffer
  (define-key global-map (kbd "C-x b") 'consult-buffer)
  (define-key global-map (kbd "s-B") 'consult-buffer)
  (define-key global-map (kbd "M-r") 'consult-history)
  (define-key global-map (kbd "M-y") 'consult-yank-pop)
  (define-key global-map (kbd "C-s") 'consult-line)
  (define-key global-map (kbd "C-x C-r") 'consult-recent-file)
  
  (with-eval-after-load
      'mini-frame
    (custom-set-faces
     '(child-frame-border
       ;; TODO: inherit ,(face-attribute 'default :foreground)
       ((t (:background "#000000")))))
    (put 'child-frame-border 'saved-face nil)

    (setq
     mini-frame-show-parameters
     `((top . 0.2)
       (width . 0.8)
       (left . 0.5)
       (child-frame-border-width . 1)))
    (setq mini-frame-detach-on-hide nil)
    (setq mini-frame-color-shift-step 0)
    (setq mini-frame-advice-functions
          '(read-from-minibuffer
            read-key-sequence
            save-some-buffers yes-or-no-p))
    ;; (setq mini-frame-ignore-commands
    ;;       '(consult-line consult-line-multi consult-outline
    ;;                      consult-imenu consult-imenu-multi consult-history
    ;;                      consult-git-grep consult-ripgrep consult-grep
    ;;                      embark-bindings))
    )

  (autoload 'mini-frame-mode "mini-frame")
  (if after-init-time
      (mini-frame-mode 1)
    (add-hook 'after-init-hook 'mini-frame-mode)))

(with-eval-after-load 'marginalia
  (setq marginalia-align 'left))

(autoload 'marginalia-mode "marginalia")
(marginalia-mode 1)

;; Vertico feature
(eval-when-compile
  (require 'vertico)
  (require 'vertico-multiform))

(with-eval-after-load 'vertico
  ;; TODO: rde feature-emacs-vertico
  )

(autoload 'vertico-mode "vertico")
(if after-init-time
    (vertico-mode 1)
  (add-hook 'after-init-hook 'vertico-mode))

;; Region completion
(eval-when-compile
  (require 'corfu)
  ;; (require 'corfu-candidate-overlay)
  )

;; Check it in source code
(autoload 'corfu-popupinfo-mode "corfu-popupinfo")

(with-eval-after-load 'corfu
  (setq corfu-min-width 60)
  (setq corfu-cycle t)
  (setq corfu-quit-no-match t)

  (setq corfu-auto t)

  ;; (setq corfu-doc-auto t)
  (setq corfu-popupinfo-auto t)

  (add-hook 'corfu-mode-hook 'corfu-popupinfo-mode)

  (define-key corfu-map (kbd "M-n") 'corfu-popupinfo-scroll-up)
  (define-key corfu-map (kbd "M-p") 'corfu-popupinfo-scroll-down)
  (define-key corfu-map (kbd "M-d") 'corfu-popupinfo-toggle))

(autoload 'global-corfu-mode "corfu")
(global-corfu-mode)

;; (setq tab-always-indent 'complete)

;; LSP (Use lsp-bridge + lsp-booster)

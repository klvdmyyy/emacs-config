;;; appearance.el --- Emacs appearance configuration
;;
;;; Commentary:
;;
;;; Code:

(set-default 'cursor-type '(bar . 1))
(blink-cursor-mode 0)

(setq-default cursor-in-non-selected-windows nil)
(setq bookmark-set-fringe-mark nil)

(with-eval-after-load 'menu-bar
  (menu-bar-mode 0))

(with-eval-after-load 'tool-bar
  (tool-bar-mode 0))

(with-eval-after-load 'scroll-bar
  (scroll-bar-mode 0))

(with-eval-after-load 'fringe
  (fringe-mode 8))

(defun load-face-attributes ()
  (set-face-attribute 'default nil :font "JetBrains Mono" :height 130)
  (set-face-attribute 'fixed-pitch nil :font "JetBrains Mono" :height 130)
  (set-face-attribute 'variable-pitch nil :font "JetBrains Mono" :height 130 :weight 'regular))

(defun load-face-attributes-to-frame (frame)
  (select-frame frame)
  (load-face-attributes))

(if (daemonp)
    (add-hook 'after-make-frame-functions #'load-face-attributes-to-frame)
  (load-face-attributes))

(column-number-mode)
;;(setq display-line-numbers-type 'relative) ; CHECKTHIS
(global-display-line-numbers-mode t)

(dolist (mode '(org-mode-hook
  		      term-mode-hook
  		      eshell-mode-hook
                org-agenda-mode-hook
                eat-mode-hook
                org-agenda-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(dolist (package '(solarized-theme
                   rainbow-delimiters
                   rainbow-mode))
  (straight-use-package package))

(eval-when-compile
  (require 'solarized-theme)
  (require 'rainbow-delimiters)
  (require 'rainbow-mode))

(load-theme 'solarized-light t nil)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(autoload 'rainbow-mode "rainbow-mode")
(dolist (hook '(css-mode-hook
                scss-mode-hook
                web-mode-hook))
  (add-hook hook 'rainbow-mode))

(provide 'appearance)

;;; appearance.el ends here

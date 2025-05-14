(load-theme 'monokai-pro t nil)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-name nil)

(with-eval-after-load 'gcmh
  (setq gcmh-verbose 1
        gcmh-high-cons-threshold (* 16 1024 1024 1024))
  (gcmh-mode 1))

(set-default 'cursor-type '(bar . 2))
(blink-cursor-mode 0)
(setq-default cursor-in-non-selected-windows nil)
(setq bookmark-set-fringe-mark nil)

(with-eval-after-load 'minions
  (setq minions-mode-line-lighter ";"))
(add-hook 'after-init-hook 'minions-mode)

(setq mode-line-compact 'long)

(with-eval-after-load 'menu-bar
  (menu-bar-mode 0))
(with-eval-after-load 'tool-bar
  (tool-bar-mode 0))
(with-eval-after-load 'scroll-bar
  (scroll-bar-mode 0))
(with-eval-after-load 'fringe
  (fringe-mode 8))

(set-frame-parameter (selected-frame) 'internal-border-width 8)

(setq use-dialog-box nil)
(setq use-file-dialog nil)

(setq window-divider-default-right-width 8)

(window-divider-mode)

;; TODO: feature-emacs-input-methods

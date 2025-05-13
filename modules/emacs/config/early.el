(setq package-enable-at-startup nil     ; Disable package.el in favor of straight.el
      inhibit-startup-message t
      frame-resize-pixelwise t
      package-native-compile t)

;; Dont popup a warnings buffer for native-comp errors
(setq native-comp-async-report-warnings-errors 'silent)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(horizontal-scroll-bars) default-frame-alist)
(push (cons 'left-fringe 8) default-frame-alist)
(push (cons 'right-fringe 8) default-frame-alist)
(push '(no-special-glyphs) default-frame-alist)
(push '(undecorated) default-frame-alist)
(setq menu-bar-mode nil
      tool-bar-mode nil
      scroll-bar-mode nil)

(push '(internal-border-width . ,margin) default-frame-alist)
;; (setq-default fringes-outside-margins t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

(provide 'early-init)

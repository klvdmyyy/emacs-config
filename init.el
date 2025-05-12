;;;; Package --- Emacs initialisation of mrvdb
;;; Commentary:
;; Emacs initialisation starting point
;;
;; I want to have as little in here as possible.  The configuration is
;; org-babel based.  This means the bootstrap here is to load a proper
;; (part of) org-mode and be on our way.

;;; Code:

(require 'cl)                           ; for remove-if

;; Set gc really large, during load, after that we are going to use gcmh
;; See: https://akrl.sdf.org/#orgc15a10d has the same as I had for years
(setq gc-cons-threshold (* 16 1024 1024 1024))

;; Assert native compilation is there
(setq comp-deferred-compilation t)

(setq config-file (expand-file-name "readme.org" user-emacs-directory))

(org-babel-load-file config-file)

;; END init.el
;; Exception 1:
;; Apparently when disabled functions get enabled, Emacs puts them here
;;

;;; init.el ends here

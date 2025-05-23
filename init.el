;;; init.el --- My GNU Emacs configuration initialization  -*- lexical-binding: t; -*-
;;
;; Copyright (c) 2025 Dmitry Klementiev <klementievd08@yandex.ru>
;;
;;; Commentary:
;;
;; Initialization of my GNU Emacs distribution.
;;
;;; Code:

;; Setup user init directory
(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

;; [IMPORTANT] Don't use recursive file loading
;; (dolist (file (directory-files-recursively
;;                (concat user-init-dir "modules") "\\.el$"))
;;   (load-file file))

;; Initialize straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(defconst modules-list
  '("core"
    "tweaks"
    "appearance"
    "completion"
    "productivity"
    "development"))

(defun load-user-module (module)
  "Load user module from config.

Modules should be string value (module name). Module name has beed concatenated with
`user-init-dir', modules/ subdirectory and .el suffix

Smth like pipeline:
`user-init-dir' + `modules/' + module name + `.el'"
  (interactive "sModule name: ")
  (let ((file (concat user-init-dir "modules/" module ".el")))
    (load-file file)))

(dolist (module modules-list)
  (load-user-module module))

;;; init.el ends here

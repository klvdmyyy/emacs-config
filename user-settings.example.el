;;; user-settings.el --- My GNU Emacs specific settings which are not stored in repository -*- lexical-binding: t; -*-
;;
;; Copyright (c) 2025 Dmitry Klementiev <klementievd08@yandex.ru>
;;
;;; Commentary:
;;
;;; Code:

(defconst specific-agenda-files
  '()
  "Specific files for Org Agenda which not stored in
repository of my GNU Emacs configuration in some reasons

Firstly because people who see my repo shouldn't know
my specific agenda files and project directories")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load constant variables

(dolist (agenda-file specific-agenda-files)
  (add-to-list 'org-agenda-files agenda-file))

;;; user-settings.el ends here

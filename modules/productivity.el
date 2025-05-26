;;; productivity.el --- Increase productivity with GNU Emacs
;;
;;; Commentary:
;;
;; [TODO] Maybe move `telega.el' configuration to another module
;;
;;; Code:

(dolist (package '(telega))
  (straight-use-package package))

;; [TODO] Move `org-mode-indent' to appearance maybe !?
;; [TODO] Move `visual-line-mode' to appearance maybe !?
(dolist (mode '(org-indent-mode
                visual-line-mode))
  (add-hook 'org-mode-hook mode))

(setq org-agenda-files
      '("~/Projects/OrgFiles/Tasks.org"
        "~/Projects/OrgFiles/Birthdays.org"
        ;;"~/Projects/OrgFiles/Habits.org"
        ))

;; [TODO] Fedora TDLib 1.8.0 less then required 1.8.44 (minimum required)
;; (autoload 'telega "telega")
;; (setq telega-server-libs-prefix "/usr")
;; (dolist (hook '(server-switch-hook
;;                  server-after-make-frame-hook))
;;   (add-hook hook (lambda ()
;;                    (interactive)
;;                    (telega t))))
;; (add-hook 'emacs-startup-hook (lambda ()
;;                                 (interactive)
;;                                 (telega nil)))

(provide 'productivity)

;;; productivity.el ends here

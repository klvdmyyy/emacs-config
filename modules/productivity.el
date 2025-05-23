;;; productivity.el --- Increase productivity with GNU Emacs
;;
;;; Commentary:
;;
;;; Code:

(dolist (package '())
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

(provide 'productivity)

;;; productivity.el ends here

;;; productivity.el --- Increase productivity with GNU Emacs
;;
;;; Commentary:
;;
;;; Code:

;; [TODO] Move `org-mode-indent' to appearance maybe !?
;; [TODO] Move `visual-line-mode' to appearance maybe !?
(dolist (mode '(org-indent-mode
                visual-line-mode))
  (add-hook 'org-mode-hook mode))

(provide 'productivity)

;;; productivity.el ends here

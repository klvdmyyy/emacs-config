;;; org-mode.el --- Emacs org and org agenda configuration
;;
;;; Commentary:
;;
;;; Code:

(dolist (mode '(org-indent-mode
                visual-line-mode))
  (add-hook 'org-mode-hook mode))

(provide 'org-mode)

;;; org-mode.el ends here

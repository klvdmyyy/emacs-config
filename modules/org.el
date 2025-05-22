;;; org.el --- Emacs org and org agenda configuration
;;
;;; Commentary:
;;
;;; Code:

(dolist (mode '(org-indent-mode
                visual-line-mode))
  (add-hook 'org-mode-hook mode))

(provide 'org)

;;; org.el ends here

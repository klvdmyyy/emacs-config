;;; git.el --- Emacs Git configuration
;;
;;; Commentary:
;;
;;; Code:

(dolist (package '(magit))
  (straight-use-package package))

(with-eval-after-load 'magit
  (magit-add-section-hook 'magit-status-sections-hook
                          'magit-insert-local-branches
                          'magit-insert-stashes))

(provide 'git)

;;; git.el ends here

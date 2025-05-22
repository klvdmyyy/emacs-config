;;; tweaks.el --- GNU Emacs module with some tweaks
;;
;;; Commentary:
;;
;;; Code:

(dolist (package '(gcmh))
  (straight-use-package package))

(eval-when-compile
  (require 'gcmh))

(with-eval-after-load 'gcmh
  (gcmh-mode 1))

(provide 'tweaks)

;;; tweaks.el ends here

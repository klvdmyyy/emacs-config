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

(fset #'jsonrpc--log-event #'ignore)    ; Maybe good option for making Eglot faster

(provide 'tweaks)

;;; tweaks.el ends here

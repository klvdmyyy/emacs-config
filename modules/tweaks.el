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

;; Maybe good options for making Eglot faster
(setq jsonrpc-event-hook nil)
(fset #'jsonrpc--log-event #'ignore)

;; By default '(:size 2000000 :format full)
(setq eglot-events-buffer-config '(:size 0 :format full))

(provide 'tweaks)

;;; tweaks.el ends here

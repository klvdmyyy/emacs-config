;;; helm.el --- Emacs completion configuration
;;
;;; Commentary:
;;
;; For now this module using Heml only.
;;
;; Read about following things:
;; - Vertico + Consult + Marginalia + Orderless + Embark + Corfu
;; - Ivy + Swiper
;; - Helm ?!?!?!
;;
;;; Code:

(dolist (package '(all-the-icons
                   wgrep
                   helm))
  (straight-use-package package))

(eval-when-compile
  (require 'all-the-icons)
  (require 'wgrep)
  (require 'helm))

(with-eval-after-load 'helm
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "s-B") 'helm-buffers-list)
  (helm-mode 1))

(provide 'helm)

;;; helm.el ends here

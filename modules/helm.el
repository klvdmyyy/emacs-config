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


(defconst helm-keybindings-alist
  '(("M-x" . helm-M-x)
    ("C-x C-f" . helm-find-files)
    ("s-B" . helm-buffers-list)
    ("C-s" . helm-outline)))

(eval-when-compile
  (require 'all-the-icons)
  (require 'wgrep)
  (require 'helm))

(with-eval-after-load 'helm
  (dolist (kc helm-keybindings-alist)
    (let ((key (car kc))
          (cmd (cdr kc)))
      (global-set-key (kbd key) cmd)))
  (helm-mode 1))

(provide 'helm)

;;; helm.el ends here

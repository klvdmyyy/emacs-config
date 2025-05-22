;;; completion.el --- Emacs completion configuration
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
                   all-the-icons-completion
                   consult
                   orderless
                   marginalia
                   vertico))
  (straight-use-package package))

(eval-when-compile
  (require 'all-the-icons-completion)
  (require 'vertico)
  (require 'consult)
  (require 'marginalia)
  (require 'orderless))

(with-eval-after-load 'minibuffer
  (with-eval-after-load 'consult
    (global-set-key (kbd "s-B") 'consult-buffer)
    (global-set-key (kbd "C-s") 'consult-line)
    (define-key org-mode-map (kbd "C-s") 'consult-org-heading))

  (with-eval-after-load 'marginalia
    (setq marginalia-max-relative-age 0
          marginalia-align 'left)
    (marginalia-mode 1))

  (with-eval-after-load 'orderless
    (setq completion-styles '(orderless basic))))

(with-eval-after-load 'vertico
  (vertico-mode 1))

(with-eval-after-load 'all-the-icons-completion
  (add-hook 'marginalia-mode-hook 'all-the-icons-completion-marginalia-setup)
  (all-the-icons-completion-mode 1))

(provide 'completion)

;;; completion.el ends here

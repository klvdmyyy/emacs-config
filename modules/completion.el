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
  (require 'consult)
  (require 'vertico)
  (require 'orderless)
  (require 'marginalia)
  (require 'all-the-icons)
  (require 'all-the-icons-completion))

(with-eval-after-load
    'minibuffer
  (with-eval-after-load 'consult
    (global-set-key (kbd "s-B") 'consult-buffer)
    (global-set-key (kbd "C-s") 'consult-line))

  (with-eval-after-load 'marginalia
    (setq marginalia-max-relative-age 0
          marginalia-align 'right) ; or `left' or `center'
    (marginalia-mode 1))

  (with-eval-after-load 'all-the-icons-completion
    (add-hook 'marginalia-mode-hook 'all-the-icons-completion-marginalia-setup)
    (all-the-icons-completion-mode 1))

  (with-eval-after-load 'vertico
    (setq vertico-count 13
          vertico-resize t
          vertico-cycle nil)
    (vertico-mode 1))

  (with-eval-after-load 'orderless
    (setq completion-styles '(orderless basic)
          enable-recursive-minibuffers t
          completion-category-defaults nil
          completion-category-overrides
          '((file (styles basic-remote
                          orderless))))

    (setq orderless-matching-styles
          '(orderless-literal
            orderless-prefixes
            orderless-initialism
            orderless-regexp
            ;; orderless-flex ; Basically fuzzy finding
            ;; orderless-strict-leading-initialism
            ;; orderless-strict-initialism
            ;; orderless-strict-full-initialism
            ;; orderless-without-literal ; Recommended for dispatches instead
            ))))

(provide 'completion)

;;; completion.el ends here

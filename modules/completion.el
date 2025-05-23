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
                   vertico
                   corfu))
  (straight-use-package package))

(eval-when-compile
  (require 'all-the-icons-completion)
  (require 'vertico)
  (require 'consult)
  (require 'marginalia)
  (require 'orderless)
  (require 'corfu))

(with-eval-after-load 'minibuffer
  (with-eval-after-load 'consult
    (global-set-key (kbd "s-B") 'consult-buffer)
    (global-set-key (kbd "C-s") 'consult-line)
    (global-set-key (kbd "C-c a") 'consult-org-agenda)

    (with-eval-after-load 'org
      (define-key org-mode-map (kbd "C-s") 'consult-org-heading)))

  (with-eval-after-load 'marginalia
    (setq marginalia-max-relative-age 0
          marginalia-align 'left)
    (marginalia-mode 1))

  (with-eval-after-load 'orderless
    (setq completion-styles '(orderless basic))))

(with-eval-after-load 'vertico
  ;; [TODO] Vertico configuration and don't forgot about extensions
  )

(autoload 'vertico-mode "vertico")
(if after-init-time
    (vertico-mode 1)
  (add-hook 'after-init-hook 'vertico-mode))

(with-eval-after-load 'all-the-icons-completion
  (add-hook 'marginalia-mode-hook 'all-the-icons-completion-marginalia-setup)
  (all-the-icons-completion-mode 1))

(with-eval-after-load 'corfu
  (setq corfu-min-width 60)
  (setq corfu-cycle t)
  (setq corfu-quit-no-match t)

  (setq corfu-auto t)
  (setq corfu-auto-delay 0.1)

  ;; (setq corfu-doc-auto t)
  (setq corfu-popupinfo-auto t)

  (add-hook 'corfu-mode-hook 'corfu-popupinfo-mode)

  (define-key corfu-map (kbd "M-n") 'corfu-popupinfo-scroll-up)
  (define-key corfu-map (kbd "M-p") 'corfu-popupinfo-scroll-down)
  (define-key corfu-map (kbd "M-d") 'corfu-popupinfo-toggle)

  (dolist (mode '(org-mode-hook))
    (add-hook mode (lambda () (corfu-mode 0)))))

(autoload 'global-corfu-mode "corfu")
(global-corfu-mode)

(provide 'completion)

;;; completion.el ends here

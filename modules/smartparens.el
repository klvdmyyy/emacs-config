;;; smartparens.el --- Emacs smartparens configuration
;;
;;; Commentary:
;;
;;; Code:

(straight-use-package 'smartparens)

(eval-when-compile
  (require 'smartparens))

(autoload 'smartparens-mode "smartparens-autoloads")
(autoload 'smartparens-strict-mode "smartparens-autoloads")

(add-hook 'prog-mode-hook 'smartparens-mode)
(add-hook 'prog-mode-hook 'smartparens-strict-mode)

(dolist (mode '(emacs-lisp-mode
                lisp-mode
                common-lisp-mode
                scheme-mode))
  (sp-local-pair mode "'" nil :when '(sp-in-string-p))
  (sp-local-pair mode "`" nil :when '(sp-in-string-p)))

(defun indent-between-pair (&rest _ignored)
  "Insert indentation between pairs. Used with smartparens"
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

(dolist (char '("{" "(" "["))
  (sp-local-pair 'prog-mode char nil :post-handlers '((indent-between-pair "RET"))))

(provide 'smartparens)

;;; smartparens.el ends here

;;; development.el --- Setup GNU Emacs for development
;;
;;; Commentary:
;;
;;; Code:

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)


(dolist (package '(magit
                   smartparens
                   (eat :type git
                        :host codeberg
                        :repo "akib/emacs-eat"
                        :files ("*.el" ("term" "term/*.el") "*.texi"
                                "*.ti" ("terminfo/e" "terminfo/e/*")
                                ("terminfo/65" "terminfo/65/*")
                                ("integration" "integration/*")
                                (:exclude ".dir-locals.el" "*-tests.el")))))
  (straight-use-package package))

(eval-when-compile
  (require 'eat)
  (require 'smartparens)
  (require 'magit))

(with-eval-after-load 'magit
  (magit-add-section-hook 'magit-status-sections-hook
                          'magit-insert-local-branches
                          'magit-insert-stashes))

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

(with-eval-after-load 'eat
  (let ((zsh (executable-find "zsh")))
    (if zsh
        (setq eat-shell zsh)
      (setq eat-shell (executable-find "bash"))))

  (global-set-key (kbd "s-e") 'eat)
  (add-hook 'eshell-load-hook #'eat-eshell-mode)
  (add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode))

(provide 'development)

;;; development.el ends here

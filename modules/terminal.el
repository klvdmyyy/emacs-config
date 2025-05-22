;;; terminal.el --- Emacs terminal emulator configuration
;;
;;; Commentary:
;;
;;; Code:

(straight-use-package
 '(eat :type git
       :host codeberg
       :repo "akib/emacs-eat"
       :files ("*.el" ("term" "term/*.el") "*.texi"
               "*.ti" ("terminfo/e" "terminfo/e/*")
               ("terminfo/65" "terminfo/65/*")
               ("integration" "integration/*")
               (:exclude ".dir-locals.el" "*-tests.el"))))

(eval-when-compile
  (require 'eat))

(with-eval-after-load 'eat
  (let ((zsh (executable-find "zsh")))
    (if zsh
        (setq eat-shell zsh)
      (setq eat-shell (executable-find "bash"))))

  (global-set-key (kbd "s-e") 'eat)
  (add-hook 'eshell-load-hook #'eat-eshell-mode)
  (add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode))

(provide 'terminal)

;;; terminal.el ends here

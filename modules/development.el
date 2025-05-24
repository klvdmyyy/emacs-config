;;; development.el --- Setup GNU Emacs for development
;;
;;; Commentary:
;;
;; Development module. Configuration for development.
;;
;; Main languages (supported):
;; - Bash
;; - C/C++
;; - Python
;; - Go
;;
;; Other interesting languages (unsupported):
;; - Zig/Rust
;; - Perl
;; - Guile
;; - Clojure
;; - Common Lisp
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
                                (:exclude ".dir-locals.el" "*-tests.el")))
                   go-mode))
  (straight-use-package package))

(eval-when-compile
  (require 'eglot)
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

;; [FIX] I think it's so stupid fix of indentation. I need smth else maybe...
(dolist (mode '(go-mode))
 (dolist (char '("{" "(" "["))
  (sp-local-pair mode char nil :post-handlers '((indent-between-pair "RET")))))

(with-eval-after-load 'eat
  (let ((zsh (executable-find "zsh")))
    (if zsh
        (setq eat-shell zsh)
      (setq eat-shell (executable-find "bash"))))

  (global-set-key (kbd "s-e") 'eat)
  (add-hook 'eshell-load-hook #'eat-eshell-mode)
  (add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode))

(with-eval-after-load 'eglot
  ;; TODO
  )

(let ((clangd (executable-find "clangd"))
      (gopls (executable-find "gopls"))

      ;; Language servers and Static type checkers for python.
      ;;
      ;; One of the best is `basedpyright' it is a fork of `pyright' (also cool)
      ;;
      ;; Basic `pylsp' (`python3-lsp-server' or `python-language-server' in Fedora GNU/Linux)
      (pls (or (executable-find "basedbyright")
               (executable-find "pyright")
               (executable-find "pylsp")))

      ;; Language server for shell scripts (Bash only)
      (bash-language-server (executable-find "bash-language-server")))
  ;; Configure C/C++
  (when clangd
    ;; [TODO] clangd already configured and this section of code should be in `with-eval-after-load'
    ;; (add-to-list 'eglot-server-programs
    ;;              `((c-mode c-ts-mode c++-mode c++-ts-mode) . ,clangd))
    (dolist (mode '(c-mode-hook
                    c-ts-mode-hook
                    c++-mode-hook
                    c++-ts-mode-hook))
      (add-hook mode 'eglot-ensure)))

  ;; Configure Go
  (when gopls
    (dolist (mode '(go-mode-hook
                    go-ts-mode-hook))
      (add-hook mode 'eglot-ensure)))

  ;; Configure Python
  (when pls
    (dolist (mode '(python-mode-hook
                    python-ts-mode-hook))
      (add-hook mode 'eglot-ensure)))

  ;; Configure Bash
  (when bash-language-server
    (dolist (mode '(sh-mode-hook
                    bash-mode-hook
                    bash-ts-mode-hook))
      (add-hook mode 'eglot-ensure))))

;; Configure specific modes
(add-to-list 'auto-mode-alist '("\\.sh\\'" . sh-mode))

(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

(provide 'development)

;;; development.el ends here

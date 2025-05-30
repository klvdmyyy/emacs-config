;;; productivity.el --- Increase productivity with GNU Emacs
;;
;;; Commentary:
;;
;; [TODO] Maybe move `telega.el' configuration to another module
;;
;;; Code:

(dolist (package '(;; telega
                   markdown-mode))
  (straight-use-package package))

;; [TODO] Move `org-mode-indent' to appearance maybe !?
;; [TODO] Move `visual-line-mode' to appearance maybe !?
(dolist (mode '(org-indent-mode
                visual-line-mode))
  (add-hook 'org-mode-hook mode))

(setq org-directory "~/org")            ; Just default value

(setq org-agenda-files
      '("tasks.org"
        "birthdays.org"
        ;;"habits.org"
        ))

(defun open-org-directory ()
  (interactive)
  (dired org-directory))

(defun open-projects-directory ()
  (interactive)
  (dired "~/projects"))

(defun open-config ()
  (interactive)
  (dired user-init-dir))

(global-set-key
 (kbd "C-c o")
 'open-org-directory)

(global-set-key
 (kbd "C-c p")
 'open-projects-directory)

(global-set-key
 (kbd "C-c c")
 'open-config)

;; [TODO] Fedora TDLib 1.8.0 less then required 1.8.44 (minimum required)
;; (autoload 'telega "telega")
;; (setq telega-server-libs-prefix "/usr")
;; (dolist (hook '(server-switch-hook
;;                  server-after-make-frame-hook))
;;   (add-hook hook (lambda ()
;;                    (interactive)
;;                    (telega t))))
;; (add-hook 'emacs-startup-hook (lambda ()
;;                                 (interactive)
;;                                 (telega nil)))

;; [TODO] Setup markdown using `httpd' (emacs web server) and `impatient' with `markdown-mode':
;; https://stackoverflow.com/questions/36183071/how-can-i-preview-markdown-in-emacs-in-real-time
(autoload 'markdown-mode "markdown-mode-autoloads")
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(provide 'productivity)

;;; productivity.el ends here

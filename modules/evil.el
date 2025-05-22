;;; evil.el --- Emacs evil mode configuration
;;
;;; Commentary:
;;
;;; Code:

(dolist (package '(evil
                   key-chord))
  (straight-use-package package))

(eval-when-compile
  (require 'evil)
  (require 'key-chord))

(with-eval-after-load 'evil
  (evil-mode 1)

  (with-eval-after-load 'key-chord
    (key-chord-mode 1)
    (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)))

;;; evil.el ends here

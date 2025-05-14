(eval-when-compile
  (require 'smartparens))

(autoload 'smartparens-mode "smartparens-autoload")
(autoload 'smartparens-strict-mode "smartparens-autoload")

(add-hook 'prog-mode-hook 'smartparens-mode)
(add-hook 'prog-mode-hook 'smartparens-strict-mode)

(with-eval-after-load 'smartparens
  (sp-use-smartparens-bindings)

  (with-eval-after-load 'paren
    (setq show-paren-style 'mixed)
    (show-paren-mode 1))

  (require 'smartparens-config)
  (define-key smartparens-mode-map (kbd "M-s") nil)
  (setq sp-highlight-pair-overlay nil)
  (define-key smartparens-mode-map (kbd "M-S") 'sp-forward-slurp-sexp))

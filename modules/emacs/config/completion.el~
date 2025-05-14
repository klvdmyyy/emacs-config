(eval-when-compile
  (require 'marginalia)
  (require 'consult))

(with-eval-after-load 'mini-buffer
  (setq tab-always-indent 'complete)

  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook 'cursor-intangible-mode)
  (setq completion-show-help nil)
  (setq completions-format 'one-column)
  (setq completions-header-format nil)

  (let ((map minibuffer-mode-map))
    (define-key map (vector 'remap 'next-line)
		'minibuffer-next-completion)
    (define-key map (vector 'remap 'previous-line)
		'minibuffer-previous-completion))
  (let ((map completion-in-region-mode-map))
    (define-key map (kbd "C-n") 'minibuffer-next-completion)
    (define-key map (kbd "C-p") 'minibuffer-previous-completion))

  ;; Shows hidden prefix when completing candidates with partial style
  ;; (setq file-name-shadow-properties
  ;;       '(invisible t intangible t face file-name-shadow field shadow))

  ;; Will work if vertico is available, won't affect if it doesn't
  (add-hook 'rfn-eshadow-update-overlay-hook 'vertico-directory-tidy)

  ;; (advice-add 'completing-read-multiple
  ;;             :override 'consult-completing-read-multiple)

  ;; Needed for orderless in default completion UI.
  (let ((map minibuffer-local-completion-map))
    (define-key map (kbd "SPC") nil)
    (define-key map (kbd "?") nil))

  ;; Allows to use \\SPC instead of \\s-
  (setq orderless-component-separator
        'orderless-escapable-split-on-space)

  (defun rde-orderless-literal-dispatcher (pattern _index _total)
    "Literal style dispatcher using the equals sign as a suffix.
It matches PATTERN _INDEX and _TOTAL according to how Orderless
parses its input."
    (cond
     ((equal "=" pattern)
      '(orderless-literal . "="))
     ((string-suffix-p "=" pattern)
      (cons 'orderless-literal (substring pattern 0 -1)))))

  (defun rde-orderless-without-literal-dispatcher (pattern _index _total)
    "Literal without style dispatcher using the exclamation mark as a
suffix.  It matches PATTERN _INDEX and _TOTAL according to how Orderless
parses its input."
    (cond
     ((equal "!" pattern)
      '(orderless-literal . "!"))
     ((string-suffix-p "!" pattern)
      (cons 'orderless-without-literal (substring pattern 0 -1)))))

  (defun rde-orderless-initialism-dispatcher (pattern _index _total)
    "Leading initialism  dispatcher using the comma suffix.
It matches PATTERN _INDEX and _TOTAL according to how Orderless
parses its input."
    (cond
     ((equal "," pattern)
      '(orderless-literal . ","))
     ((string-suffix-p "," pattern)
      (cons 'orderless-initialism (substring pattern 0 -1)))))

  (defun rde-orderless-flex-dispatcher (pattern _index _total)
    "Flex  dispatcher using the tilde suffix.
It matches PATTERN _INDEX and _TOTAL according to how Orderless
parses its input."
    (cond
     ((equal "~" pattern)
      '(orderless-literal . "~"))
     ((string-suffix-p "~" pattern)
      (cons 'orderless-flex (substring pattern 0 -1)))))

  ;; (consult-initial-narrowing config)

  (setq orderless-style-dispatchers
        '(rde-orderless-literal-dispatcher
          rde-orderless-without-literal-dispatcher
          rde-orderless-initialism-dispatcher
          rde-orderless-flex-dispatcher))

  (require 'orderless)
  (setq completion-styles '(orderless basic))
  ;; (setq completion-category-defaults nil)
  (setq completion-category-overrides
        ;; basic is required for /ssh: completion to work, but
        ;; keep the same values for project-file too.
        '((project-file (styles . (orderless partial-completion basic)))
          (file (styles . (orderless partial-completion basic)))))
  (setq completion-category-defaults nil)
  (setq enable-recursive-minibuffers t)

  ;; (setq resize-mini-windows nil)
  
  ;; Mini-frame enabled
  (with-eval-after-load 'mini-frame
    (custom-set-faces
     '(child-frame-border
       ;; TODO: inherit ,(face-attribute 'default :foreground)
       ((t (:background "#000000")))))
    (put 'child-frame-border 'saved-face nil)

    (setq
     mini-frame-show-parameters
     `((top . 0.2)
       (width . 0.8)
       (left . 0.5)
       (child-frame-border-width . 1)))
    (setq mini-frame-detach-on-hide nil)
    (setq mini-frame-color-shift-step 0)
    (setq mini-frame-advice-functions
          '(read-from-minibuffer
            read-key-sequence
            save-some-buffers yes-or-no-p))
    (setq mini-frame-ignore-commands
          '(consult-line consult-line-multi consult-outline
			 consult-imenu consult-imenu-multi consult-history
			 consult-git-grep consult-ripgrep consult-grep
			 embark-bindings)))

  (autoload 'mini-frame-mode "mini-frame")
  (if after-init-time
      (mini-frame-mode 1)
    (add-hook 'after-init-hook 'mini-frame-mode)))

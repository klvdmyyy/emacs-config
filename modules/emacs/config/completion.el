(setq x-gtk-resize-child-frames 'resize-mode)

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
    (add-hook 'after-init-hook 'mini-frame-mode))

  (setq history-length 10000)
  (setq
   savehist-file
   (concat (or (getenv "XDG_CACHE_HOME") "~/.cache")
           "/emacs/history"))

  ;; (savehist-mode 1)
  ;; (run-with-idle-timer 30 t 'savehist-save)

  (define-key global-map (kbd "s-.") 'embark-act)
  (define-key global-map (kbd "s->") 'embark-become)


  (define-key minibuffer-local-map (kbd "M-r") 'consult-history)
  (define-key global-map (kbd "M-y") 'consult-yank-pop)
  (define-key global-map (kbd "s-B") 'consult-buffer)
  (define-key global-map (kbd "C-x C-r") 'consult-recent-file)
  (define-key minibuffer-local-map (kbd "s-g") 'embark-become)
  ;; (define-key global-map (kbd "M-.") 'embark-dwim)

  (let ((map goto-map))
    (define-key map (kbd "g") 'consult-goto-line)
    (define-key map (kbd "M-g") 'consult-goto-line)
    (define-key map (kbd "l") 'consult-line)
    (define-key map (kbd "o") 'consult-outline)
    (define-key map (kbd "i") 'consult-imenu)
    (define-key map (kbd "m") 'consult-mark)
    (define-key map (kbd "M") 'consult-global-mark)
    (define-key map (kbd "b") 'consult-bookmark))

  (defun rde-goto-line-relative ()
    "Just a wrapper around `consult-goto-line', which uses
relative line numbers, when narrowing is active."
    (interactive)
    (let ((consult-line-numbers-widen nil))
      (call-interactively 'consult-goto-line)))

  (define-key narrow-map (kbd "g") 'rde-goto-line-relative)

  (let ((map search-map))
    (define-key map (kbd "f") 'consult-find)
    (define-key map (kbd "g") 'consult-ripgrep)
    (define-key map (kbd "e") 'consult-isearch-history)
    (define-key map (kbd "l") 'consult-line))
  ;; (define-key global-map (kbd "C-S-s") 'consult-line)

  (autoload 'consult-isearch-history "consult")
  (let ((map isearch-mode-map))
    (define-key map (kbd "M-e") 'consult-isearch-history)
    (define-key map (kbd "M-s e") 'consult-isearch-history)
    (define-key map (kbd "M-s l") 'consult-line))
  ;; (define-key isearch-mode-map (kbd "C-S-s") 'consult-line)

  ;; MAYBE: Share this keybinding with switch-to-buffer?
  (define-key minibuffer-local-map (kbd "s-b") 'exit-minibuffer)

  (autoload 'consult-customize "consult" "" nil 'macro)
  (autoload 'consult--customize-set "consult")

  (autoload 'embark-open-externally "embark")
  (with-eval-after-load
      'embark
    (require 'embark-consult))

  (with-eval-after-load
      'xref
    (setq xref-show-xrefs-function 'consult-xref))

  (with-eval-after-load
      'consult
    (require 'embark-consult)

    ;(setq consult-ripgrep-args
    ;      (replace-regexp-in-string "^rg" ,(file-append ripgrep "/bin/rg")
    ;                                consult-ripgrep-args))
    ;(consult-customize consult-buffer :preview-key "M-.")
    ;(consult-customize consult-history :category 'consult-history)
    ;(consult-customize consult-line :inherit-input-method t)
    )

  (with-eval-after-load
      'marginalia
    (setq marginalia-align 'left))

  (autoload 'marginalia-mode "marginalia")
  (marginalia-mode 1))


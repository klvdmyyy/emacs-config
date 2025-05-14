(eval-when-compile
  (require 'vertico)
  (require 'vertico-multiform))

(with-eval-after-load
    'minibuffer
  (setq completion-in-region-function
        (lambda (&rest args)
          (apply (if vertico-mode
                     'consult-completion-in-region
                   'completion--in-region)
                 args))))

(with-eval-after-load
    'vertico

  (advice-add
   'vertico--format-candidate :around
   (lambda (orig cand prefix suffix index _start)
     (let ((cand (funcall orig cand prefix suffix index _start)))
       (concat
        (if (= vertico--index index)
            (propertize "» " 'face 'vertico-current)
          "  ")
        cand))))

  (define-key global-map (kbd "s-s") 'vertico-repeat)
  ;; TODO: Bind vertico-next/previous-group to more usual keys?

  (require 'vertico-repeat)
  (add-hook 'minibuffer-setup-hook 'vertico-repeat-save)
  (setq vertico-cycle t)

  (defvar rde--vertico-monocle-initial-configuration nil
    "Vertico multiform initial configuration.")

  (defvar rde--vertico-monocle-full nil
    "If vertico is fullframe or not.")

  (defun rde-vertico-toggle-monocle-full ()
    (when (member '(vertico-buffer-mode)
                  (cdr rde--vertico-monocle-initial-configuration))
      ;; if vertico is already in buffer mode, just toggle it to display
      ;; full-frame or in particular window
      (vertico-multiform-buffer))
    (vertico-multiform-buffer)
    (setq-local header-line-format mode-line-format)
    (setq-local mode-line-format nil))

  (defun rde-vertico-toggle-monocle ()
    (interactive)
    (unless rde--vertico-monocle-initial-configuration
      ;; We add 'initial-config to the beginning of the list to make
      ;; sure this condition is not triggered, when
      ;; vertico-multiform--stack is '(nil)

      ;; We need to copy-list to prevent modification of the variable
      ;; value, when vertico-multiform--stack is modified.
      (setq-local rde--vertico-monocle-initial-configuration
                  (cons 'initial-config
                        (cl-copy-list vertico-multiform--stack))))

    (if rde--vertico-monocle-full
        (progn
          (setq-local vertico-buffer-display-action
                      '(display-buffer-reuse-window))
          (rde-vertico-toggle-monocle-full)

          (set-window-configuration
           rde--monocle-previous-window-configuration)
          (setq-local rde--vertico-monocle-full nil)
          (setq rde--monocle-previous-window-configuration nil))
      (progn
        (setq rde--monocle-previous-window-configuration
              (current-window-configuration))
        (setq-local vertico-buffer-display-action '(display-buffer-full-frame))
        (setq-local rde--vertico-monocle-full t)
        (rde-vertico-toggle-monocle-full))))

  (keymap-set vertico-map "<remap> <rde-toggle-monocle>"
              'rde-vertico-toggle-monocle)

  (require 'vertico-directory)
  (defun rde-vertico-kill-region-dwim (&optional count)
    "The function kills region if mark is active, otherwise
calls `vertico-directory-delete-word'.  Prefix argument can be used to
kill a few words or directories."
    (interactive "p")
    (if (use-region-p)
        (kill-region (region-beginning) (region-end) 'region)
      (vertico-directory-delete-word count)))
  (define-key vertico-map (kbd "C-w") 'rde-vertico-kill-region-dwim)

  ;; TODO: Need to be more specific not to pollute histories.
  ;; (defadvice vertico-insert
  ;;   (after vertico-insert-add-history activate)
  ;;   "Make vertico-insert add to the minibuffer history."
  ;;   (unless (eq minibuffer-history-variable t)
  ;;     (add-to-history minibuffer-history-variable (minibuffer-contents))))

  (setq vertico-multiform-categories
        '((consult-grep buffer)
          (imenu buffer)
          (buffer)
          ;; (file buffer)
          ;; (project-file buffer)
          (info-menu buffer)
          (consult-org-heading buffer)
          (consult-history buffer)
          (consult-lsp-symbols buffer)
          (consult-xref buffer)
          (embark-keybinding buffer)
          (consult-location buffer)))

  (setq vertico-multiform-commands
        '((telega-chat-with buffer)
          (magit:--author flat)
          ;; For some reason it doesn't have an info-menu
          ;; category and also setting
          ;; marginalia-command-categories doesn't help
          ;; (org-roam-node-find buffer)
          (Info-goto-node buffer)
          (info-lookup-symbol buffer)
          (Info-follow-reference buffer)
          (consult-yank-pop buffer)))

  (autoload 'vertico-multiform-mode "vertico-multiform")
  (vertico-multiform-mode))

(autoload 'vertico-mode "vertico")
(if after-init-time
    (vertico-mode 1)
  (add-hook 'after-init-hook 'vertico-mode))

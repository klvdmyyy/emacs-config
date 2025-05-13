(use-modules (guix)
             (gnu packages emacs)
             (gnu packages emacs-xyz))

(package
 (inherit emacs-minimal)
 (propagated-inputs
  (list emacs-htmlize
        emacs-org
        emacs-ox-reveal
        emacs-simple-httpd))
 (replacement emacs-minimal))

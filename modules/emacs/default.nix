{
  pkgs,
  ...
}: {
  services.emacs = {
    enable = true;
    package = with pkgs; (
      (emacsPackageFor emacsPgtkNativeComp).emacsWithPackages (
        epkgs: with epkgs; [
          # ============================= From Me =============================
          gcmh
          monokai-pro-theme
          nix-mode
          
          # ======================== From RDE features ========================
          # Appearance (feature-emacs-appearance)
          # header-minions
          minions

          # EShell (feature-emacs-eshell)
          eshell-syntax-highlighting
          eshell-prompt-extras

          # All the icons (feature-emacs-all-the-icons)
          all-the-icons
          all-the-icons-completion

          /*
          # Completion (feature-emacs-completion)
          mini-frame
          orderless
          marginalia
          pcmpl-args
          cape
          consult
          embark
          # company
          # company-box

          # Vertico (feature-emacs-vertico)
          vertico

          # Corfu (feature-emacs-corfu) | replacing for company
          corfu
          # corfu-doc
          corfu-candidate-overlay

          # Eglot (feature-emacs-eglot) | replacing for lsp-mode
          consult-eglot

          # Git (feature-emacs-git)
          magit
          magit-todos
          git-link
          git-timemachine
          git-gutter-fringe
          # git-gutter-transient

          # Org (feature-emacs-org)
          org
          org-contrib
          # ox-html-stable-ids
          org-appear
          org-modern
          org-make-toc

          # Which-key (feature-emacs-which-key)
          which-key*/
          
          # Smartparens
          smartparens
        ]
      )
    );
  };
}

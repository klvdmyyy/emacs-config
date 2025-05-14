{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  services.emacs = {
    enable = true;
  };
  
  programs.emacs = {
    enable = true; # Maybe unnecessary ?! (we enabling emacs as system service)
    extraConfig = lib.mkBefore ''
${builtins.readFile ./config/general.el}
${builtins.readFile ./config/nix-mode.el}
${builtins.readFile ./config/smartparens.el}
${builtins.readFile ./config/org.el}
${builtins.readFile ./config/completion.el}
${builtins.readFile ./config/vertico.el}
    '';
    package = with pkgs; (
      (emacsPackagesFor emacs).emacsWithPackages
        (epkgs: with epkgs; [
          gcmh
          monokai-pro-theme
          nix-mode
          minions
          smartparens
          
          # Completion (feature-emacs-completion)
          mini-frame
          orderless
          marginalia
          pcmpl-args
          cape
          consult
          embark

          # Vertico (feature-emacs-vertico)
          vertico
        ])
    );
  };
}


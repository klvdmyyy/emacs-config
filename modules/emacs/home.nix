{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./features/nix-mode.nix
    ./features/org.nix
    ./features/smartparens.nix
  ];
  
  home.file.".config/emacs/early-init.el".source = ./config/early.el;
  
  programs.emacs = {
    enable = true; # Maybe unnecessary ?! (we enabling emacs as system service)
    extraConfig = lib.mkBefore ''
;; You can define/set variables there
${builtins.readFile ./config/general.el}
    ''
  };
}


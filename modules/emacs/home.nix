{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  home.file.".config/emacs/early-init.el".source = ./config/early.el;
  
  programs.emacs = {
    enable = true; # Maybe unnecessary ?! (we enabling emacs as system service)
    extraConfig = lib.mkBefore ''
${builtins.readFile ./config/general.el}
${builtins.readFile ./config/nix-mode.el}
${builtins.readFile ./config/smartparens.el}

${builtins.readFile ./config/org.el}
    ''
  };
}


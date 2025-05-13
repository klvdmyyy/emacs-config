{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  "klvdmyyy@fpc" = [
    ../modules/emacs/home.nix
    
    {
      home = {
        username = "klvdmyyy";
        homeDirectory = "/home/klvdmyyy";
        stateVersion = "24.11";
        packages = [
          inputs.zen-browser.packages.${pkgs.system}.default
        ];
      };

      program.home-manager.enable = true;
    }
  ];
}

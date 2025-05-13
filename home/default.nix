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
        packages = [
          inputs.zen-browser.packages.${pkgs.system}.default
        ];
      };
    }
  ];
}

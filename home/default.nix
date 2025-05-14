{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
      home = {
        username = "klvdmyyy";
        homeDirectory = "/home/klvdmyyy";
        stateVersion = "24.11";
        packages = [
          inputs.zen-browser.packages.${pkgs.system}.default
        ];
      };

      programs.zsh.enable = true;
      programs.home-manager.enable = true;
}

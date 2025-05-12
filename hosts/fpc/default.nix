{ config, pkgs, user, ... }:

{
  imports =
    [ (import ./hardware-configuration.nix) ] ++ # Hardware specific things
    [ (import ../../modules/gnome/default.nix) ]; # Use gnome for first configuration

  boot = {
    extraModulePackages = with config.boot.kernelPakckages; [];

    initrd.kernelModules = [
      "amdgpu"
      "k10temp"
    ];

    kernelParams = [];
  };

  # GPU specific things
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
    };
  };
}

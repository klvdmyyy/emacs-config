{ lib, nixpkgs, home-manager, inputs, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = false;
  };

  lib = nixpkgs.lib;
in
{
  fpc = lib.nixosSystem {
    inherit system;

    specialArgs = {
      # Provide variables for configuration
      inherit inputs system;

      host = {
        hostName = "ix";
      };
    };
    modules = [
      ./fpc
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          host = {
            hostName = "ix";
          };
        };
        home-manager.users.klvdmyyy = {
          imports = [
            ./home.nix
            ./fpc/home.nix
          ];
        };
      }
    ];
  };
}

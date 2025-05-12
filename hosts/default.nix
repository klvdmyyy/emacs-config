{
  self,
  inputs,
  ...
}: {
  flake.nixosConfiguration = let
    # shorten path
    inherit (inputs.nixpkgs.lib) nixosSystem;

    homeImports = import "${self}/home/profiles";

    mod = "${self}/system";

    specialArgs = {inherit inputs self;};
  in {
    fpc = nixosSystem {
      inherit specialArgs;
      modules =
        desktop ++ [
          ./fpc

          "${mod}/core/boot.nix"
          "${mod}/programs/gamemode.nix"
          "${mod}/programs/hyprland"
          "${mod}/programs/games.nix"

          {
            home-manager = {
              users.klvdmyyy.imports = homeImports."klvdmyyy@fpc";
              extraSpecialArgs = specialArgs;
              backupFileExtension = ".hm-backup";
            };
          }
        ];
    };
  }
}

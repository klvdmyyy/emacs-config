{
  self,
  inputs,
  ...
}: { flake.nixosConfigurations = let
     inherit (inputs.nixpkgs.lib) nixosSystem;
     
     homeImports = import "${self}/home";
     
     specialArgs = {
       inherit inputs self;
/*
       pkgs = import inputs.nixpkgs {
         system = "x86_64-linux";
         config.allowUnfree = false;
         overlays = [ inputs.emacs-overlay.overlays.default ];
       };
*/
     };
   in {
     fpc = nixosSystem {
       inherit specialArgs;
       modules = [
         # Specific hardware configuration
         ./fpc
         "${self}/modules/gnome"

         inputs.home-manager.nixosModules.home-manager {
           home-manager = {
             users.klvdmyyy.imports = [
               ../modules/gnome/home.nix
               ../modules/emacs/home.nix
               ../home
             ];
             extraSpecialArgs = specialArgs;
             backupFileExtension = ".hm-backup";
           };
         }
       ];
     };
   };
}

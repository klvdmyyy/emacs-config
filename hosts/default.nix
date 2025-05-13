{
  self,
  inputs,
  ...
}: flake.nixosConfigurations = let
     inherit (inputs.nixpkgs.lib) nixosSystem;

     homeImports = import "${self}/home";
     
     specialArgs = {inherit inputs self;};
   in {
     fpc = nixosSystem {
       inherit specialArgs;
       modules = [
         # Specific hardware configuration
         ./fpc
         "${self}/modules/gnome"
         "${self}/modules/emacs"

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

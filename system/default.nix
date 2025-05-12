let
  desktop = [
    ./core
    ./core/boot.nix

    ./hardware/graphics.nix

    ./network

    ./programs

    ./services
    ./services/power.nix
    ./services/greetd.nix
    ./services/pipewire.nix
  ];
in {
  inherit desktop;
}

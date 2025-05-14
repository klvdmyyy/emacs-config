{
  lib,
  inputs,
  pkgs,
  ...
}: let
in {
  home.packages = with pkgs; [
    grim
    slurp

    wl-clipboard
    # wl-screenrec
    wlr-randr
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}

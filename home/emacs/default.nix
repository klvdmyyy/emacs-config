{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  emacsWithPackages = (pkgs.emacsPackagesFor pkgs.emacsNativeComp).emacsWithPackages;

  emacsBuild = emacsWithPackages (epkgs: with epkgs; [
    gcmh
    monokai-pro-theme
  ]);
in {
  # TODO: Emacs configuration from `org-babel-emacs-1'-like branch
}

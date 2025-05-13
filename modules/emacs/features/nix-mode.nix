{
  config,
  ...
}: {
  programs.emacs.extraConfig = ''
${builtins.readFile ../config/nix-mode.el}
  '';
}

{
  config,
  ...
}: {
  programs.emacs.extraConfig = ''
${builtins.readFile ../config/smartparens.el}
  '';
}

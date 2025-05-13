{
  config,
  ...
}: {
  programs.emacs.extraConfig = ''
${builtins.readFile ../config/org.el}
  '';
}

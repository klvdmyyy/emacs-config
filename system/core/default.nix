{
  lib,
  ...
}: {
  imports = [
    ./security.nix
    ./users.nix
    ../nix
    ../programs/zsh.nix
  ];

  documentation.dev.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";

    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
  };

  # DON'T TOUCH THIS !!!
  system.stateVersion = lib.mkDefault "24.11";

  time.timeZone = lib.mkDefault "Asia/Yekaterinburg";

  zramSwap.enable = true;
}

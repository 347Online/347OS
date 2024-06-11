{
  lib,
  config,
  username,
  ...
}: {
  options = {
    darwin.homebrew.enable = lib.mkEnableOption "homebrew setup";
  };

  config = lib.mkIf config.darwin.homebrew.enable {
    nix-homebrew = {
      enable = true;
      user = username;
      autoMigrate = true;
    };

    homebrew = {
      enable = true;

      onActivation = {
        autoUpdate = true;
        upgrade = true;
      };

      masApps = {
        "1Password for Safari" = 1569813296;
        "Noir" = 1592917505;
        "Magic Lasso" = 1198047227;
        "GoodLinks" = 1474335294;
        "Numbers" = 409203825;
        "Pages" = 409201541;
        "Fantastical" = 975937182;
        # "Overcast" = 888422857; # Currently broken
      };

      casks = [
        "raycast"
        "setapp"
        "scroll-reverser"
        "logi-options-plus"
      ];
    };

    environment.variables = {
      HOMEBREW_PREFIX = "/opt/homebrew";
      HOMEBREW_CELLAR = "/opt/homebrew/Cellar";
      HOMEBREW_REPOSITORY = "/opt/homebrew/Library/.homebrew-is-managed-by-nix";
      PATH = "/opt/homebrew/bin:/opt/homebrew/sbin\${PATH+:$PATH}";
      MANPATH = "/opt/homebrew/share/man\${MANPATH+:$MANPATH}:";
      INFOPATH = "/opt/homebrew/share/info:\${INFOPATH:-}";
    };
  };
}

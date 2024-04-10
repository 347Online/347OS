{
  homebrew = {
    enable = true;
    masApps = {
      "1Password for Safari" = 1569813296;
      "Noir" = 1592917505;
      "Magic Lasso" = 1198047227;
      "GoodLinks" = 1474335294;
    };
    casks = [
      "raycast"
      "1password"
      "1password-cli"
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
}

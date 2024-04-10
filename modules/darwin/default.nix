{
  pkgs,
  hostPlatform,
  username,
  ...
}: {
  environment.systemPackages = with pkgs; [
    raycast
  ];

  homebrew = {
    enable = true;
    masApps = {
      "1Password for Safari" = 1569813296;
      "Noir" = 1592917505;
      "Magic Lasso" = 1198047227;
      "GoodLinks" = 1474335294;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  # DO NOT EDIT BELOW
  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  programs.bash.enable = true;
  programs.fish.enable = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = hostPlatform;
  environment.variables = {
    HOMEBREW_PREFIX = "/opt/homebrew";
    HOMEBREW_CELLAR = "/opt/homebrew/Cellar";
    HOMEBREW_REPOSITORY = "/opt/homebrew/Library/.homebrew-is-managed-by-nix";
    PATH = "/opt/homebrew/bin:/opt/homebrew/sbin\${PATH+:$PATH}";
    MANPATH = "/opt/homebrew/share/man\${MANPATH+:$MANPATH}:";
    INFOPATH = "/opt/homebrew/share/info:\${INFOPATH:-}";
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings.experimental-features = "nix-command flakes";
  };
  nixpkgs.config = {
    allowUnsupportedSystem = true;
    allowUnfree = true;
  };

  users.users."${username}" = {
    name = username;
    home = "/Users/${username}";
  };

  system.stateVersion = 4;
}

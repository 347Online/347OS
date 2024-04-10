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
    brews = [
      "mas"
    ];
    masApps = {
      "1Password for Safari" = 1569813296;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  # DO NOT EDIT BELOW
  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  environment.shellInit = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = hostPlatform;

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

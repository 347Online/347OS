{
  pkgs,
  username,
  intel ? false,
  ...
}: let
  hostPlatform =
    if intel
    then "x86_64-darwin"
    else "aarch64-darwin";
in {
  nixpkgs = {
    inherit hostPlatform;

    config = {
      allowUnsupportedSystem = true;
      allowUnfree = true;
    };
  };

  users.users."${username}" = {
    name = username;
    home = "/Users/${username}";
  };

  # DO NOT EDIT BELOW
  system.stateVersion = 4;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings.experimental-features = "nix-command flakes";
  };
}

{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./homebrew.nix
    ./nixConfig.nix
  ];

  security.pam.enableSudoTouchIdAuth = true;

  programs.zsh.enable = true;
  programs.bash.enable = true;
  programs.fish.enable = true;

  users.users."${username}" = {
    name = username;
    home = "/Users/${username}";
  };

  # DO NOT EDIT BELOW
  system.stateVersion = 4;
}

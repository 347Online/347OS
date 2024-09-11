{lib, ...}: {
  imports = [
    ./minecraft.nix
  ];

  options = {
    games.enable = lib.mkEnableOption "games";
  };
}

{
  config,
  pkgs,
  lib,
  util,
  ...
}: let
  cfg = config.wayland.windowManager.sway.config;
in {
  imports = [
    ./cursor.nix
    ./waybar.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      terminal = "${pkgs.wezterm}/bin/wezterm";
      modifier = "Mod4";
      menu = "${pkgs.fuzzel}/bin/fuzzel -f Dina:size=18 | ${pkgs.findutils}/bin/xargs swaymsg exec --";
      keybindings = with cfg;
        lib.mkOptionDefault {
          "${modifier}+space" = "exec ${menu}";
          "${modifier}+d" = null;
        };
    };
  };
  programs.fuzzel.enable = true;

  # home.file = util.toHomeFiles ./dotfiles;

  home.packages = with pkgs; [
    webcord
    blueberry
    pavucontrol
    acpi
  ];
}

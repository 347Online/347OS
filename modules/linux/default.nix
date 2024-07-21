{
  pkgs,
  lib,
  ...
}: {
  # TODO: Make it so these are not strictly HM modules
  imports = [
    ./cursor.nix
    ./waybar.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      terminal = "${pkgs.wezterm}/bin/wezterm";
      modifier = "Mod4";
      menu = "${pkgs.fuzzel}/bin/fuzzel -f Dina:size=18 | ${pkgs.findutils}/bin/xargs swaymsg exec --";
      keybindings = lib.mkOptionDefault {
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

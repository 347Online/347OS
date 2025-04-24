{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.user.gui.enable {
  programs.ghostty = {
    enable = true;
    package = lib.mkIf pkgs.stdenv.isDarwin null;

    enableZshIntegration = true;
    enableBashIntegration = true;

    themes = {
      tinted-theming = {
        # vim: ft=ghostty
        # standardized-dark theme for Ghostty
        # Scheme Author: ali (https://github.com/ali-githb/base16-standardized-scheme)
        # Scheme System: base16
        # Template Author: Tinted Terminal (https://github.com/tinted-theming/tinted-terminal)

        # Color palette

        palette = [
          "0=#222222"
          "1=#e15d67"
          "2=#5db129"
          "3=#e1b31a"
          "4=#00a3f2"
          "5=#b46ee0"
          "6=#21c992"
          "7=#c0c0c0"
          "8=#555555"
          "9=#e15d67"
          "10=#5db129"
          "11=#e1b31a"
          "12=#00a3f2"
          "13=#b46ee0"
          "14=#21c992"
          "15=#ffffff"
          "16=#fc804e"
          "17=#b87d28"
          "18=#303030"
          "19=#555555"
          "20=#898989"
          "21=#e0e0e0"
        ];

        # Foreground & background colors
        background = "#222222";
        foreground = "#c0c0c0";
        cursor-color = "#c0c0c0";
        selection-background = "#555555";
        selection-foreground = "#c0c0c0";

        # Set `macos-icon = custom-style` in your main configuration file to enable theming of the app icon.
        #
        # Set the ghost color to the lightest foreground:
        macos-icon-ghost-color = "#ffffff";
        # Replace the official icon's blue background with the designated bright blue color:
        macos-icon-screen-color = "#00a3f2";
      };
    };

    settings = {
      auto-update = "download";
      auto-update-channel = "tip";
      confirm-close-surface = false;
      cursor-style-blink = false;
      shell-integration-features = [ "no-cursor" ];
      theme = "tinted-theming";
    };
  };
}

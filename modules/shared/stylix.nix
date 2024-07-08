{
  lib,
  pkgs,
  username,
  ...
}: {
  stylix = {
    enable = true;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/standardized-dark.yaml";
    polarity = "dark";

    # image = ./modules/linux/wp-neon-city.jpg;
    # imageScalingMode = "fit";
    fonts.monospace = {
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      name = "JetBrainsMono Nerd Font";
    };
  };
  # home-manager.users.${username}.stylix = {
  #   targets = {
  #     alacritty.enable = false;
  #     waybar.enable = lib.mkIf (!pkgs.stdenv.isDarwin) false;
  #   };
  # };
}

{
  pkgs,
  util,
  isDarwin,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = let
      themePrefix = "${pkgs.base16-schemes}/share/themes";
    in
      util.mkIfElse isDarwin "${themePrefix}/standardized-dark.yaml" "${themePrefix}/spacemacs.yaml";
    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrainsMono Nerd Font";
      };
      sizes.terminal = util.mkIfElse isDarwin 13 9;
    };
  };
}

{
  lib,
  pkgs,
  username,
  util,
  isDarwin,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/spacemacs.yaml";
    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrainsMono Nerd Font";
      };
      sizes.terminal = util.mkIfElse isDarwin 12 9;
    };
  };
}

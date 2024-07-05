{
  pkgs,
  lib,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "${pkgs.alacritty-theme}/iterm.toml"
      ];
      window.option_as_alt = lib.mkIf isDarwin "Both";

      mouse.hide_when_typing = false;
      env.term = "xterm-256color";
      font = {
        normal.family = lib.mkDefault "JetBrainsMono Nerd Font";

        #   then 13
        #   else 9;
        size = lib.mkMerge [
          (lib.mkIf isDarwin (lib.mkForce 13))
          (lib.mkIf (!isDarwin) (lib.mkForce 9))
        ];
      };
    };
  };
}

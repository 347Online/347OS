{
  util,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
in {
  home.packages = with pkgs; [
    bat
    eza
    ripgrep
  ];

  programs = {
    alacritty = {
      enable = true;
      settings = {
        import = [
          "${pkgs.alacritty-theme}/iterm.toml"
        ];
        window.option_as_alt = lib.mkIf isDarwin "Both";
        env.term = "xterm-256color";
        font = {
          normal.family = "JetBrainsMono Nerd Font";
          size =
            if isDarwin
            then 13
            else 6;
        };
      };
    };

    bash.shellAliases = util.mkShellAliases pkgs;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    tmux = {
      enable = true;
      baseIndex = 1;
      mouse = true;
      shortcut = "Space";
      terminal = "xterm-256color";
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd"
        "cd"
      ];
      enableZshIntegration = true;
    };
  };
}

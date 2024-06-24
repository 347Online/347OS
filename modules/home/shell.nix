{
  util,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    bat
    eza
    ripgrep
  ];

  programs = {
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

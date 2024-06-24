{
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
  shellAliases = with pkgs; {
    "bash" = "${bash}/bin/bash";
    "cat" = "${bat}/bin/bat";
    "ls" = "${pkgs.eza}/bin/eza";
    "tree" = "${pkgs.eza}/bin/eza --tree";
    "grep" = "${pkgs.ripgrep}/bin/rg";
    "diff" = "${pkgs.delta}/bin/delta";

    "code" = "${vscodium}/bin/codium";

    "git" = "${git}/bin/git";
    "branch" = "${git}/bin/git branch --show-current";

    "python3" = "${python3}/bin/python";
    "vi" = "nvim";
    "vim" = "nvim";
  };
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
    kitty = {
      enable = true;
      font.name = "JetBrainsMono Nerd Font";
      font.size = 12;
      settings = {
        confirm_os_window_close = 0;
      };
      darwinLaunchOptions = [
        "--single-instance"
      ];

      shellIntegration.enableZshIntegration = true;
    };

    bash.shellAliases = shellAliases;

    zsh = {
      inherit shellAliases;

      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      initExtraFirst = ''
        # TODO: Rework this config for .zshrc in dotfiles, remove readFile kludge
        # Powerlevel10k Zsh theme
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        ${builtins.readFile ./.zshrc}
      '';
    };

    fzf.enable = true;

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

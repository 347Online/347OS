{
  config,
  lib,
  pkgs,
  ...
}: let
  shellAliases = with pkgs; {
    "bash" = "${bash}/bin/bash";
    "branch" = "${git}/bin/git branch --show-current";
    "cat" = "${bat}/bin/bat";
    "code" = "${vscodium}/bin/codium";
    "git" = "${git}/bin/git";
    "python3" = "${python3}/bin/python";
    "vi" = "nvim";
    "vim" = "nvim";
  };

  shellIntegrations = {
    enableBashIntegration = false;
    enableZshIntegration = false;
    enableNushellIntegration = true;
    enableFishIntegration = true;
  };
in {
  options = {
    code.shell.enable = lib.mkEnableOption "shell setup";
  };

  config = lib.mkIf config.code.shell.enable {
    home.file.".config/zsh/.p10k.zsh".source = ../dotfiles/.config/zsh/.p10k.zsh;
    home.file.".hushlogin".text = "";

    programs = {
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

        shellIntegration.enableFishIntegration = true;
      };

      bash.shellAliases = shellAliases;

      fish = {
        enable = true;
        plugins = [
          # Experimental
          {
            name = "nix.fish";
            src = pkgs.fetchFromGitHub {
              owner = "kidonng";
              repo = "nix.fish";
              rev = "master";
              sha256 = "sha256-GMV0GyORJ8Tt2S9wTCo2lkkLtetYv0rc19aA5KJbo48=";
            };
          }
        ];
        inherit shellAliases;
      };

      nushell = {
        inherit shellAliases;
        enable = true;
        configFile.source = ../dotfiles/.config/nushell/config.nu;
      };

      zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        autosuggestion.enable = true;
        initExtraFirst = ''
          # Powerlevel10k Zsh theme
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          ${builtins.readFile ../dotfiles/.zshrc}
        '';
        shellAliases = shellAliases // {"ls" = "${pkgs.eza}/bin/eza";};
      };

      fzf.enable = true;

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      carapace =
        shellIntegrations
        // {
          enable = true;
        };

      starship =
        shellIntegrations
        // {
          enable = true;
        };

      zoxide =
        shellIntegrations
        // {
          enable = true;
          options = [
            "--cmd"
            "cd"
          ];
        };
    };
  };
}

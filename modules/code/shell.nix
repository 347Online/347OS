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
    enableNushellIntegration = true;
    enableFishIntegration = true;
  };
in {
  options = {
    shellSetup.enable = lib.mkEnableOption "shell setup";
  };

  config = lib.mkIf config.shellSetup.enable {
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
        initExtra = ''
          # Powerlevel10k Zsh theme
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          test -f ~/.config/zsh/.p10k.zsh && source ~/.config/zsh/.p10k.zsh

          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
          export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
          zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

          eval "$(fzf --zsh)"

          HISTDUP=erase
          setopt appendhistory
          setopt sharehistory
          setopt hist_ignore_space
          setopt hist_ignore_all_dups
          setopt hist_ignore_dups
          setopt hist_save_no_dups
          setopt hist_find_no_dups
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

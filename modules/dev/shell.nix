{pkgs, ...}: let
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
  # TODO: Potentially change this to apply to all new windows
  # xdg.configFile."./kitty/startup_session".text = ''
  #   launch ${pkgs.bash}/bin/bash -li -c ${pkgs.nushell}/bin/nu
  # '';

  programs = {
    kitty = {
      enable = true;
      font.name = "JetBrainsMono Nerd Font";
      font.size = 12;
      settings = {
        confirm_os_window_close = 0;
        startup_session = "./startup_session";
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
      enable = true;
      configFile.source = ../dotfiles/.config/nushell/config.nu;
      inherit shellAliases;
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
}

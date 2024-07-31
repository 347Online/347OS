{
  config,
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [
    ./nix.nix
  ];

  options = {
    linux = {
      headless = lib.mkEnableOption "headless operation";
    };
  };

  config = lib.mkMerge [
    {
      security.pam = {
        services = {
          login.u2fAuth = true;
          sudo.u2fAuth = true;
        };
        yubico = {
          enable = true;
          mode = "challenge-response";
          id = ["28646857"];
        };
      };

      services = {
        pcscd.enable = true;
        openssh.enable = true;
        printing.enable = true;
        gnome.gnome-keyring.enable = true;
        udev.packages = with pkgs; [yubikey-personalization];
      };

      users.users.katie = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = ["wheel"];
      };

      programs.zsh.enable = true;
      programs._1password.enable = true;
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };

      # home.file = util.toHomeFiles ./dotfiles;

      environment.systemPackages = with pkgs; [
        vim
        killall
      ];
    }

    (lib.mkIf (!config.linux.headless) {
      programs.sway.enable = true;
      programs._1password-gui.enable = true;

      services.greetd = {
        # TODO: only if not headless
        enable = true;
        settings = {
          initial_session = {
            command = "${pkgs.sway}/bin/sway";
            user = "katie";
          };
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet -t -r --asterisks";
            user = "greeter";
          };
        };
      };

      environment.systemPackages = with pkgs; [
        # Electron Apps
        # webcord
        # element-desktop # TODO: Only if a private machine
        # obsidian

        wev
        playerctl
        paper-plane
        blueberry
        pavucontrol
        acpi
      ];

      home-manager = {
        users.${username} = {
          wayland.windowManager.sway = {
            enable = true;
            config = rec {
              terminal = "${pkgs.wezterm}/bin/wezterm";
              modifier = "Mod4";
              menu = "${pkgs.fuzzel}/bin/fuzzel -f Dina:size=18 | ${pkgs.findutils}/bin/xargs swaymsg exec --";
              keybindings = lib.mkOptionDefault {
                "${modifier}+space" = "exec ${menu}";
                "${modifier}+d" = null;
              };
              startup = [
                {command = "1password --silent";}
              ];
            };
          };

          programs.fuzzel.enable = true;
          programs.waybar = {
            enable = true;
            systemd.enable = true;
          };

          home.pointerCursor = {
            gtk.enable = true;
            x11.enable = true;
          };

          home.packages = with pkgs; [
            acpi
          ];
        };
      };
    })
  ];
}

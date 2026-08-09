{
  flake.nixosModules.default =
    {
      config,
      pkgs,
      lib,
      username,
      util,
      ...
    }:
    {
      imports = [
        ./plasma

        ./games.nix
        ./keyd.nix
        ./nix.nix
        ./options.nix
        ./sops.nix
      ];

      config = lib.mkMerge [
        {
          security.pam = {
            services = {
              login.u2fAuth = true;
              sudo.u2fAuth = true;
            };
            # yubico = {
            #   enable = true;
            #   mode = "challenge-response";
            #   id = ["28646857"];
            # };
          };

          services = {
            fail2ban.enable = lib.mkDefault config.networking.firewall.enable;
            fwupd.enable = true;
            openssh.enable = true;
            # pcscd.enable = true;
            printing.enable = true;
            # udev.packages = with pkgs; [
            #   yubikey-personalization
            #   libu2f-host
            # ];
          };

          time.timeZone = "America/Denver";

          users.users.${username} = {
            isNormalUser = true;
            shell = pkgs.zsh;
            extraGroups = [
              "input"
              "networkmanager"
              "wheel"
            ];
          };

          programs.git.enable = true;
          programs.zsh.enable = true;
          programs._1password.enable = true;
          programs.gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
          };

          i18n = {
            defaultLocale = "en_US.UTF-8";

            extraLocaleSettings = {
              LC_ADDRESS = "en_US.UTF-8";
              LC_IDENTIFICATION = "en_US.UTF-8";
              LC_MEASUREMENT = "en_US.UTF-8";
              LC_MONETARY = "en_US.UTF-8";
              LC_NAME = "en_US.UTF-8";
              LC_NUMERIC = "en_US.UTF-8";
              LC_PAPER = "en_US.UTF-8";
              LC_TELEPHONE = "en_US.UTF-8";
              LC_TIME = "en_US.UTF-8";
            };
          };

          networking.networkmanager.enable = true;

          environment = {
            enableAllTerminfo = true;
            systemPackages =
              with pkgs;
              [
                vim
                killall
                keyd
                file
                pciutils
                usbutils
                lm_sensors
                wl-clipboard
                gcc
                gnumake
              ]
              ++ util.mkEssentials pkgs;
          };
        }

        (lib.mkIf config.nixos.gui.enable {
          programs._1password-gui = {
            enable = true;
            polkitPolicyOwners = [ username ];
          };

          services = {
            desktopManager.plasma6.enable = true;
            displayManager.sddm = {
              enable = true;
              wayland.enable = true;
            };
          };

          environment.systemPackages = with pkgs; [
            acpi
            firefox
          ];
        })
      ];
    };
}

{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  imports = [
    ./plasma

    ./games.nix
    ./keyd.nix
    ./nix.nix
    ./sops.nix

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

      users.users.${username} = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [
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

      networking.networkmanager.enable = true;

      environment = {
        enableAllTerminfo = true;
        systemPackages =
          let
            essentials = (import ../user/programs/essentials.nix pkgs);
          in
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
          ++ essentials;
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
}

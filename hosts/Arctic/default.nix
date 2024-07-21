{
  lib,
  pkgs,
  nvim,
  ...
}: {
  imports = [
    ./hardware.nix
  ];

  # LOCAL

  boot.binfmt.emulatedSystems = ["x86_64-linux"];
  networking.hostName = "Arctic";
  stylix.image = ./wp-neon-city.jpg;

  # SHARED # TODO Move to module

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  security.pam.yubico = {
    enable = true;
    debug = true;
    mode = "challenge-response";
    id = ["28646857"];
  };

  programs.sway.enable = true;
  programs.zsh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services = {
    pcscd.enable = true;
    udev.packages = with pkgs; [yubikey-personalization];
    greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "${pkgs.sway}/bin/sway"; # TODO: Only if not headless
          user = "katie";
        };
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet -t -r --asterisks";
          user = "greeter";
        };
      };
    };
    openssh.enable = true;
    printing.enable = true;
    displayManager = {
      autoLogin = {
        enable = true;
        user = "katie";
      };
    };
    gnome.gnome-keyring.enable = true;
  };

  time.timeZone = "America/Chicago";

  users.users.katie = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel"];
  };

  environment.systemPackages = with pkgs; [
    nvim
  ];

  # DO NOT EDIT
  system.stateVersion = "24.11";
}

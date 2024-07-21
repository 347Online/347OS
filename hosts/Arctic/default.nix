{
  lib,
  pkgs,
  nvim,
  ...
}: {
  imports = [
    ./hardware.nix
  ];

  boot.binfmt.emulatedSystems = ["x86_64-linux"];

  networking.hostName = "Arctic";
  stylix.image = ./wp-neon-city.jpg;

  programs.zsh.enable = true;

  services = {
    greetd = {
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
    openssh.enable = true;
    printing.enable = true;
    displayManager = {
      autoLogin = {
        enable = true;
        user = "katie";
      };
      sddm = {
        enable = false;
        enableHidpi = true;
        wayland.enable = true;
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

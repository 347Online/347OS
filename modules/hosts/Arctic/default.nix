{pkgs, ...}: {
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "Arctic";

  programs.zsh.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services = {
    greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
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
  };

  time.timeZone = "America/Chicago";

  users.users.katie = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel"];
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];

  # DO NOT EDIT
  system.stateVersion = "24.11";
}

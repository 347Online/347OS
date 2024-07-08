{
  pkgs,
  nvim,
  ...
}: {
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
    # greetd = {
    #   enable = false;
    #   settings = {
    #     initial_session = {
    #       command = "${pkgs.hyprland}/bin/Hyprland";
    #       user = "katie";
    #     };
    #     default_session = {
    #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet -t -r --asterisks";
    #       user = "greeter";
    #     };
    #   };
    # };
    openssh.enable = true;
    printing.enable = true;
    displayManager = {
      autoLogin = {
        enable = false;
        user = "katie";
      };
      sddm = {
        enable = false;
        enableHidpi = true;
        wayland.enable = true;
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
    nvim
  ];

  # DO NOT EDIT
  system.stateVersion = "24.11";
}

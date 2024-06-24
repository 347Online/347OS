{pkgs, ...}: {
  home.packages = with pkgs; [
    bat
    eza
    ripgrep
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    
  };
}

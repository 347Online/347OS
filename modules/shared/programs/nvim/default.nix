{
  imports = [
    ./plugins
  ];

  globals.mapleader = ",";

  opts = {
    wrap = false;
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    expandtab = true;
    autoindent = true;
    termguicolors = true;
  };

  colorschemes.tokyonight = {
    settings.style = "night";
    enable = true;
  };
  # colorschemes.cyberdream.enable = true;
  # colorschemes.vscode
  # colorschemes.onedark = {
  #   # enable = true;
  #   settings.style = "warmer";
  # };
}

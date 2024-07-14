{
  imports = [
    ./plugins
  ];

  globals.mapleader = ",";

  opts = {
    foldenable = false;
    wrap = false;
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    expandtab = true;
    autoindent = true;
  };

  colorschemes.tokyonight = {
    settings.style = "night";
    enable = true;
  };
}

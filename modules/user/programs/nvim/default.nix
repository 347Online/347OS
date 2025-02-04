{
  imports = [
    ./plugins

    ./keymaps.nix
  ];

  globals.mapleader = ",";

  opts = {
    foldenable = false;
    wrap = false;
    number = true;
    relativenumber = true;
    shiftround = true;
    shiftwidth = 2;
    tabstop = 2;
    expandtab = true;
    autoindent = true;
    smartindent = true;
    cursorline = true;
  };

  extraFiles."ftplugin/go.lua".text =
    # lua
    ''
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
    '';

  # TODO: Create some kinda option for this

  # Onedark kinda mood
  # colorschemes.onedark = {
  #   enable = true;
  #   settings = {
  #     style = "warmer";
  #   };
  # };

  # Catppuccin kinda mood
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "mocha";
    };
  };

  # VSCode kinda mood
  # colorschemes.vscode = {
  #   enable = true;
  #   settings = {
  #     italic_comments = true;
  #     underline_links = true;
  #   };
  # };

  # Tokyo Night kinda mood
  # colorschemes.tokyonight = {
  #   settings.style = "night";
  #   enable = true;
  # };
}

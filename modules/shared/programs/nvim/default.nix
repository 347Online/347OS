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

  # TODO: Create some kinda option for this

  # Catppuccin kinda mood
  # colorschemes.catppuccin = {
  #   enable = true;
  #   settings = {
  #     flavour = "mocha";
  #   };
  # };

  # VSCode kinda mood
  colorschemes.vscode = {
    enable = true;
    settings = {
      italic_comments = true;
      underline_links = true;
    };
  };

  # Tokyo Night kinda mood
  # colorschemes.tokyonight = {
  #   settings.style = "night";
  #   enable = true;
  # };
}

{
  imports = [
    ./plugins
  ];

  globals = {
    mapleader = ",";
    delimitMate_expand_cr = true;
    delimitMate_expand_inside_quotes = true;
    delimitMate_autoclose = false;
  };

  opts = {
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

  keymaps = [
    {
      mode = "n";
      key = "<leader>n";
      action = ":Neotree action=focus reveal toggle<CR>";
      options.silent = true;
    }
  ];
}

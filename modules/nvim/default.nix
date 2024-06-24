{
  imports = [
    ./plugins
  ];

  extraConfigVim = ''
    let delimitMate_expand_cr = 1
    let delimitMate_expand_inside_quotes = 1
    let delimitMate_autoclose = 0
  '';

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

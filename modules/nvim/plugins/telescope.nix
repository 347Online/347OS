{
  plugins.telescope = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>p";
      action = ":Telescope find_files<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>F";
      action = ":Telescope live_grep<CR>";
      options.silent = true;
    }
  ];
}

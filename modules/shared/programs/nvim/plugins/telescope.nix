{
  plugins.telescope = {
    pickers = {
      find_files.hidden = true;
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>ff";
      action = ":Telescope find_files<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>fa";
      action = ":Telescope live_grep<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>fc";
      action = ":Telescope current_buffer_fuzzy_find<CR>";
      options.silent = true;
    }
  ];
}

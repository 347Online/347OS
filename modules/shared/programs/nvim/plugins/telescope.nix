{
  keymaps = [
    {
      mode = "n";
      key = "<leader>p";
      action = ":Telescope find_files<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>f";
      action = ":Telescope live_grep<CR>";
      options.silent = true;
    }
  ];
}

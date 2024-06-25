{
  plugins.gitsigns = {
    enable = true;
    settings = {
      current_line_blame = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>gp";
      action = ":Gitsigns preview_hunk<CR>";
    }
  ];
}

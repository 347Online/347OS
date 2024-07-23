{util, ...}: {
  plugins.gitsigns = {
    enable = true;

    settings = {
      current_line_blame = true;
    };
  };

  keymaps = [
    (util.vimBind "n" "<leader>gp" ":Gitsigns preview_hunk<CR>")
  ];
}

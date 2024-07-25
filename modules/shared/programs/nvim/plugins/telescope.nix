{util, ...}: {
  plugins.telescope = {
    enable = true;

    settings = {
      pickers = {
        find_files = {
          hidden = true;
          file_ignore_patterns = ["^./.git/" "^node_modules/"];
        };
      };
    };
  };

  keymaps = [
    (util.vimBind "n" "<leader>f?" ":Telescope<CR>")
    (util.vimBind "n" "<leader>ff" ":Telescope find_files<CR>")
    (util.vimBind "n" "<leader>fg" ":Telescope live_grep<CR>")
    (util.vimBind "n" "<leader>fb" ":Telescope buffers<CR>")
    (util.vimBind "n" "<leader>fh" ":Telescope help_tags<CR>")
    (util.vimBind "n" "<leader>fc" ":Telescope current_buffer_fuzzy_find<CR>")
    (util.vimBind "n" "<leader>fr" ":Telescope registers<CR>")
  ];
}

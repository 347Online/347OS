{util, ...}: {
  keymaps = [
    (util.vimBind "n" "-" ":Oil<CR>")

    (util.vimBind "n" "<leader>gg" ":LazyGit<CR>")
    (util.vimBind "n" "<leader>gp" ":Gitsigns preview_hunk<CR>")

    (util.vimBind "n" "<leader>ll" ":Lspsaga hover_doc<CR>")
    (util.vimBind "n" "<leader>la" ":Lspsaga code_action<CR>")
    (util.vimBind "n" "<leader>lr" ":Lspsaga rename<CR>")
    (util.vimBind "n" "gd" ":Lspsaga goto_definition<CR>")
    (util.vimBind "n" "gt" ":Lspsaga goto_type_definition<CR>")
    (util.vimBind "n" "<leader>xr" ":Trouble lsp_references toggle<CR>")
    (util.vimBind "n" "<leader>cl" ":Trouble lsp toggle focus=false win.position=right<CR>")

    (util.vimBind "n" "<leader>xx" ":Trouble diagnostics toggle filter.buf=0<CR>")
    (util.vimBind "n" "<leader>xX" ":Trouble diagnostics toggle<CR>")
    (util.vimBind "n" "<leader>xL" ":Trouble loclist toggle<CR>")
    (util.vimBind "n" "<leader>xQ" ":Trouble qflist toggle<CR>")
    (util.vimBind "n" "<leader>cs" ":Trouble symbols toggle focus=false<CR>")
    (util.vimBind "n" "<leader>f?" ":Telescope<CR>")
    (util.vimBind "n" "<leader>ff" ":Telescope find_files<CR>")
    (util.vimBind "n" "<leader>fg" ":Telescope live_grep<CR>")
    (util.vimBind "n" "<leader>fb" ":Telescope buffers<CR>")
    (util.vimBind "n" "<leader>fh" ":Telescope help_tags<CR>")
    (util.vimBind "n" "<leader>fc" ":Telescope current_buffer_fuzzy_find<CR>")
    (util.vimBind "n" "<leader>fr" ":Telescope registers<CR>")
  ];

  plugins.telescope.settings.defaults.mappings = {
    n = {
      "<C-d>".__raw = ''
        require("telescope.actions").delete_buffer
      '';
    };
    i = {
      "<C-d>".__raw = ''
        require("telescope.actions").delete_buffer
      '';
    };
  };

  plugins.cmp.settings.mapping = {
    "<CR>" = "cmp.mapping.confirm({ select = true })";
    "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
    "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
  };
}

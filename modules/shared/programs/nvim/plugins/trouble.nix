{util, ...}: {
  plugins.trouble = {
    enable = true;
  };

  keymaps = [
    (util.vimBind "n" "<leader>xx" ":Trouble diagnostics toggle<CR>")
    (util.vimBind "n" "<leader>xX" ":Trouble diagnostics toggle filter.buf=0<CR>")
    (util.vimBind "n" "<leader>cs" ":Trouble symbols toggle focus=false<CR>")
    (util.vimBind "n" "<leader>cl" ":Trouble lsp toggle focus=false win.position=right<CR>")
    (util.vimBind "n" "<leader>xL" ":Trouble loclist toggle<CR>")
    (util.vimBind "n" "<leader>xQ" ":Trouble qflist toggle<CR>")
  ];
}

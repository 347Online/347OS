{util, ...}: {
  plugins.lspsaga = {
    enable = true;

    lightbulb.enable = false;
    rename = {
      autoSave = true;
      inSelect = false;
    };
    codeAction = {
      extendGitSigns = true;
    };
  };

  keymaps = [
    (util.vimBind "n" "<leader>l" ":Lspsaga hover_doc<CR>")
    (util.vimBind "n" "<leader>a" ":Lspsaga code_action<CR>")
    (util.vimBind "n" "<leader>r" ":Lspsaga rename<CR>")
    (util.vimBind "n" "gd" ":Lspsaga goto_definition<CR>")
    (util.vimBind "n" "gt" ":Lspsaga goto_type_definition<CR>")
  ];
}

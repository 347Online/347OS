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
    (util.vimBind "n" "<leader>ll" ":Lspsaga hover_doc<CR>")
    (util.vimBind "n" "<leader>la" ":Lspsaga code_action<CR>")
    (util.vimBind "n" "<leader>lr" ":Lspsaga rename<CR>")
    (util.vimBind "n" "gd" ":Lspsaga goto_definition<CR>")
    (util.vimBind "n" "gt" ":Lspsaga goto_type_definition<CR>")
  ];
}

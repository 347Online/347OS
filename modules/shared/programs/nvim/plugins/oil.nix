{util, ...}: {
  plugins.oil.settings = {
    keymaps = {
      "-" = false;
      "<BS>" = "actions.parent";
    };
  };

  keymaps = [
    (util.vim.bindSimple "n" "-" ":Oil<CR>")
  ];
}

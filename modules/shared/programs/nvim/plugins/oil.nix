{util, ...}: {
  plugins.oil = {
    enable = true;

    settings = {
      keymaps = {
        "-" = false;
        "<BS>" = "actions.parent";
      };
    };
  };

  keymaps = [
    (util.vimBind "n" "-" ":Oil<CR>")
  ];
}

{
  plugins.cmp = {
    enable = true;

    settings = {
      sources = [
        {name = "nvim_lsp";}
        {name = "otter";}
        {name = "path";}
        {name = "buffer";}
      ];

      autoEnableSources = true;

      mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };
    };
  };
}

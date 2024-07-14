{
  plugins.lspsaga = let
  in {
    enable = true;
    lightbulb.virtualText = false;
    rename = {
      autoSave = true;
      inSelect = false;
    };
    codeAction = {
      extendGitSigns = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>l";
      action = ":Lspsaga hover_doc<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>a";
      action = ":Lspsaga code_action<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>r";
      action = ":Lspsaga rename<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "gd";
      action = ":Lspsaga goto_definition<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "gt";
      action = ":Lspsaga goto_type_definition<CR>";
      options.silent = true;
    }
  ];
}

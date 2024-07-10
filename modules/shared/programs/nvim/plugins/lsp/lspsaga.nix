{
  plugins.lspsaga = let
    quitKeys = [
      "<Esc><Esc>"
      "q"
    ];
  in {
    enable = true;
    lightbulb.virtualText = false;
    finder.keys.quit = quitKeys;
    rename = {
      autoSave = true;
      inSelect = false;
      keys.quit = quitKeys;
    };
    outline.keys.quit = quitKeys;
    callhierarchy.keys.quit = quitKeys;
    definition.keys.quit = quitKeys;
    diagnostic.keys.quit = quitKeys;
    codeAction = {
      keys.quit = quitKeys;
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
      key = "<leader>gd";
      action = ":Lspsaga goto_definition<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>gt";
      action = ":Lspsaga goto_type_definition<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>xd";
      action = ":Lspsaga peek_definition<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>xt";
      action = ":Lspsaga peek_type_definition<CR>";
      options.silent = true;
    }
  ];
}

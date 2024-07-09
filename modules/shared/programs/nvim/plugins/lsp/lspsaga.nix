{
  plugins.lspsaga = {
    enable = true;
    lightbulb.enable = false;
    finder.keys.quit = "<Esc>";
    rename.keys.quit = "<Esc>";
    outline.keys.quit = "<Esc>";
    callhierarchy.keys.quit = "<Esc>";
    definition.keys.quit = "<Esc>";
    diagnostic.keys.quit = "<Esc>";
    codeAction = {
      keys.quit = "<Esc>";
      extendGitSigns = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>a";
      action = ":Lspsaga code_action<CR>";
      options.silent = true;
    }
  ];
}

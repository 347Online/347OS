{
  plugins.neo-tree = {
    filesystem = {
      filteredItems = {
        visible = true;
        hideDotfiles = false;
        hideGitignored = true;
        neverShow = [
          ".git"
          ".DS_Store"
        ];
      };

      useLibuvFileWatcher = true;
    };
    enableDiagnostics = true;
    enableGitStatus = true;
    enableModifiedMarkers = true;
    window = {
      width = 40;
      autoExpandWidth = false;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>N";
      action = ":Neotree action=focus reveal toggle left<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>n";
      action = ":Neotree action=focus reveal left<CR>";
      options.silent = true;
    }
  ];
}

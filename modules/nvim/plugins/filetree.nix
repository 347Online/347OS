{
  plugins.neo-tree = {
    enable = true;
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
    };

    enableDiagnostics = true;
    enableGitStatus = true;
    enableModifiedMarkers = true;
    window = {
      width = 35;
      autoExpandWidth = false;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>N";
      action = ":Neotree action=focus reveal toggle<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>n";
      action = ":Neotree action=focus reveal<CR>";
    }
  ];
}

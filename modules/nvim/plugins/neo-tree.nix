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
        ];
      };
    };

    enableDiagnostics = true;
    enableGitStatus = true;
    enableModifiedMarkers = true;
    enableRefreshOnWrite = true;
    closeIfLastWindow = true;
    window = {
      width = 30;
      autoExpandWidth = false;
    };
  };
}

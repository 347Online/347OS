{
  plugins.telescope = {
    enable = true;

    settings.defaults = {
      pickers = {
        find_files = {
          hidden = true;
          file_ignore_patterns = [
            "^./.git/"
            "^node_modules/"
          ];
        };
      };
    };
  };
}

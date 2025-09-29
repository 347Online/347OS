{
  programs.lazygit = {
    enable = true;

    settings = {
      git = {
        autoFetch = false;
        overrideGpg = true;
      };
      promptToReturnFromSubprocess = false;
      os = {
        editPreset = "nvim-remote";
        editInTerminal = true;
      };
    };
  };
}

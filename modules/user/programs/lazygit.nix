{
  programs.lazygit = {
    enable = true;

    settings = {
      git.autoFetch = false;
      promptToReturnFromSubprocess = false;
      os = {
        editPreset = "nvim-remote";
        editInTerminal = true;
      };
    };
  };
}

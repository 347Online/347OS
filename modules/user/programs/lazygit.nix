{
  programs.lazygit = {
    enable = true;

    settings = {
      promptToReturnFromSubprocess = false;
      os = {
        editPreset = "nvim-remote";
        editInTerminal = true;
      };
    };
  };
}

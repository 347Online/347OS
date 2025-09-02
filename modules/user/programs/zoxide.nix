{
  programs.zoxide = {
    enable = true;
    options = [
      "--cmd"
      "cd"
    ];
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}

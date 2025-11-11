{
  programs.mise = {
    enable = true;

    enableZshIntegration = true;
    enableBashIntegration = true;

    globalConfig = {
      tools = {
        node = [ "latest" ];
        python = [ "latest" ];
        go = [ "latest" ];
      };
      settings = {
        idiomatic_version_file_enable_tools = [ "node" ];
      };
    };
  };
}

{
  programs.git = {
    enable = true;
    delta.enable = true;
    ignores = [
      ".DS_Store"
    ];
    userName = "347Online | Katie Janzen";
    userEmail = "katiejanzen@347online.me";
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
  };
  # TODO: Find a way to selectively enable this only on Linux
  # programs.git-credential-oauth.enable = true;
}

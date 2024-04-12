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
      # TODO: Thiw might cause problems on linux
      credential.helper = "osxkeychain";
    };
  };
  # TODO: Find a better way to switch between these options depending on the system
  # programs.git-credential-oauth.enable = true;
}

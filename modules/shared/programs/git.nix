{
  lib,
  isDarwin,
  ...
}: {
  programs.git = {
    enable = true;
    delta.enable = true;
    ignores = [
      "Session.vim"
      ".DS_Store"
      ".mise.*.toml"
    ];
    userName = "347Online | Katie Janzen";
    userEmail = "katiejanzen@347online.me";
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.ff = "only";
    };
  };

  # TODO: Add caching or something, this was triggering CONSTANTLY
  # Better still, see if we can just let 1Password handle this
  programs.git-credential-oauth.enable = lib.mkIf (!isDarwin) true;
}

{
  pkgs,
  lib,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
in {
  programs.git = {
    enable = true;
    delta.enable = true;
    ignores = [
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
      credential.helper = lib.mkIf isDarwin "osxkeychain";
    };
  };

  # TODO: Add caching or something, this was triggering CONSTANTLY
  programs.git-credential-oauth.enable = lib.mkIf (!isDarwin) true;
}

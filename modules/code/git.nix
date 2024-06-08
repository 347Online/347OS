{
  config,
  lib,
  system,
  ...
}: let
  isDarwin = lib.hasSuffix "darwin" system;
in {
  options = {
    code.git.enable = lib.mkEnableOption "git setup";
  };

  config = lib.mkIf config.code.git.enable {
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
        pull.ff = "only";
      };
    };
    # TODO: Add caching, this was triggering CONSTANTLY
    programs.git-credential-oauth.enable = lib.mkIf (!isDarwin) true;
  };
}

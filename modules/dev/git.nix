{
  config,
  lib,
  system,
  util,
  ...
}: let
  mac = util.isMac system;
in {
  options = {
    enableGit = lib.mkEnableOption "git configuration module";
  };

  config = lib.mkIf config.enableGit {
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
        # TODO: There might be a better way to do this
        credential.helper =
          if mac
          then "osxkeychain"
          else null;
      };
    };
    programs.git-credential-oauth.enable = !mac;
  };
}

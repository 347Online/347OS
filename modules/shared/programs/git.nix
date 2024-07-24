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
    aliases = rec {
      br = "branch";
      c = "commit";
      co = "checkout";
      p = "push";
      pl = "pull";
      pr = "pull --rebase=interactive";
      pm = "pull --no-rebase";
      s = "status";
      st = s;
      statsu = s;
      last = "log -1 HEAD";
      prev = last;
    };
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.ff = "only";
      rerere.enabled = true;
    };
  };

  # TODO: Add caching or something, this was triggering CONSTANTLY
  # Better still, see if we can just let 1Password handle this
  programs.git-credential-oauth.enable = lib.mkIf (!isDarwin) true;
}

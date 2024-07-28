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
      pf = "push --force-with-lease";
      pl = "pull";
      pr = "pull --rebase=interactive";
      pm = "pull --no-rebase";
      s = "status";
      st = s;
      statsu = s;
      unstage = "restore --staged";
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
}

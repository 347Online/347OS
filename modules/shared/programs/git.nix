{
  programs.git = {
    enable = true;
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
      ri = "rebase -i";
      rc = "rebase --continue";
      ra = "rebase --abort";
      cp = "cherry-pick";
    };
    extraConfig = {
      core.editor = "nvim";
      core.pager = "LESS='FR --redraw-on-quit' delta";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.ff = "only";
      rerere.enabled = true;
    };
  };
}

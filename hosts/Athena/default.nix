{
  self,
  pkgs-custom,
  username,
  ...
}:
{
  stylix.image = "${self}/wallpapers/sunset.jpg";

  homebrew = {
    casks = [
      "krita"
      # TODO: Messaging module mirroring NixOS
      "element"
      "discord"
    ];
  };

  home-manager.users.${username} = {
    user = {
      personal.enable = true;
      gaming.enable = true;
    };

    programs.ssh.matchBlocks = {
      Astrid = {
        hostname = "192.168.4.110";
        user = username;
        forwardAgent = true;
      };
      Aspen = {
        hostname = "fatgirl.cloud";
        user = username;
        port = 5892;
        forwardAgent = true;
      };
    };
  };

  darwin.dock.apps = [
    "/Applications/Overcast.app"
    "/System/Applications/Messages.app"
    "/Applications/Thunderbird.app"
    # TODO: Use from official nixpkgs if/when PR lands
    # https://github.com/NixOS/nixpkgs/pull/376817
    # TODO: Broken
    # "${pkgs-custom.teamtalk5}/Applications/TeamTalk5.app"
  ];
}

{
  self,
  username,
  ...
}:
{
  stylix.image = "${self}/wallpapers/sunset.jpg";

  homebrew = {
    taps = [ "qmk/qmk" ];
    brews = [ "qmk/qmk/qmk" ];
    casks = [
      "krita"
      "element"
    ];
  };

  home-manager.users.${username} = {
    shared = {
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
    "/System/Applications/Mail.app"
    "/Applications/TeamTalk5.app"
  ];
}

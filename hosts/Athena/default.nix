{
  self,
  username,
  ...
}: {
  stylix.image = "${self}/wallpapers/sunset.jpg";

  homebrew = {
    taps = ["qmk/qmk"];
    brews = ["qmk/qmk/qmk"];
  };

  home-manager.users.${username} = {
    shared.gaming.enable = true;

    programs.ssh.matchBlocks = {
      Aspen = {
        hostname = "fatgirl.cloud";
        user = username;
        port = 5892;
      };
    };
  };

  darwin.dock.apps = [
    "/Applications/Overcast.app"
    "/System/Applications/Messages.app"
    "/Applications/Telegram.app"
    "/System/Applications/Mail.app"
    "/Applications/TeamTalk5.app"
  ];
}

{
  username,
  ...
}:
{
  darwin = {
    personal.enable = true;
    gaming.enable = true;
    dock.apps = [
      "/Applications/Overcast.app"
      "/System/Applications/Messages.app"
    ];
  };

  homebrew = {
    casks = [
      # TODO: Aren't these open source? Can't we enable these with programs.*.enable on mac and linux, if it's a personal machine?
      "inkscape"
      "krita"
      # TODO: Messaging module mirroring NixOS
      "element"
      "discord"
      "transmission"
    ];
  };

  home-manager.users.${username} = {
    programs.ssh = {
      enableDefaultConfig = false;

      matchBlocks = {
        "*" = { };
        Aspen = {
          hostname = "192.168.4.55";
          user = username;
          forwardAgent = true;
        };
        Astrid = {
          hostname = "192.168.4.119";
          user = username;
          forwardAgent = true;
        };
      };
    };
  };

}

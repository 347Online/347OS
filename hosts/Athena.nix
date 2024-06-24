{username, ...}: {
  darwin.dock.apps = [
    "/Applications/Overcast.app"
    "/System/Applications/Messages.app"
    "/Applications/Telegram.app"
    "/System/Applications/Mail.app"
    "/Applications/TeamTalk5.app"
  ];

  home-manager.users.${username} = {
    lang.rust.toolchain = "beta";
  };
}

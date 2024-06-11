{username, ...}: {
  darwin.dock.apps = [
    "/Applications/Overcast.app"
    "/System/Applications/Mail.app"
  ];

  home-manager.users.${username} = {
    lang.rust.toolchain = "beta";
    gaming.enable = true;
  };
}

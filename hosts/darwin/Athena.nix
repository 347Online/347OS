{username, ...}: {
  darwin.dock.apps = [
    "/Applications/Overcast.app"
  ];
  home-manager.users.${username} = {
    lang.rust.toolchain = "beta";
    gaming.enable = true;
  };
}

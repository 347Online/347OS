{username, ...}: {
  darwin.dockApps = [
    "/Applications/Overcast.app"
  ];
  home-manager.users.${username} = {
    lang.rust.toolchain = "beta";
    gaming.enable = true;
  };
}

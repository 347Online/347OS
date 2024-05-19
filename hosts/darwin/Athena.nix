{username, ...}: {
  home-manager.users.${username} = {
    lang.rust.toolchain = "beta";
    gaming.enable = true;
  };
}

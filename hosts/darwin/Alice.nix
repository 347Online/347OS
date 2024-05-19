{username, ...}: {
  home-manager.users.${username} = {
    lang.java.enable = true;
  };
}

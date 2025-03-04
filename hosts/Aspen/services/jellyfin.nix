{
  users.users.jellyfin.extraGroups = [ "media" ]; # Is this needed?

  services.jellyfin = {
    enable = true;
  };
}

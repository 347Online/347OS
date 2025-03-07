{
  users = {
    groups = {
      media = { };
      jellyseerr = { };
    };

    users = {
      bazarr.extraGroups = [ "media" ];
      jellyfin.extraGroups = [ "media" ];
      jellyseerr = {
        isNormalUser = true;
        group = "jellyseerr";
        extraGroups = [ "media" ];
      };
      lidarr.extraGroups = [ "media" ];
      radarr.extraGroups = [ "media" ];
      sonarr.extraGroups = [ "media" ];
    };
  };

  services = {
    bazarr.enable = true;
    jellyfin.enable = true;
    jellyseerr.enable = true;
    lidarr.enable = true;
    radarr.enable = true;
    sonarr.enable = true;
  };
}

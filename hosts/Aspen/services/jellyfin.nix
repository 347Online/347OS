{
  users = {
    groups = {
      media = { };
    };

    users = {
      bazarr.extraGroups = [ "media" ];
      jellyfin.extraGroups = [ "media" ];
      lidarr.extraGroups = [ "media" ];
      radarr.extraGroups = [ "media" ];
      sonarr.extraGroups = [ "media" ];
    };
  };

  services = {
    bazarr.enable = true;
    jellyfin.enable = true;
    ombi = {
      enable = true;
      port = 16329;
    };
    lidarr.enable = true;
    radarr.enable = true;
    sonarr.enable = true;
    prowlarr.enable = true;
  };
}

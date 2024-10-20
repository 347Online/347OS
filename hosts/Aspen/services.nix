{
  services.plex.enable = true;
  services.transmission = {
    enable = true;
    openRPCPort = true;
    settings = {
      rpc-whitelist = "*";
    };
  };
}

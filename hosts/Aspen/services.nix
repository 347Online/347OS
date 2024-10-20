{
  services.plex.enable = true;
  services.transmission = {
    enable = true;
    openRPCPort = true;
    settings = {
      rpc-whitelist-enabled = false;
      # rpc-whitelist = "127.0.0.1,192.168.*.*";
    };
  };
}

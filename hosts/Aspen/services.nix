{
  services.plex.enable = true;
  services.transmission = {
    enable = true;
    openRPCPort = true;
    settings = {
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "127.0.0.1,192.168.4.25";
    };
  };
}

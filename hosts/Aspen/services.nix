{
  services.plex = {
    enable = true;
    openFirewall = true;
  };
  services.transmission = {
    enable = true;
    openRPCPort = true;
    settings = {
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist-enabled = false;
    };
  };
}

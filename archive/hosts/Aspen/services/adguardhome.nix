{
  services.adguardhome = {
    enable = true;
    mutableSettings = false;
    port = 41419;

    settings = {
      tls = {
        enabled = false;
        allow_unencrypted_doh = true;
      };
      dns = {
        upstream_dns = [ "https://dns10.quad9.net/dns-query" ];
        bootstrap_dns = [
          "9.9.9.10"
          "149.112.112.10"
          "2620:fe::10"
          "2620:fe::fe:10"
        ];
        trusted_proxies = [
          # Astrid
          "192.168.4.110"
        ];
      };
    };
  };
}

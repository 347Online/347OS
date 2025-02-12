{ homeDirectory, ... }:
{
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "192.168.2.1/32" ];
      dns = [ "192.168.2.1" ];
      privateKeyFile = "${homeDirectory}/.local/.secrets/wg/key";

      peers = [
        {
          publicKey = "FZhZ/zhB8X34nCsYFjNDuSGqrb+OUzG7/HPyZSgsiB8=";
          allowedIPs = [
            "192.168.2.1/32"
            "192.168.2.2/32"
            "0.0.0.0/0"
          ];
          endpoint = "wlg.duckdns.org:51820";
        }
      ];
    };
  };
}

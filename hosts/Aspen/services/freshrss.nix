{ config, username, ... }:
{
  sops.secrets.freshrss-passwd = {
    sopsFile = ../.secrets.yaml;
    mode = "0666";
  };

  services.freshrss = {
    enable = true;

    baseUrl = "http://192.168.4.55/freshrss";
    defaultUser = username;
    passwordFile = config.sops.secrets.freshrss-passwd.path;
  };
}

{ config, ... }:
{
  sops.secrets.adguard-home-passwd-file.mode = "0666";

  security.acme = {
    certs = {
      "fatgirl.cloud".extraDomainNames = [ "www.fatgirl.cloud" ];
      "jellyfin.fatgirl.cloud".extraDomainNames = [ "plex.fatgirl.cloud" ];
    };
    acceptTerms = true;
    defaults = {
      webroot = "/var/www/fatgirl";
      email = "katiejanzen@347online.me";
    };
  };

  users.users = {
    nginx.extraGroups = [ "acme" ];
    acme.extraGroups = [ "nginx" ];
    katie.extraGroups = [ "nginx" ];
  };

  services.nginx = {
    enable = true;

    enableReload = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    appendHttpConfig =
      # nginx
      ''
        map $scheme $hsts_header {
            https   "max-age=31536000; includeSubdomains; preload";
        }

        add_header Strict-Transport-Security $hsts_header;
        add_header X-Frame-Options DENY;
        add_header X-Content-Type-Options nosniff;
        add_header Referrer-Policy 'same-origin';
        add_header Permissions-Policy "geolocation=(), microphone=()";
        # add_header Content-Security-Policy "script-src 'self'; object-src 'none'; base-uri 'none';" always;

        proxy_cookie_path / "/; secure; HttpOnly; SameSite=strict";
      '';

    virtualHosts =
      let
        base = locations: {
          inherit locations;

          forceSSL = true;
          enableACME = true;
        };
        proxy =
          {
            ip ? "127.0.0.1",
            port ? null,
            urlpath ? null,
          }:
          base {
            "/".proxyPass = "http://${ip}${if port != null then ":${toString port}" else ""}${
              if urlpath != null then "/${urlpath}" else ""
            }";
          };
      in
      {
        "fatgirl.cloud" = {
          default = true;
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            root = "/var/www/fatgirl";
            extraConfig =
              # nginx
              ''
                default_type text/html;
              '';
          };
        };
        "www.fatgirl.cloud" = {
          useACMEHost = "fatgirl.cloud";
          forceSSL = true;
          globalRedirect = "fatgirl.cloud";
        };
        "social.fatgirl.cloud" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            recommendedProxySettings = true;
            proxyWebsockets = true;
            proxyPass = "http://192.168.4.55:3475";
          };
        };
        "dns.fatgirl.cloud" =
          proxy {
            ip = "192.168.4.55";
            port = 41419;
          }
          // {
            basicAuthFile = config.sops.secrets.adguard-home-passwd-file.path;
            extraConfig =
              # nginx
              ''
                proxy_set_header Host $host;
              '';
          };
        "request.fatgirl.cloud" = proxy {
          ip = "192.168.4.55";
          port = 16329;
        };
        "watch.fatgirl.cloud" = proxy {
          ip = "192.168.4.55";
          port = 2294;
        };
        "sync.fatgirl.cloud" = proxy {
          ip = "192.168.4.55";
          port = 8384;
        };
        "firefox.fatgirl.cloud" = proxy {
          ip = "192.168.4.55";
          port = 5000;
        };
        "rss.fatgirl.cloud" = proxy {
          ip = "192.168.4.55";
        };
        "transmission.fatgirl.cloud" = proxy {
          ip = "192.168.4.55";
          port = 9091;
        };
        "jellyfin.fatgirl.cloud" = proxy {
          ip = "192.168.4.55";
          port = "8096";
        };
        "plex.fatgirl.cloud" = {
          useACMEHost = "jellyfin.fatgirl.cloud";
          forceSSL = true;
          globalRedirect = "jellyfin.fatgirl.cloud";
        };
      };
  };
}

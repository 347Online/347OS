{
  self,
  pkgs,
  homeDirectory,
  ...
}:
{
  sops = {
    defaultSopsFile = self + builtins.toPath "/secrets.yaml";
    defaultSopsFormat = "yaml";

    age.keyFile =
      let
        osDir = if pkgs.stdenv.isDarwin then "Library/Application Support" else ".config";
      in
      "${homeDirectory}/${osDir}/sops/age/keys.txt";

    secrets =
      let
        basePath = "${homeDirectory}/.secrets";
      in
      {
        "personal-info-expansions.yml".path =
          "${homeDirectory}/.config/espanso/match/personal-info-expansions.yml";

        syncthing-gui-passwd.path = "${basePath}/syncthing-gui-passwd.txt";
      };
  };
}

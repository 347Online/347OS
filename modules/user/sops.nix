{
  self,
  pkgs,
  homeDirectory,
  ...
}:
{
  sops = {
    defaultSopsFile = builtins.toPath "${self}/.secrets.yaml";
    defaultSopsFormat = "yaml";

    age.keyFile =
      let
        osDir = if pkgs.stdenv.isDarwin then "Library/Application Support" else ".config";
      in
      "${homeDirectory}/${osDir}/sops/age/keys.txt";

    secrets = {
      syncthing-gui-passwd = { };

      "personal-info-expansions.yml".path =
        "${homeDirectory}/.config/espanso/match/personal-info-expansions.yml";
    };
  };
}

{
  self,
  pkgs,
  homeDirectory,
  ...
}:
{
  sops = {
    defaultSopsFile = builtins.toPath "${self}/.secrets.yaml";

    age.keyFile =
      let
        osDir = if pkgs.stdenv.isDarwin then "Library/Application Support" else ".config";
      in
      "${homeDirectory}/${osDir}/sops/age/keys.txt";

    secrets = {
      syncthing-gui-passwd = { };
    };
  };
}

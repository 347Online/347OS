{
  pkgs,
  homeDirectory,
  ...
}:
{
  sops = {
    defaultSopsFile = ./.user-secrets.yaml;

    age.keyFile =
      if pkgs.stdenv.isDarwin then
        "${homeDirectory}/Library/Application Support/sops/age/keys.txt"
      else
        "${homeDirectory}/.config/sops/age/keys.txt";

    secrets = {
      syncthing-gui-passwd = { };
    };
  };
}

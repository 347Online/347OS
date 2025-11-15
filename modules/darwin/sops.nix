{ homeDirectory, ... }:
{
  sops.age.keyFile = "${homeDirectory}/Library/Application Support/sops/age/keys.txt";
}

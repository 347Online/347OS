{ homeDirectory, ... }:
{
  sops.age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt";
}

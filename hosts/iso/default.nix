{
  self,
  system,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  stylix.image = "${self}/wallpapers/desert.jpg";

  nixpkgs.hostPlatform = system;
}

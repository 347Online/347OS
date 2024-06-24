{
  self,
  inputs,
  system,
  pkgs,
  ...
}: let
  
in {
  programs.nixvim = {
    enable = true;
    # package = nvim;

    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
}

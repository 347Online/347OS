{
  flake.darwinModules.nix =
    {
      inputs,
      config,
      lib,
      username,
      experimental-features,
      overlays,
      system,
      ...
    }:
    {
      nix = {
        gc = {
          automatic = true;
          options = "--delete-older-than 30d";
        };
        settings = {
          inherit experimental-features;
          substituters = [ "https://nix-community.cachix.org" ];
          trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
          trusted-users = [ username ];
          # download-buffer-size = 524312500;
        };
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
      };

      nixpkgs = {
        inherit overlays;
        hostPlatform = system;
        config.allowUnfreePredicate =
          pkg: builtins.elem (lib.getName pkg) (config.darwin.unfree-allowed ++ [ "ookla-speedtest" ]);
      };
    };
}

{
  description = "Dotfiles";

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (_: prev: {
          wallpapers = inputs.wallpapers.packages.${system}.default;
        })
      ];
    };
  in {
    packages.${system} = {
      default = pkgs.callPackage ./packages/dotfiles.nix {inherit self;};

      eww-scripts = pkgs.symlinkJoin {
        name = "EWW scripts";
        paths = let
          data = builtins.readFile ./config/eww/data/leftdock.json;
          leftdockpopulate = pkgs.callPackage ./scripts/eww/leftdockpopulate.nix {inherit data;};
        in [
          leftdockpopulate
          (pkgs.callPackage ./scripts/eww/ewwinit.nix {inherit leftdockpopulate;})
        ];
      };
    };

    nixosModules.default = import ./modules/rofi.nix {inherit inputs pkgs;};
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    wallpapers.url = "github:anhphan156/Wallpapers";
  };
}

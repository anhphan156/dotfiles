{
  description = "Dotfiles";

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: let
    supportedSystem = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystem;
  in {
    packages = forAllSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (_: prev: {
            wallpapers = inputs.wallpapers.packages.${system}.default;
          })
        ];
      };
    in {
      default = pkgs.callPackage ./packages/dotfiles.nix {src = self;};

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
    });

    nixosModules.default = {pkgs, ...}: {
      imports = [
        (nixpkgs.lib.modules.importApply ./modules/rofi.nix {
          inherit inputs;
          pkgs' = pkgs.extend (_: prev: {
            wallpapers = inputs.wallpapers.packages.${prev.system}.default;
          });
        })
      ];
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    wallpapers.url = "github:anhphan156/Wallpapers";
  };
}

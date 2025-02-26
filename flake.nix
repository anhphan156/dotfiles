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
          inputs.wallpapers.overlays.default
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

    nixosModules.default = nixpkgs.lib.modules.importApply ./modules/rofi.nix inputs;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    wallpapers.url = "github:anhphan156/Wallpapers";
  };
}

{
  description = "Dotfiles";

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: {
    overlays.default = _: prev': let
      prev = prev'.extend <| prev'.lib.composeManyExtensions [
        inputs.wallpapers.overlays.default
        (_: prev: {
          leftdockpopulate = prev.callPackage ./scripts/eww/leftdockpopulate.nix {
            data = builtins.readFile ./config/eww/data/leftdock.json;
          };
        })
      ];
    in {
      default = prev.callPackage ./packages/dotfiles.nix {src = self;};
      eww-scripts = prev.symlinkJoin {
        name = "EWW scripts";
        paths = [
          prev.leftdockpopulate
          (prev.callPackage ./scripts/eww/ewwinit.nix {})
        ];
      };
    };

    nixosModules.default = nixpkgs.lib.modules.importApply ./modules/rofi.nix inputs;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    wallpapers.url = "github:anhphan156/Wallpapers";
  };
}

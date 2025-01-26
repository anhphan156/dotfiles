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
      default = pkgs.callPackage ./derivations/dotfiles.nix {inherit self;};

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

    nixosModules.default = {lib, ...}: {
      options.dotfiles.rofi = {
        default = lib.mkOption {
          readOnly = true;
          type = lib.types.path;
          default = "${self.packages.${system}.default}/share/rofi/config.rasi";
        };
        transparent = lib.mkOption {
          readOnly = true;
          type = lib.types.path;
          default = "${self.packages.${system}.default}/share/rofi/transparent.rasi";
        };
        oneColumn = lib.mkOption {
          readOnly = true;
          type = lib.types.path;
          default = "${self.packages.${system}.default}/share/rofi/config1Col.rasi";
        };
        prompt = lib.mkOption {
          readOnly = true;
          type = lib.types.path;
          default = "${self.packages.${system}.default}/share/rofi/configPromptOnly.rasi";
        };
        image = lib.mkOption {
          readOnly = true;
          type = lib.types.path;
          default = "${self.packages.${system}.default}/share/rofi/imgprev.rasi";
        };
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    wallpapers.url = "github:anhphan156/Wallpapers";
  };
}

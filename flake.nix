{
  description = "Dotfiles";

  outputs = {
    nixpkgs,
    wallpapers,
    self,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    src = ./.;
  in {
    packages.${system} = {
      eww-scripts = pkgs.symlinkJoin {
        name = "EWW scripts";
        paths = let
          data = builtins.readFile (src + /config/eww/data/leftdock.json);
          leftdockpopulate = pkgs.callPackage ./scripts/eww/leftdockpopulate.nix {inherit data;};
        in [
          leftdockpopulate
          (pkgs.callPackage ./scripts/eww/ewwinit.nix {inherit leftdockpopulate;})
        ];
      };

      default = pkgs.stdenv.mkDerivation {
        pname = "dotfiles";
        version = "1.0.0";
        inherit src;

        installPhase = ''
          mkdir -p $out/share
          cp -r --no-preserve=mode,ownership $src/config/* $out/share
          mkdir -p $out/share/eww/variables
          echo '(defvar icon_base_path "${wallpapers.packages.${system}.default}/icons")' > $out/share/eww/variables/iconspath.yuck
        '';
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

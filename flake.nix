{
  description = "Dotfiles";

  outputs = {
    nixpkgs,
    wallpapers,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    src = ./.;
  in {
    packages.${system} = {
      eww-scripts = pkgs.stdenv.mkDerivation {
        pname = "EWW scripts";
        version = "1.0.0";
        src = ./scripts/eww;

        installPhase = let
          inherit (pkgs) callPackage;
          leftdockpopulate = callPackage ./scripts/eww/leftdockpopulate.nix {inherit src;};
        in ''
          mkdir -p $out/bin
          cp ${leftdockpopulate} $out/bin/leftdockpopulate
          cp ${callPackage ./scripts/eww/ewwinit.nix {inherit leftdockpopulate;}} $out/bin/ewwinit
        '';
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
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    wallpapers.url = "github:anhphan156/Wallpapers";
  };
}

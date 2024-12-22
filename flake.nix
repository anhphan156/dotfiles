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
          # eww
          mkdir -p $out/share/eww
          cp -r $src/config/eww/* $out/share/eww
          mkdir -p $out/share/eww/variables
          echo '(defvar icon_base_path "${wallpapers.packages.${system}.default}/icons")' > $out/share/eww/variables/iconspath.yuck

          # picom
          mkdir -p $out/share/picom
          cp -r $src/config/picom/*.glsl $out/share/picom

          # rofi
          mkdir -p $out/share/rofi
          cp -r $src/config/rofi/* $out/share/rofi

          # waybar
          mkdir -p $out/share/waybar
          cp -r $src/config/waybar/* $out/share/waybar

          # nvim
          mkdir -p $out/share/nvim
          cp -r $src/config/nvim/* $out/share/nvim

          # xmonad
          mkdir -p $out/share/xmonad
          cp -r $src/config/xmonad/* $out/share/xmonad

          # awesome
          mkdir -p $out/share/awesome
          cp -r $src/config/awesome/* $out/share/awesome
        '';
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    wallpapers.url = "github:anhphan156/Wallpapers";
  };
}

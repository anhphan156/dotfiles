{
  description = "Dotfiles";

  outputs = {
    nixpkgs,
    wallpapers,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    leftdockscript = pkgs.callPackage ./scripts/leftdockcheck.nix {};
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      pname = "dotfiles";
      version = "1.0.0";
      src = ./.;

      installPhase = ''
        mkdir -p $out/bin
        cp ${leftdockscript} $out/bin/leftdockcheck

        # eww
        mkdir -p $out/share/eww
        cp -r $src/config/eww/* $out/share/eww
        mkdir -p $out/share/eww/variables
        echo '(defvar icon_base_path "${wallpapers.packages.${system}.default}/icons")' > $out/share/eww/variables/iconspath.yuck

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

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    wallpapers.url = "github:anhphan156/Wallpapers";
  };
}

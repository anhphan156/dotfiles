{
  stdenvNoCC,
  wallpapers,
  windowWidth ? "100%",
  src,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "dotfiles";
  version = "1.0.0";
  inherit src;

  installPhase = ''
    mkdir -p $out/share
    cp -r ./config/* $out/share

    injected=$out/share/eww/variables/injected.yuck
    sed -i 's|<PATH>|${wallpapers + "/icons"}|g' $injected
    sed -i 's|<TOP_BAR_WIDTH>|${windowWidth}|g' $injected
  '';
}

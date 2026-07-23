{stdenvNoCC, ...}:
stdenvNoCC.mkDerivation {
  name = "Wallpapers";
  src = ../misc/wallpapers;
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}

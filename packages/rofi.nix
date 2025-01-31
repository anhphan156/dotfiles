{
  stdenvNoCC,
  imagemagick,
  src,
  defaultBackground,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "rofi-config";
  inherit src;

  nativeBuildInputs = [imagemagick];

  installPhase = ''
    install -dm755 $out
    cp -r ./config/rofi/* $out

    magick ${defaultBackground} -resize 960x $out/bg.jpg
  '';
}

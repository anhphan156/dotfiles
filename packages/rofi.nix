{
  stdenvNoCC,
  imagemagick_light,
  self,
  defaultBackground,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "rofi-config";
  src = self;

  nativeBuildInputs = [imagemagick_light];

  installPhase = ''
    install -dm755 $out
    cp -r ./config/rofi/* $out

    magick ${defaultBackground} -resize 960x $out/bg.jpg
  '';
}

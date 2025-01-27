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

  patchPhase = ''
    magick ${defaultBackground} -resize 960x ./config/rofi/bg.jpg
  '';

  installPhase = ''
    install -dm755 $out
    cp -r ./config/rofi/* $out
  '';
}

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
    mkdir -p $out/share
    cp -r --no-preserve=mode,ownership ./config/rofi $out/share
  '';
}

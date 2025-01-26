{
  stdenv,
  imagemagick_light,
  wallpapers,
  self,
  rofiBg ? (wallpapers + "/single/firefly0.jpg"),
  ...
}:
stdenv.mkDerivation {
  pname = "dotfiles";
  version = "1.0.0";
  src = self;

  nativeBuildInputs = [imagemagick_light];

  patchPhase = ''
    magick ${rofiBg} -resize 960x ./config/rofi/bg.jpg
    sed -i 's|<PATH>|${wallpapers + "/icons"}|g' ./config/eww/variables/iconspath.yuck
  '';

  installPhase = ''
    mkdir -p $out/share
    cp -r --no-preserve=mode,ownership ./config/* $out/share
  '';
}

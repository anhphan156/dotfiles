{
  stdenvNoCC,
  imagemagick_light,
  src,
  backgrounds,
  lib,
  ...
}: let
  uniqueBackground = lib.foldl (acc: x:
    if lib.elem x acc
    then acc
    else acc ++ x) []
  backgrounds;
in
  stdenvNoCC.mkDerivation {
    name = "rofi-config";
    inherit src;

    nativeBuildInputs = [imagemagick_light];

    installPhase =
      ''
        install -dm755 $out
        cp -r ./config/rofi/* $out

        touch $out/bg.rasi
      ''
      + lib.concatMapStringsSep
      "\n"
      (background: "magick ${background.bgPath} -resize 960x ./config/rofi/${background.bgName}.jpg")
      uniqueBackground;
  }

dotfilesFlake: {
  lib,
  config,
  ...
}: let
  rofiConfig = dotfilesFlake.pkgs.callPackage ../packages/rofi.nix {
    src = dotfilesFlake.inputs.self;
    defaultBackground = config.dotfiles.rofi.background;
  };

  genOption = configFile:
    lib.mkOption {
      readOnly = true;
      type = lib.types.path;
      default = rofiConfig + configFile;
    };
in {
  options.dotfiles.rofi = {
    config = lib.mkOption {
      readOnly = true;
      type = lib.types.package;
      default = rofiConfig;
    };

    background = lib.mkOption {
      type = lib.types.path;
      default = "${dotfilesFlake.pkgs.wallpapers}/single/firefly0.jpg";
    };

    default = genOption /config.rasi;
    transparent = genOption /transparent.rasi;
    oneColumn = genOption /config1Col.rasi;
    prompt = genOption /configPromptOnly.rasi;
    image = genOption /imgprev.rasi;
  };
}

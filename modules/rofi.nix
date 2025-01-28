{
  inputs,
  pkgs,
}: {
  lib,
  config,
  ...
}: let
  inherit (builtins) toString;
  inherit (lib.attrsets) mapAttrsToList;

  rofiFiles = pkgs.callPackage ../packages/rofi.nix {
    src = inputs.self;
    backgrounds = config.dotfiles.rofi
      |> mapAttrsToList (key: value: {bgPath = value.background; bgName = key;})
      |> lib.groupBy (x: toString x.bgPath)
      |> mapAttrsToList (_: v: lib.head v);
  };

  genOption = configPath: backgroundPath: {
    path = lib.mkOption {
      readOnly = true;
      type = lib.types.path;
      default = rofiFiles + configPath;
    };
    
    background = lib.mkOption {
      type = lib.types.path;
      default = pkgs.wallpapers + backgroundPath;
    };
  };
in {
  options.dotfiles.rofi = {
    default = genOption /config.rasi /single/firefly0.jpg;
    style1 = genOption /style1.rasi /single/archeron0.jpg;
    image = genOption /imgprev.rasi /single/firefly0.jpg;
    transparent = genOption /transparent.rasi /single/firefly0.jpg;
    oneColumn = genOption /config1Col.rasi /single/firefly0.jpg;
    prompt = genOption /configPromptOnly.rasi /single/firefly0.jpg;
  };
}

{
  inputs,
  pkgs,
}: {
  lib,
  config,
  ...
}: {
  options.dotfiles.rofi = {
    config = lib.mkOption {
      readOnly = true;
      type = lib.types.package;
      default = pkgs.callPackage ../packages/rofi.nix {
        inherit (inputs) self;
        defaultBackground = config.dotfiles.rofi.default.background;
      };
    };

    default = {
      path = lib.mkOption {
        readOnly = true;
        type = lib.types.path;
        default = "${config.dotfiles.rofi.config}/share/rofi/config.rasi";
      };
      background = lib.mkOption {
        type = lib.types.path;
        default = "${pkgs.wallpapers}/single/firefly0.jpg";
      };
    };
    transparent = lib.mkOption {
      readOnly = true;
      type = lib.types.path;
      default = "${config.dotfiles.rofi.config}/share/rofi/transparent.rasi";
    };
    oneColumn = lib.mkOption {
      readOnly = true;
      type = lib.types.path;
      default = "${config.dotfiles.rofi.config}/share/rofi/config1Col.rasi";
    };
    prompt = lib.mkOption {
      readOnly = true;
      type = lib.types.path;
      default = "${config.dotfiles.rofi.config}/share/rofi/configPromptOnly.rasi";
    };
    image = lib.mkOption {
      readOnly = true;
      type = lib.types.path;
      default = "${config.dotfiles.rofi.config}/share/rofi/imgprev.rasi";
    };
  };
}

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
        default = "${config.dotfiles.rofi.config}/config.rasi";
      };
      background = lib.mkOption {
        type = lib.types.path;
        default = "${pkgs.wallpapers}/single/firefly0.jpg";
      };
    };
    transparent = lib.mkOption {
      readOnly = true;
      type = lib.types.path;
      default = "${config.dotfiles.rofi.config}/transparent.rasi";
    };
    oneColumn = lib.mkOption {
      readOnly = true;
      type = lib.types.path;
      default = "${config.dotfiles.rofi.config}/config1Col.rasi";
    };
    prompt = lib.mkOption {
      readOnly = true;
      type = lib.types.path;
      default = "${config.dotfiles.rofi.config}/configPromptOnly.rasi";
    };
    image = lib.mkOption {
      readOnly = true;
      type = lib.types.path;
      default = "${config.dotfiles.rofi.config}/imgprev.rasi";
    };
  };
}

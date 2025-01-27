{
  lib,
  inputs,
  pkgs,
  ...
}: {
  options.dotfiles.rofi = {
    default = lib.mkOption {
      readOnly = true;
      type = lib.types.path;
      default = "${inputs.self.packages.${pkgs.system}.default}/share/rofi/config.rasi";
    };
    transparent = lib.mkOption {
      readOnly = true;
      type = lib.types.path;
      default = "${inputs.self.packages.${pkgs.system}.default}/share/rofi/transparent.rasi";
    };
    oneColumn = lib.mkOption {
      readOnly = true;
      type = lib.types.path;
      default = "${inputs.self.packages.${pkgs.system}.default}/share/rofi/config1Col.rasi";
    };
    prompt = lib.mkOption {
      readOnly = true;
      type = lib.types.path;
      default = "${inputs.self.packages.${pkgs.system}.default}/share/rofi/configPromptOnly.rasi";
    };
    image = lib.mkOption {
      readOnly = true;
      type = lib.types.path;
      default = "${inputs.self.packages.${pkgs.system}.default}/share/rofi/imgprev.rasi";
    };
  };
}

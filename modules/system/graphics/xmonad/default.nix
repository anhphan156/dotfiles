{
  config,
  lib,
  user,
  pkgs,
  ...
}: let
  cfg = config.cyanea.graphical;
  xmonad_path = "${config.cyanea.user.dotfilesPath}/config/xmonad";
in {
  options.cyanea.graphical.xmonad.enable = lib.mkEnableOption "Enable Xmonad";

  config = lib.mkIf (cfg.gui.enable && cfg.xmonad.enable) {
    cyanea.graphical.xsv = lib.enabled;
    cyanea.desktopApp.rofi = lib.enabled;
    cyanea.graphical.picom = lib.enabled;

    services.xserver.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      #config = user.rootPath + /config/xmonad/xmonad.hs;
    };
    home-manager.users."${user.name}" = {config, ...}: {
      xdg.configFile."xmonad/".source = config.lib.file.mkOutOfStoreSymlink xmonad_path;
    };
  };
}

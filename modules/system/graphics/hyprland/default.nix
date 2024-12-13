{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.cyanea.graphical;

  swww_scripts = pkgs.callPackage (lib.user.path.root + /packages/user_scripts/swww_scripts.nix) {
    inherit (config.cyanea) wallpapers;
    inherit (cfg.hyprland.monitor) monitorList;
  };
in {
  options = {
    cyanea.graphical.hyprland = {
      enable = lib.mkEnableOption "Enable hyprland";

      monitor = let
        inherit (lib) mkOption;
        inherit (lib.types) listOf str int;
      in {
        monitorList = mkOption {
          default = [""];
          type = listOf str;
          description = "List of monitors";
        };
        resolutionList = mkOption {
          default = ["preferred,auto,1"];
          type = listOf str;
          description = "List of resolution";
        };
        workspaceList = mkOption {
          default = [[1 2 3] [4 5 6]];
          type = listOf <| listOf int;
          description = "List of workspace";
        };
      };
    };
  };

  config = lib.mkIf (cfg.hyprland.enable && cfg.gui.enable) {
    cyanea = {
      desktopApp.rofi = lib.enabled;
      graphical = {
        eww = lib.enabled;
        mako = lib.enabled;
        hyprland.pyprland = lib.enabled;
      };
    };

    environment.systemPackages = with pkgs; [
      polkit
      xdg-desktop-portal-hyprland
      xwayland
      libnotify
      pyprland
      grim
      slurp
      wl-clipboard
      cliphist
      wtype
      wireplumber # streaming stuff
      swww
      swww_scripts
    ];

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };

    home-manager.users."${lib.user.name}" = {
      wayland.windowManager.hyprland = let

        inherit (cfg.hyprland.monitor) monitorList resolutionList workspaceList;

        autostart = pkgs.pkgs.writeShellScriptBin "start" ''
          pypr &

          eww daemon
          eww open bar
          eww open leftdock

          swww init &
          sleep 1
          ${swww_scripts}/bin/swww_sm
        '';

        # monitor = assert monitorList != []; lib.lists.zipListsWith (x: y: "${x},${y}") monitorList resolutionList;
        monitor = lib.lists.zipListsWith (x: y: "${x},${y}") monitorList resolutionList;

        workspace = builtins.concatLists <| lib.lists.zipListsWith (x: y: y |> map (z: "${toString z},monitor:${x}")) monitorList workspaceList;
      in {
        enable = true;
        settings = {

          inherit monitor workspace;

          exec-once = [
            "${autostart}/bin/start"
            "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
            "wl-paste --watch cliphist store"
          ];

          general = {
            border_size = "3";
            "col.active_border" = "rgb(ce3454) rgb(82d5ff) 45deg";
          };

          decoration = {
            # drop_shadow = "yes";
            # shadow_range = "300";
            # shadow_render_power = "4";
            # "col.shadow" = "rgba(1a1a1aaf)";
            # shadow_offset = "0 40";
            # shadow_scale = "0.9";
            rounding = "10";
            active_opacity = "0.75";
            inactive_opacity = "0.4";

            blur = {
              enabled = true;
              ignore_opacity = true;
              size = "8";
              passes = "2";
              xray = true;
            };
          };

          input = {
            #follow_mouse = "1";
            sensitivity = "0.0";
            touchpad = lib.mkIf config.cyanea.system.laptop.enable {
              natural_scroll = true;
              middle_button_emulation = true;
            };
          };

          windowrulev2 = [
            "opacity 1.0 override 1.0 override,class:(firefox)"
            "opacity 1.0 override 1.0 override,class:(Google-chrome)"
            "opacity 1.0 override 1.0 override,class:(virt-manager)"
            "opacity 1.0 override 1.0 override,class:(vesktop)"
            "opacity 1.0 override 1.0 override,title:(GlslViewer)"

            "float,title:(GLFW)"
            "animation slidefade 20%,title:(GLFW)"
          ];

          layerrule = [
            "animation popin 20%, ^(rofi)$"
            "blur, ^(rofi)$"
            "ignorezero, ^(rofi)$"
            "dimaround, ^(rofi)$"
          ];
        };
      };
    };
  };
}

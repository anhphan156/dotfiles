{
  pkgs,
  config,
  lib,
  user,
  ...
}: {
  options.cyanea.services.water_reminder.enable = lib.mkEnableOption "Enable water reminder timer";

  config = lib.mkIf config.cyanea.services.water_reminder.enable {
    systemd.timers."water-reminder" = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "30m";
        OnUnitActiveSec = "30min";
        Unit = "water-reminder.service";
      };
    };
    systemd.services."water-reminder" = {
      script = ''
        ${pkgs.libnotify}/bin/notify-send "Reminder" "Drink yo watah" -t 30000 --icon="/home/backspace/dotfiles/config/awesome/themes/default/icons/rain.png"
      '';
      serviceConfig = {
        Type = "oneshot";
        User = "${user.name}";
        Environment = "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus";
      };
    };
  };
}

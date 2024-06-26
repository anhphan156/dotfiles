{
  user,
  config,
  lib,
  ...
}: {
	imports = [
		({
			services.xremap.enable = lib.mkForce config.cyanea.system.xremap.enable;
		})
	];

  options.cyanea.system.xremap.enable = lib.mkEnableOption "Enable Xremap";

  config = lib.mkIf config.cyanea.system.xremap.enable {
    services.xremap = {
      withWlroots = config.cyanea.graphical.hyprland.enable;
      userName = user.name;
      config = {
        modmap = [
          {
            name = "Key remap";
            remap = {
              CONTROL_L = "CAPSLOCK";
              CAPSLOCK = "CONTROL_L";
            };
          }
        ];
      };
    };
  };
}

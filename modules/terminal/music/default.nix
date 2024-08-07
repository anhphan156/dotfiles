{
  config,
  pkgs,
  user,
  lib,
  ...
}: {
  options.cyanea.music.enable = lib.mkEnableOption "Enable mpd and ncmpcpp";

  config = lib.mkIf config.cyanea.music.enable {
    mpd = lib.enabled;
    ncmpcpp = lib.enabled;

    home-manager.users."${user.name}".home.packages =
      if config.ncmpcpp.enable
      then
        with pkgs; [
          (import (user.rootPath + /packages/user_scripts/kitty_spawn/spawn_ncmpcpp.nix) {inherit pkgs;})
          (import (user.rootPath + /packages/user_scripts/music/music_retag.nix) {inherit pkgs;})
          (import (user.rootPath + /packages/user_scripts/music/yt-dlp_mp3.nix) {inherit pkgs;})
          mpc-cli
        ]
      else [];
  };
}

{
  writeShellScript,
  src,
  ...
}: let
  data = builtins.readFile (src + /config/eww/data/leftdock.json);
in
  writeShellScript "leftdockpopulate" ''
    eww update items='${data}'
  ''

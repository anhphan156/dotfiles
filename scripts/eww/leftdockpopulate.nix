{
  writeShellApplication,
  eww,
  data,
  ...
}:
writeShellApplication {
  name = "leftdockpopulate";
  runtimeInputs = [eww];
  text = ''
    # shellcheck disable=all
    eww update items='${data}'
  '';
}

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
    # shellcheck disable=SC1079,SC2140,SC1078
    eww update items="${data}"
  '';
}

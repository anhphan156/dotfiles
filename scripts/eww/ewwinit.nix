{
  writeShellApplication,
  leftdockpopulate,
  eww,
  ...
}:
writeShellApplication {
  name = "ewwinit";
  runtimeInputs = [eww leftdockpopulate];
  text = ''
    eww daemon

    eww open bar
    eww open leftdock

    leftdockpopulate
  '';
}

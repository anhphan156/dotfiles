{
  writeShellScript,
  leftdockpopulate,
  ...
}:
writeShellScript "ewwinit" ''
  eww daemon

  eww open bar
  eww open leftdock

  ${leftdockpopulate}
''

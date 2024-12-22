{writeShellScript, ...}:
writeShellScript "leftdockcheck" ''
  eww update revealdock=true

  hyprctl clients | grep "class: firefox"

  if [[ $? -eq 0 ]]; then
    eww update icon1=true
  else
    eww update icon1=false
  fi
''

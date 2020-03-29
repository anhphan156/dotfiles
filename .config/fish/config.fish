~/bin/bunnyfetch

set_color green
printf "There is"
set_color normal
set_color red
printf " no "
set_color normal
set_color magenta
printf "place like "
set_color normal
set_color red
echo "~/"
set_color normal


fish_vi_key_bindings
function fish_mode_prompt
end

function fish_greeting
end

abbr SS "sudo systemctl"
abbr fcf "vim ~/.config/fish/config.fish"
abbr sfcf ". ~/.config/fish/config.fish"
abbr sysup "sudo apt update && sudo apt upgrade"
abbr get "sudo apt install"
abbr bac "bash -c"

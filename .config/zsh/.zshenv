# /etc/zsh/zshenv: system-wide .zshenv file for zsh(1).
#
# This file is sourced on all invocations of the shell.
# If the -f flag is present or if the NO_RCS option is
# set within this file, all other initialization files
# are skipped.
#
# This file should contain commands to set the command
# search path, plus other important environment variables.
# This file should not contain commands that produce
# output or assume the shell is attached to a tty.
#
# Global Order: zshenv, zprofile, zshrc, zlogin

if [[ -z "$PATH" || "$PATH" == "/bin:/usr/bin" ]]
then
	export PATH="/usr/local/bin:/usr/bin:/bin:/usr/games"
fi

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

export ZDOTDIR=$HOME/.config/zsh

export HISTFILE="$XDG_DATA_HOME"/zsh/history

export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

export WGETRC="$XDG_CONFIG_HOME/wgetrc"

export JAVA_HOME=/usr/local/java/jdk-11.0.7+10

export _Z_DATA=$XDG_DATA_HOME/zsh/.z

export ELECTRUMDIR="$XDG_DATA_HOME/electrum"

export FZF_DEFAULT_COMMAND=' ag --hidden --ignore .git -g ""'

export PATH=$PATH:$JAVA_HOME/bin
export PATH=$PATH:$HOME/Documents/dotfiles/bin
export PF_INFO="ascii title os host kernel pkgs memory shell editor wm palette"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

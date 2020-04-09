PROMPT="
%(?:%{$fg_bold[green]%}➜%{$reset_color%} %{$fg[yellow]%}`whoami`:%{$fg_bold[red]%}➜ `whoami`)"
PROMPT+=' %{$fg_bold[white]%}at%{$reset_color%} %{$fg[magenta]%}`hostname`%{$reset_color%} %{$fg_bold[white]%}in%{$reset_color%} %{$fg[cyan]%}`basename $PWD`%{$reset_color%} $(git_prompt_info)
↪ '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

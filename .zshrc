setopt extendedglob

[[ X"$DISPLAY" == X"" ]] && ZSH_THEME="af-magic" || ZSH_THEME="agnoster"
[[ -n "$DISPLAY" && "$TERM" = "xterm" ]] && export TERM=xterm-256color

CASE_SENSITIVE="true"
DISABLE_CORRECTION="true"
ZSH=$HOME/.oh-my-zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)


eval "$(hub alias -s)"
plugins=(redis-cli gem scala systemd colored-man colorize gitignore history-search git hub command-not-found lol nix hoogle)
source $ZSH/oh-my-zsh.sh

source $HOME/.profile
bindkey "^[[1;3C" forward-word 
bindkey "^[[1;3D" backward-word

# make git reset HEAD^ etc work
setopt NO_NOMATCH

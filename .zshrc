# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

source /home/.config/broot/launcher/bash/br

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/mcli mcli

# added by travis gem
[ ! -s /home/.travis/travis.sh ] || source /home/.travis/travis.sh

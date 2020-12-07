# if interactive shell
if [ ! -z "$PS1" ]; then
	exec /usr/bin/fish "$@"
fi
export SHELL=/usr/bin/fish

source /home/.config/broot/launcher/bash/br

complete -C /usr/bin/mcli mcli

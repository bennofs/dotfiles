export SHELL=/usr/bin/fish

source /home/.config/broot/launcher/bash/br

complete -C /usr/bin/mcli mcli
export PATH="/home/.local/share/solana/install/active_release/bin:$PATH"

source "$HOME/.profile"

# if interactive shell
if [ -n "$PS1" ]; then
	exec /usr/bin/fish "$@"
fi

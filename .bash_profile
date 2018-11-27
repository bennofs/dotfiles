source ~/.profile

# if interactive shell
if [ ! -z "$PS1" ]; then
	exec /usr/bin/fish "$@"
fi
export SHELL=/usr/bin/fish

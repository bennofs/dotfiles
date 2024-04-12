#!/usr/bin/env bash
eval $(sed -re 's/^([^=]*)=(.*)/export \1='\''\2'\'/ /run/user/1000/env/global)
exec "$@"

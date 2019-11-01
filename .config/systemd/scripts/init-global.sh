#!/usr/bin/env bash
mkdir -p $XDG_RUNTIME_DIR/env
export PATH=$SAVED_PATH
bash --login -c "env" > $XDG_RUNTIME_DIR/env/global

#!/usr/bin/env bash
mkdir -p $XDG_RUNTIME_DIR/env
export PATH=$SAVED_PATH
/usr/bin/bash --login -c "env" > $XDG_RUNTIME_DIR/env/global

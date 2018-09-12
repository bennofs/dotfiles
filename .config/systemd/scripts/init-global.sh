#!/usr/bin/env bash
mkdir -p $XDG_RUNTIME_DIR/env
bash --login -c "env" > $XDG_RUNTIME_DIR/env/global

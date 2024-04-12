#!/usr/bin/env bash
# wait for systemd to import Xauthority
while ! systemctl --user show-environment | grep -q '^XAUTHORITY='; do
  sleep 1
done

mkdir -p $XDG_RUNTIME_DIR/env
export PATH=$SAVED_PATH

# use bash to get normal login environment
# ignore XAUTHORITY/DISPLAY, those are provided by systemd via /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
/usr/bin/bash --login -c "env" | /usr/bin/grep -vE '^XAUTHORITY=|DISPLAY=' > $XDG_RUNTIME_DIR/env/global

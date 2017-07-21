with (import <nixpkgs> {});
{

# gdrive = ''
#  [Unit]
#  Description=Google Drive Synchronization Daemon
#  [Service]
#  ExecStartPre=${coreutils}/bin/mkdir -p /mnt/gdrive
#  ExecStart=${google-drive-ocamlfuse}/bin/google-drive-ocamlfuse -f /mnt/gdrive
#  Environment=PATH=/var/setuid-wrappers:/usr/bin
# '';

emacs = ''
 [Unit]
 Description=Emacs daemon
 Requires=init-global.service
 After=init-global.service
 [Service]
 ExecStart=${emacs}/bin/emacs --daemon
 Type=forking
 Restart=always
 EnvironmentFile=%t/env/global
 Environment=RUST_SRC_PATH="${rustPlatform.rustcSrc}"
'';

init-global = ''
 [Unit]
 Description=Global initialization that should be done before every other unit
 [Service]
 Type=oneshot
 RemainAfterExit=true
 ExecStart=${pkgs.writeScript "init-global" ''
 #!${stdenv.shell}
 mkdir -p $XDG_RUNTIME_DIR/env
 ${bash}/bin/bash --login -c "env" > $XDG_RUNTIME_DIR/env/global
 ''}

'';

# weechat = ''
# [Unit]
# Description=tmux weechat session
# 
# [Service]
# Environment=TERM=xterm
# Environment=TERMINFO=/usr/share/terminfo
# ExecStart=/usr/bin/script /tmp/weechat -c "/usr/bin/weechat"  --timing=/tmp/weechat.timing
# '';

}

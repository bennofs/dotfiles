with (import <nixpkgs> {});
{

gdrive = ''
 [Unit]
 Description=Google Drive Synchronization Daemon
 [Service]
 ExecStartPre=${coreutils}/bin/mkdir -p /mnt/gdrive
 ExecStart=${google-drive-ocamlfuse}/bin/google-drive-ocamlfuse -f /mnt/gdrive
 Environment=PATH=/var/setuid-wrappers:/usr/bin
'';

emacs = ''
 [Unit]
 Description=Emacs daemon
 [Service]
 ExecStart=${emacs}/bin/emacs --daemon
 Type=forking
 Restart=always
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

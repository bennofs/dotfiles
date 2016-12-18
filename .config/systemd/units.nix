with (import <nixpkgs> {});
{

gdrive = ''
 [Unit]
 Description=Google Drive Synchronization Daemon
 [Service]
 ExecStartPre=${coreutils}/bin/mkdir -p /mnt/gdrive
 ExecStart=${google-drive-ocamlfuse}/bin/google-drive-ocamlfuse -f /mnt/gdrive
 Environment=PATH=/var/setuid-wrappers
'';

}

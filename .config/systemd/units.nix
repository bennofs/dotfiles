with (import <nixpkgs> {});
let
  mpdDataDir = "/home/.local/share/mpd";
  mpdConf = pkgs.writeText "mpd.conf" ''
    music_directory     "/data/music"
    playlist_directory  "${mpdDataDir}/playlists"
    db_file             "${mpdDataDir}/tag_cache"
    state_file          "${mpdDataDir}/state"
    sticker_file        "${mpdDataDir}/sticker.sql"
    log_file            "syslog"
    log_level           "default"
    audio_output {
      type "alsa"
      name "default"
    }
  '';
in {

gdrive = ''
 [Unit]
 Description=Google Drive Synchronization Daemon
 [Service]
 ExecStart=${google-drive-ocamlfuse}/bin/google-drive-ocamlfuse -f /home/gdrive
 Environment=PATH=/var/setuid-wrappers
'';

mpd = ''
 [Unit]
 Description="Music Player Dameon";
 #Requires=pulseaudio.service
 [Service]
 ExecStartPre=${coreutils}/bin/mkdir -p ${mpdDataDir}
 ExecStart=${mpd}/bin/mpd --no-daemon ${mpdConf}
'';

emacs = ''
 [Unit]
 Description="Emacs Daemon";

 [Service]
 Type=forking
 ExecStart=${emacs}/bin/emacs --daemon
 ExecStop=${emacs}/bin/emacsclient --eval "(kill-emacs)"
 Restart=always
'';

}

set follow-fork-mode child
set detach-on-fork off
set debug-file-directory result-debug/lib/debug
source /code/pwndbg/gdbinit.py
pi pwndbg.events.after_reload()
set sysroot /
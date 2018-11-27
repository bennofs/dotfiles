set follow-fork-mode child
set detach-on-fork off
set debug-file-directory result-debug/lib/debug
source /code/pwndbg/gdbinit.py
#source /code/peda/peda.py
pi import pwndbg; pwndbg.events.after_reload()
set sysroot /
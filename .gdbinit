#source /code/peda/peda.py
#source ~/software/peda/peda.py
add-auto-load-safe-path /code/kctf17/router/.gdbinit
add-auto-load-safe-path /code/squarectf17/6yte/.gdbinit
add-auto-load-safe-path /code/hacklu17/exam/.gdbinit
add-auto-load-safe-path /code/hacklu17/HeapHeaven/.gdbinit
add-auto-load-safe-path /code/codeblue17/simple_memo_pad/.gdbinit
add-auto-load-safe-path /code/hctf17/gusetbook/.gdbinit
add-auto-load-safe-path /code/hctf17/babyprintf/.gdbinit
add-auto-load-safe-path /code/34c3ctf/300/.gdbinit
add-auto-load-safe-path /code/34c3ctf/SimpleGC/.gdbinit
add-auto-load-safe-path /code/34c3ctf/primepwn_files/.gdbinit
add-auto-load-safe-path /code/plaidctf18/
add-auto-load-safe-path /code/defcon18/note-oriented/.gdbinit
add-auto-load-safe-path /code/rwctf18/kid_vm/.gdbinit
directory /code/glibc/malloc
directory /code/glibc/elf
directory $cwd
directory $cdir

set sysroot /

python
import os
if os.getenv("PWNTOOLS"):
  gdb.execute("source ~/.pwn.gdbinit") 
end

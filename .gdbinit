#source /code/peda/peda.py
#source ~/software/peda/peda.py
add-auto-load-safe-path /code/kctf17/router/.gdbinit
add-auto-load-safe-path /code/squarectf17/6yte/.gdbinit
add-auto-load-safe-path /code/hacklu17/exam/.gdbinit
add-auto-load-safe-path /code/hacklu17/HeapHeaven/.gdbinit
add-auto-load-safe-path /code/codeblue17/simple_memo_pad/.gdbinit
add-auto-load-safe-path /code/hctf17/gusetbook/.gdbinit
add-auto-load-safe-path /code/hctf17/babyprintf/.gdbinit

set sysroot /

python
import os
if os.getenv("PWNTOOLS"):
  gdb.execute("source ~/.pwn.gdbinit") 
end

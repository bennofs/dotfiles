#source /code/peda/peda.py
#source ~/software/peda/peda.py
add-auto-load-safe-path /code/rwctf19/accessible/.gdbinit
add-auto-load-safe-path /code/rwctf19/hCorem/.gdbinit
add-auto-load-safe-path /code/trendmicro19/y/files/.gdbinit
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
add-auto-load-safe-path /code/ecsc/kvm/.gdbinit
add-auto-load-safe-path /code/ecsc/fast-storage/.gdbinit
add-auto-load-safe-path /code/ctf/abyss/.gdbinit
add-auto-load-safe-path /code/selma/lab/rootfs/lib/i386-linux-gnu/libthread_db-1.0.so
add-auto-load-safe-path /code/selma/lab/.gdbinit
add-auto-load-safe-path /code/dragon19/
add-auto-load-safe-path /code/midnightsunctf20/
add-auto-load-safe-path /code/cscg20/
add-auto-load-safe-path /code/hackasat/
add-auto-load-safe-path /code/rlottie/build_dbg/.gdbinit
add-auto-load-safe-path /code/rr/build/.gdbinit
add-auto-load-safe-path /code/ALLESCTF2020
add-auto-load-safe-path /code/csaw20-finals
directory /store/src/glibc/malloc
directory /store/src/glibc/elf
directory $cwd
directory $cdir
set sysroot target:
set debuginfod enabled on

python
import os
if os.getenv("PWNTOOLS"):
  gdb.execute("source ~/.pwn.gdbinit") 
end
set debuginfod enabled on

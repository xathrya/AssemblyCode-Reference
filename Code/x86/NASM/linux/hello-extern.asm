; hello-extern.asm
; 
; Call external function cetak() and then exits.
; The function will write "Hello, World!".
;
; Compile:
;   $ gcc -c -o cetak.o cetak.c
;	$ nasm -felf64 -o hello-extern.o hello-extern.asm
;
; Linking:
;   (gcc)
;   $ ld -o hello-extern -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc cetak.o hello-extern.o
;
;-----------------------------------------------------

    global  _start
    extern  cetak

section .text
_start:
    ; Print the message
    call   cetak

    ; Terminate program
    mov     rax, 60
    mov     rdi, 0
    syscall
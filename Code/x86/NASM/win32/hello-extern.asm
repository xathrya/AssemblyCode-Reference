; hello-extern.asm
; 
; Call external function cetak() and then exits.
; The function will write "Hello, World!".
;
; Compile:
;   $ gcc -c -o cetak.o cetak.c
;   $ nasm -fwin64 -o hello-extern.obj hello-extern.asm
;
; Linking:
;   (gcc)
;   $ ld -o hello-extern cetak.o hello-extern.obj
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
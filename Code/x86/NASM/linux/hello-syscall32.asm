; hello-syscall32.asm
; 
; Write "Hello, World!" on one line and then exits. 
; This code use Linux Syscall.
;
; Compile:
;	$ nasm -felf32 -o hello-syscall32.o hello-syscall32.asm
;
; Linking:
;   (gcc)
;   $ gcc -m32 -o hello-syscall32 hello-syscall32.o
;
;-----------------------------------------------------

; // Equivalent C program
; int main()
; {
;   write(1, message, msglen);
; }

    global  _start

section .data
    message db 'Hello, World', 10
    msglen  equ $ - message

; The ABI
; syscall is in RAX
; Argument are stores in registers, from left to right (earlier to latest):
;       EBX, ECX, EDX, ESI, EDI, EBP
; The return value is stored in RAX

section .text
_start:
    ; Print the message
    mov     eax, 4          ; syscall = 4 (write)
    mov     ebx, 1          ; file descriptor = 1 (write to stdout)
    mov     ecx, message    ; the message
    mov     edx, msglen     ; the length of message
    int     80h             ; call the kernel

    ; Terminate program
    mov     eax, 1
    mov     ebx, 0
    int     80h
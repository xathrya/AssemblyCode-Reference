; hello-syscall64.asm
; 
; Write "Hello, World!" on one line and then exits. 
; This code use Linux Syscall.
;
; Compile:
;	$ nasm -felf64 -o hello-syscall64.o hello-syscall64.asm
;
; Linking:
;   (gcc)
;   $ ld -o hello-syscall64 hello-syscall64.o
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
; sycall is in rax
; Argument are store in registers, from left to right (earlier to latest):
;   RDI, RSI, RDX, RCX, R8, R9, ... (the rest is on the stack)

section .text
_start:
    ; Print the message
    mov     rax, 1          ; syscall = 1 (write)
    mov     rdi, 1          ; file descriptor = 1 (write to stdout)
    mov     rsi, message    ; the message 
    mov     rdx, msglen     ; the length of message
    syscall                 ; call the kernel

    ; Terminate program
    mov     rax, 60
    mov     rdi, 0
    syscall
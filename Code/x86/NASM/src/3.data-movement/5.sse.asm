; sse.asm
;
; The x86 architecture has special registers for
; manipulating floating-point numbers.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o sse.o sse.asm
;
;   (win32)
;   $ nasm -f win32 -o sse.o sse.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o sse sse.o
;
;   (windows)
;   $ ld -m i386pe -o sse sse.o
;
; Run in debugging environment / emulator
; 
;---------------------------------------------------

    global _start

section .data


section .text
_start:
    hlt         ; Halt the execution
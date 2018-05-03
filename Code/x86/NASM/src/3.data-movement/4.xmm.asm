; xmm.asm
;
; The x86 architecture has special registers for
; manipulating floating-point numbers.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o xmm.o xmm.asm
;
;   (win32)
;   $ nasm -f win32 -o xmm.o xmm.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o xmm xmm.o
;
;   (windows)
;   $ ld -m i386pe -o xmm xmm.o
;
; Run in debugging environment / emulator
; 
;---------------------------------------------------

    global _start

section .data


section .text
_start:
    hlt         ; Halt the execution
; immediate.asm
;
; Data movement of the immediate values.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o immediate.o immediate.asm
;
;   (win32)
;   $ nasm -f win32 -o immediate.o immediate.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o immediate immediate.o
;
;   (windows)
;   $ ld -m i386pe -o immediate immediate.o
;
; Run in debugging environment / emulator
; 
;---------------------------------------------------

    global _start

; 

section .text
_start:
; mov

; push

; pop

    hlt         ; Halt the execution
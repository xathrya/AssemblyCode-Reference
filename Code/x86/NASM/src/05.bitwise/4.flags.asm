; flags.asm
;
; set / clear the specific bit in flags register.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o flags.o flags.asm
;
;   (win32)
;   $ nasm -f win32 -o flags.o flags.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o flags flags.o
;
;   (windows)
;   $ ld -m i386pe -o flags flags.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start


section .text
_start:

; CLC (clear carry flag)
    clc 

; STC (set carry flag)
    stc 

; CMC (complement / toggling carry flag)
    cmc 


; CLI (clear interrupt flag)
    cli 

; STI (set interrupt flag)
    sti 


; CLD (clear direction flag)
    cld 

; STD (set direction flag)
    std 


; LAHF (load flags into AH register)
    lahf 

; SAHF (store flags from AH register)
    sahf 




    hlt         ; Halt the execution
; template.asm
;
; Goal:
;
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o template.o template.asm
;
;   (win32)
;   $ nasm -f win32 -o template.o template.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o templace templace.o
;
;   (windows)
;   $ ld -m i386pe -o templace templace.o
;
; Run in debugging environment / emulator
; 
;---------------------------------------------------

    global _start

section .data


section .text
_start:
    hlt         ; Halt the execution
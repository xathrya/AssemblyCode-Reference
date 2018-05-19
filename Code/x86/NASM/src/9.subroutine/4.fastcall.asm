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
;   $ gcc -m32 -o template template.o
;
; Run in debuggin environment / emulator
; 
;---------------------------------------------------

    global _start

section .data


section .text
_start:
    hlt         ; Halt the execution
; mem-to-reg.asm
;
; A data can be moved (copied) from certain location
; to a certain location.
; In this case, the operation of copy data from memory
; to register, and vice versa, is supported by the processors.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o mem-to-reg.o mem-to-reg.asm
;
;   (win32)
;   $ nasm -f win32 -o mem-to-reg.o mem-to-reg.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o mem-to-reg mem-to-reg.o
;
;   (windows)
;   $ ld -m i386pe -o mem-to-reg mem-to-reg.o
;
; Run in debugging environment / emulator
; 
;---------------------------------------------------

    global _start

section .data


section .text
_start:
    hlt         ; Halt the execution
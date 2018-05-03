; reg-to-reg.asm
;
; A data can be moved (copied) from certain location
; to a certain location.
; In this case, the operation of copy data from register
; to register is supported by the processors.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o reg-to-reg.o reg-to-reg.asm
;
;   (win32)
;   $ nasm -f win32 -o reg-to-reg.o reg-to-reg.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o reg-to-reg reg-to-reg.o
;
;   (windows)
;   $ ld -m i386pe -o reg-to-reg reg-to-reg.o
;
; Run in debugging environment / emulator
; 
;---------------------------------------------------

    global _start

section .data


section .text
_start:
    hlt         ; Halt the execution
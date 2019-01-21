; feature-check.asm
;
; Special registers SIMD operations.
; Move data from and to memory.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o feature-check.o feature-check.asm
;
;   (win32)
;   $ nasm -f win32 -o feature-check.o feature-check.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o feature-check feature-check.o
;
;   (windows)
;   $ ld -m i386pe -o feature-check.exe feature-check.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

; There are 8 64-bit MMX registers.
;   MM0, MM1, MM2, MM3, MM4, MM5, MM6, MM7

    global _start

section .data 


section .text 
_start:

; Check the MMX support using CPUID.
; The bit 23 in the CPUID is set if the MMX is supported.

    mov     eax, 1
    cpuid
    mov     eax, edx
    shr     eax, 23
    and     eax, 1


    hlt         ; Halt the execution
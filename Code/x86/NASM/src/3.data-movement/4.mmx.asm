; mmx.asm
;
; The x86 architecture has special registers for SIMD
; operations.
; the MMX registers are stacked with FPU which 
; also can be used for floating-point operations.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o mmx.o mmx.asm
;
;   (win32)
;   $ nasm -f win32 -o mmx.o mmx.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o mmx mmx.o
;
;   (windows)
;   $ ld -m i386pe -o mmx mmx.o
;
; Run in debugging environment / emulator
; 
;---------------------------------------------------

    global _start

section .data


section .text
_start:
    hlt         ; Halt the execution
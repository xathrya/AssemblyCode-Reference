; comparison.asm
;
; Special registers SIMD operations.
; Move data from and to memory.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o comparison.o comparison.asm
;
;   (win32)
;   $ nasm -f win32 -o comparison.o comparison.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o comparison comparison.o
;
;   (windows)
;   $ ld -m i386pe -o comparison comparison.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

; There are 8 64-bit MMX registers.
;   MM0, MM1, MM2, MM3, MM4, MM5, MM6, MM7

    global _start

section .data 
    qblock  dq 0xCAFEBABE, 0x13510030


section .text 
_start:

; Equality
; compares each unit in the groups for equality

    ; pcmpeqb   mm, mm/64
    pcmpeqb     mm1, mm0 
    pcmpeqb     mm0, qword [qblock]

    ; pcmpeqw   mm, mm/64
    pcmpeqw     mm1, mm0 
    pcmpeqw     mm0, qword [qblock]

    ; pcmpeqd   mm, mm/64
    pcmpeqd     mm1, mm0 
    pcmpeqd     mm0, qword [qblock]

; Greater than
; compares each unit in the groups for greater than

    ; pcmpgtb   mm, mm/64
    pcmpgtb     mm1, mm0 
    pcmpgtb     mm0, qword [qblock]

    ; pcmpgtw   mm, mm/64
    pcmpgtw     mm1, mm0 
    pcmpgtw     mm0, qword [qblock]

    ; pcmpgtd   mm, mm/64
    pcmpgtd     mm1, mm0 
    pcmpgtd     mm0, qword [qblock]



    hlt         ; Halt the execution
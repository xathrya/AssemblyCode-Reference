; immediate.asm
;
; Data movement of the immediate values.
; An immediate value can only be used as source operand
; it cannot be used as destination operand.
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
;-----------------------------------------------------------------------------

    global _start

section .bss 
    bblock  resb    1
    wblock  resw    1
    dblock  resd    1
    qblock  resq    1


section .text
_start:

; MOV 
    ; assign registers with immediate value
    ; the data-width of both source and destination must match

    mov      al, 0                  ; 8-bit         b0 00
    mov      bh, 1                  ; 8-bit         b7 01
    mov      cx, 2                  ; 16-bit        66 b9 02 00
    mov     edx, 3                  ; 32-bit        ba 03 00 00 00 
    ; (might be error in 32-bit)
    mov      r8, 4                  ; 64-bit        41 b8 04 00 00 00

    ; assign memory with immediate value
    ; the data-width of both source and destination must match

    mov     byte  [bblock], 1       ; 8-bit
    mov     word  [wblock], 2       ; 16-bit
    mov     dword [dblock], 3       ; 32-bit
    ; (might be error in 32-bit)
    mov     qword [qblock], 4       ; 64-bit


; PUSH
    ; Store the immediate value to stack (an address pointed by ESP).
    ; The stack should always be aligned, the size of element equals
    ; the memory alignment, which always:
    ;   * 4-byte in 32-bit program
    ;   * 8-byte in 64-bit program

    push    1           ; 8-bit         6a 01


    hlt         ; Halt the execution
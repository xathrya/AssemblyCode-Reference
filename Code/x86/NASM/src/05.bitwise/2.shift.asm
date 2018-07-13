; shift.asm
;
; Bit shifting.
;
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o shift.o shift.asm
;
;   (win32)
;   $ nasm -f win32 -o shift.o shift.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o shift shift.o
;
;   (windows)
;   $ ld -m i386pe -o shift shift.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start

; Shift is an instruction which move N bits to the left (or right).
; The vacant bit will then be filled by predefined bit.
; There are two categories of shift: arithmetic and logical.
; Logical shift will fill the vacant bit with zero, while the 
; Arithmetic shift will fill the bit with zero but the final result will
; be assured to have the correct signness.

section .bss 
    bblock  resb    2
    wblock  resw    1
    dblock  resd    1
    qblock  resq    1


section .text
_start:

; SHL (shift logical left)
    ; shl reg, imm
    shl      bl,  1                     ; 8-bit
    shl      bh,  2                     ; 8-bit
    shl      bx,  3                     ; 16-bit
    shl     ebx,  4                     ; 32-bit
    ; comment it or it might be error in 32-bit
    shl     rbx,  5                     ; 64-bit

    ; shl mem, imm
    shl     byte  [bblock],   1         ; 8-bit
    shl     byte  [bblock+1], 2         ; 8-bit
    shl     word  [wblock],   3         ; 16-bit
    shl     dword [dblock],   4         ; 32-bit
    ; comment it or it might be error in 32-bit
    shl     qword [qblock],   5         ; 64-bit


; SHR (shift logical right)
    ; shr reg, imm
    shr      bl,  1                     ; 8-bit
    shr      bh,  2                     ; 8-bit
    shr      bx,  3                     ; 16-bit
    shr     ebx,  4                     ; 32-bit
    ; comment it or it might be error in 32-bit
    shr     rbx,  5                     ; 64-bit

    ; shr mem, imm
    shr     byte  [bblock],   1         ; 8-bit
    shr     byte  [bblock+1], 2         ; 8-bit
    shr     word  [wblock],   3         ; 16-bit
    shr     dword [dblock],   4         ; 32-bit
    ; comment it or it might be error in 32-bit
    shr     qword [qblock],   5         ; 64-bit


; SAL (shift arithmetic left)
    ; sal reg, imm
    sal      bl,  1                     ; 8-bit
    sal      bh,  2                     ; 8-bit
    sal      bx,  3                     ; 16-bit
    sal     ebx,  4                     ; 32-bit
    ; comment it or it might be error in 32-bit
    sal     rbx,  5                     ; 64-bit

    ; sal mem, imm
    sal     byte  [bblock],   1         ; 8-bit
    sal     byte  [bblock+1], 2         ; 8-bit
    sal     word  [wblock],   3         ; 16-bit
    ; comment it or it might be error in 32-bit
    sal     dword [dblock],   4         ; 32-bit
    sal     qword [qblock],   5         ; 64-bit

; SAR (shift arithmetic right)
    ; sar reg, imm
    sar      bl,  1                     ; 8-bit
    sar      bh,  2                     ; 8-bit
    sar      bx,  3                     ; 16-bit
    sar     ebx,  4                     ; 32-bit
    ; comment it or it might be error in 32-bit
    sar     rbx,  5                     ; 64-bit

    ; sar mem, imm
    sar     byte  [bblock],   1         ; 8-bit
    sar     byte  [bblock+1], 2         ; 8-bit
    sar     word  [wblock],   3         ; 16-bit
    sar     dword [dblock],   4         ; 32-bit
    ; comment it or it might be error in 32-bit
    sar     qword [qblock],   5         ; 64-bit


    hlt         ; Halt the execution
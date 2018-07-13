; comparison.asm
;
; Simple comparison mechanism.
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
;-----------------------------------------------------------------------------

    global _start

; Comparison is class of instruction for comparing two value and resulting
; in condition of equality / inequality. There are two instructions here: cmp & test.
; Both instruction need two value: LHS (Left-Hand Side) and RHS (Right-Hand Side).
;
; The result of both instruction is one of the following:
;   - positive number: means the dst value is greater than src
;   - zero: means both dst and src has same value
;   - negative number: means the dst value is less than src
;
; Each instruction will affect the EFLAGS register.

section .data
    bblock db 135
    wblock dw 0xCAFE
    dblock dd 0xCAFEBABE
    qblock dq 0x13510030


section .text
_start:

; CMP (Compare)
    ; cmp LHS, RHS
    ;
    ; Basically this instruction subtracts one operand (RHS) from the other (LHS)
    ; for checking the equality. The result of operation is not stored anywhere.

    ; cmp   reg, reg
    cmp      bl,  al                    ; 8-bit
    cmp      bh,  ah                    ; 8-bit
    cmp      bx,  ax                    ; 16-bit
    cmp     ebx, eax                    ; 32-bit
    ; comment it or it might be error in 32-bit
    cmp     rbx, rax                    ; 64-bit

    ; cmp   reg, imm
    cmp      bl,  1                     ; 8-bit
    cmp      bh,  2                     ; 8-bit
    cmp      bx,  3                     ; 16-bit
    cmp     ebx,  4                     ; 32-bit
    ; comment it or it might be error in 32-bit
    cmp     rbx,  5                     ; 64-bit

    ; cmp   reg, mem
    cmp      al, byte  [bblock]         ; 8-bit
    cmp      ah, byte  [bblock]         ; 8-bit
    cmp      ax, word  [wblock]         ; 16-bit
    cmp     eax, dword [dblock]         ; 32-bit
    ; comment it or it might be error in 32-bit
    cmp     rax, qword [qblock]         ; 64-bit

    ; cmp   mem, reg
    cmp     byte  [bblock],    al       ; 8-bit
    cmp     byte  [bblock],    ah       ; 8-bit
    cmp     word  [wblock],    ax       ; 16-bit
    cmp     dword [dblock],   eax       ; 32-bit
    ; comment it or it might be error in 32-bit
    cmp     qword [qblock],   rax       ; 64-bit

    ; cmp   mem, imm
    cmp     byte  [bblock],   1         ; 8-bit
    cmp     word  [wblock],   3         ; 16-bit
    cmp     dword [dblock],   4         ; 32-bit
    ; comment it or it might be error in 32-bit
    cmp     qword [qblock],   5         ; 64-bit


; TEST
    ; test LHS, RHS
    ;
    ; Basically this instruction perform bitwise AND with two operands and modify the flags.
    ; The result of operation is not stored anywhere.

    ; test  reg, reg
    test     bl,  al                    ; 8-bit
    test     bh,  ah                    ; 8-bit
    test     bx,  ax                    ; 16-bit
    test    ebx, eax                    ; 32-bit
    ; comment it or it might be error in 32-bit
    test    rbx, rax                    ; 64-bit

    ; test  reg, mem
    test     al, byte  [bblock]         ; 8-bit
    test     ah, byte  [bblock]         ; 8-bit
    test     ax, word  [wblock]         ; 16-bit
    test    eax, dword [dblock]         ; 32-bit
    ; comment it or it might be error in 32-bit
    test    rax, qword [qblock]         ; 64-bit

    ; test  reg, imm
    test     bl,  1                     ; 8-bit
    test     bh,  2                     ; 8-bit
    test     bx,  3                     ; 16-bit
    test    ebx,  4                     ; 32-bit
    ; comment it or it might be error in 32-bit
    test    rbx,  5                     ; 64-bit

    ; test  mem, reg
    test    byte  [bblock],    al       ; 8-bit
    test    byte  [bblock],    ah       ; 8-bit
    test    word  [wblock],    ax       ; 16-bit
    test    dword [dblock],   eax       ; 32-bit
    ; comment it or it might be error in 32-bit
    test    qword [qblock],   rax       ; 64-bit

    ; test  mem, imm
    test    byte  [bblock],   1         ; 8-bit
    test    byte  [bblock],   2         ; 8-bit
    test    word  [wblock],   3         ; 16-bit
    test    dword [dblock],   4         ; 32-bit
    ; comment it or it might be error in 32-bit
    test    qword [qblock],   5         ; 64-bit


; SCAS / SCASB / SCASW / SCASD / SCASQ
    ; Compare data at address ES:SI to EAX register.

    scasb       ; compare with AL
    scasw       ; compare with AX
    scasd       ; compare with EAX
    ; comment it or it might be error in 32-bit
    scasq       ; compare with RAX



    hlt         ; Halt the execution
; signed.asm
;
; arithmetic operation on signed integer
;
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o signed.o signed.asm
;
;   (win32)
;   $ nasm -f win32 -o signed.o signed.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o signed signed.o
;
;   (windows)
;   $ ld -m i386pe -o signed signed.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start

section .bss 
    bblock  resb    2
    wblock  resw    1
    dblock  resd    1
    qblock  resq    1


section .text
_start:

; ADD (integer addition)
    ; Add the second value to the first and stores the result in first operand
    
    ; add reg, reg
    add      bl,  al                    ; 8-bit
    add      bh,  ah                    ; 8-bit
    add      bx,  ax                    ; 16-bit
    add     ebx, eax                    ; 32-bit
    ; comment it or it might be error in 32-bit
    add     rbx, rax                    ; 64-bit

    ; add reg, imm
    add      bl,  1                     ; 8-bit
    add      bh,  2                     ; 8-bit
    add      bx,  3                     ; 16-bit
    add     ebx,  4                     ; 32-bit
    ; comment it or it might be error in 32-bit
    add     rbx,  5                     ; 64-bit

    ; add reg, mem
    add      al, byte  [bblock]         ; 8-bit
    add      ah, byte  [bblock+1]       ; 8-bit
    add      ax, word  [wblock]         ; 16-bit
    add     eax, dword [dblock]         ; 32-bit
    ; comment it or it might be error in 32-bit
    add     rax, qword [qblock]         ; 64-bit

    ; add mem, reg
    add     byte  [bblock],    al       ; 8-bit
    add     byte  [bblock+1],  ah       ; 8-bit
    add     word  [wblock],    ax       ; 16-bit
    add     dword [dblock],   eax       ; 32-bit
    ; comment it or it might be error in 32-bit
    add     qword [qblock],   rax       ; 64-bit

    ; add mem, imm
    add     byte  [bblock],   1         ; 8-bit
    add     byte  [bblock+1], 2         ; 8-bit
    add     word  [wblock],   3         ; 16-bit
    add     dword [dblock],   4         ; 32-bit
    ; comment it or it might be error in 32-bit
    add     qword [qblock],   5         ; 64-bit


; SUB (integer subtraction)
    ; Subtract the second value from the first and stores the result in first operand.
    ; This operation is neglecting the existence of "borrow".
    
    ; sub reg, reg
    sub      bl,  al                    ; 8-bit
    sub      bh,  ah                    ; 8-bit
    sub      bx,  ax                    ; 16-bit
    sub     ebx, eax                    ; 32-bit
    ; comment it or it might be error in 32-bit
    sub     rbx, rax                    ; 64-bit

    ; sub reg, imm
    sub      bl,  1                     ; 8-bit
    sub      bh,  2                     ; 8-bit
    sub      bx,  3                     ; 16-bit
    sub     ebx,  4                     ; 32-bit
    ; comment it or it might be error in 32-bit
    sub     rbx,  5                     ; 64-bit

    ; sub reg, mem
    sub      al, byte  [bblock]         ; 8-bit
    sub      ah, byte  [bblock+1]       ; 8-bit
    sub      ax, word  [wblock]         ; 16-bit
    sub     eax, dword [dblock]         ; 32-bit
    ; comment it or it might be error in 32-bit
    sub     rax, qword [qblock]         ; 64-bit

    ; sub mem, reg
    sub     byte  [bblock],    al       ; 8-bit
    sub     byte  [bblock+1],  ah       ; 8-bit
    sub     word  [wblock],    ax       ; 16-bit
    sub     dword [dblock],   eax       ; 32-bit
    ; comment it or it might be error in 32-bit
    sub     qword [qblock],   rax       ; 64-bit

    ; sub mem, imm
    sub     byte  [bblock],   1         ; 8-bit
    sub     byte  [bblock+1], 2         ; 8-bit
    sub     word  [wblock],   3         ; 16-bit
    sub     dword [dblock],   4         ; 32-bit
    ; comment it or it might be error in 32-bit
    sub     qword [qblock],   5         ; 64-bit


; SBB (integer subtraction with borrow)
    ; Subtract the second value from the first and stores the result in first operand.
    ; If there is a borrow, it will takes the borrow (CF) into account.
    ; 
    ; It is equivalent to
    ;     dst = dst - (src + CF)
    
    ; sbb reg, reg
    sbb      bl,  al                    ; 8-bit
    sbb      bh,  ah                    ; 8-bit
    sbb      bx,  ax                    ; 16-bit
    sbb     ebx, eax                    ; 32-bit
    ; comment it or it might be error in 32-bit
    sbb     rbx, rax                    ; 64-bit

    ; sbb reg, imm
    sbb      bl,  1                     ; 8-bit
    sbb      bh,  2                     ; 8-bit
    sbb      bx,  3                     ; 16-bit
    sbb     ebx,  4                     ; 32-bit
    ; comment it or it might be error in 32-bit
    sbb     rbx,  5                     ; 64-bit

    ; sbb reg, mem
    sbb      al, byte  [bblock]         ; 8-bit
    sbb      ah, byte  [bblock+1]       ; 8-bit
    sbb      ax, word  [wblock]         ; 16-bit
    sbb     eax, dword [dblock]         ; 32-bit
    ; comment it or it might be error in 32-bit
    sbb     rax, qword [qblock]         ; 64-bit

    ; sbb mem, reg
    sbb     byte  [bblock],    al       ; 8-bit
    sbb     byte  [bblock+1],  ah       ; 8-bit
    sbb     word  [wblock],    ax       ; 16-bit
    sbb     dword [dblock],   eax       ; 32-bit
    ; comment it or it might be error in 32-bit
    sbb     qword [qblock],   rax       ; 64-bit

    ; sbb mem, imm
    sbb     byte  [bblock],   1         ; 8-bit
    sbb     byte  [bblock+1], 2         ; 8-bit
    sbb     word  [wblock],   3         ; 16-bit
    sbb     dword [dblock],   4         ; 32-bit
    ; comment it or it might be error in 32-bit
    sbb     qword [qblock],   5         ; 64-bit



; INC (increment) & DEC (decrement)
    ; Increase (or decrease) the value of operand by one. 
    
    ; inc reg 
    inc      bl                 ; 8-bit
    inc      bh                 ; 8-bit
    inc      bx                 ; 16-bit
    inc     ebx                 ; 32-bit
    ; comment it or it might be error in 32-bit
    inc     rbx                 ; 64-bit

    ; inc mem 
    inc     byte  [bblock]      ; 8-bit
    inc     byte  [bblock+1]    ; 8-bit
    inc     word  [wblock]      ; 16-bit
    inc     dword [dblock]      ; 32-bit
    ; comment it or it might be error in 32-bit
    inc     qword [qblock]      ; 64-bit

    ; dec reg 
    dec      bl                 ; 8-bit
    dec      bh                 ; 8-bit
    dec      bx                 ; 16-bit
    dec     ebx                 ; 32-bit
    ; comment it or it might be error in 32-bit
    dec     rbx                 ; 64-bit

    ; dec mem 
    dec     byte  [bblock]      ; 8-bit
    dec     byte  [bblock+1]    ; 8-bit
    dec     word  [wblock]      ; 16-bit
    dec     dword [dblock]      ; 32-bit
    ; comment it or it might be error in 32-bit
    dec     qword [qblock]      ; 64-bit


; IMUL (integer multiplication)
    ; There are two basic formats: two-operand and three-operand.
    ;   * two operand multiplies its two operand together and stores
    ;     the result in the first operand
    ;   * three-operand multiplies its last two operand together and
    ;     stores the result in the first operand.
    ; both operand should have same size
    
    ; imul reg, reg
    imul     ax,  bx                ; 16-bit
    imul    eax, ebx                ; 32-bit
    ; comment it or it might be error in 32-bit
    imul    rax, rbx                ; 64-bit

    ; imul reg, mem
    imul     ax,  word [wblock]     ; 16-bit
    imul    eax, dword [dblock]     ; 32-bit
    ; comment it or it might be error in 32-bit
    imul    rax, qword [qblock]     ; 64-bit

    ; imul reg, reg, imm
    imul     ax,  bx, 5             ; 16-bit
    imul    eax, ebx, 5             ; 32-bit 
    ; comment it or it might be error in 32-bit
    imul    rax, rbx, 5             ; 64-bit

    ; imul reg, mem, imm
    imul     ax,  word [wblock], 5  ; 16-bit
    imul    eax, dword [dblock], 5  ; 32-bit
    ; comment it or it might be error in 32-bit
    imul    rax, qword [qblock], 5  ; 64-bit


; IDIV (integer division)
    ; Divides the content of integer pair register by specified operand value.
    ; The result is quotiend and remainder.

    ; idiv reg
    idiv     cl             ; divide     AX  with  CL, the quotient in  AL and remainder in  AH
    idiv     cx             ; divide  DX:AX  with  CX, the quotient in  AX and remainder in  DX
    idiv    ecx             ; divide EDX:EAX with ECX, the quotient in EAX and remainder in EDX
    ; comment it or it might be error in 32-bit
    idiv    rcx             ; divide RDX:RAX with RCX, the quotient in RAX and remainder in RDX

    ; idiv mem
    idiv     byte [bblock]  ; divide     AX  with mem, the quotient in  AL and remainder in  AH
    idiv     word [wblock]  ; divide  DX:AX  with mem, the quotient in  AX and remainder in  DX
    idiv    dword [dblock]  ; divide EDX:EAX with mem, the quotient in EAX and remainder in EDX
    ; comment it or it might be error in 32-bit
    idiv    qword [qblock]  ; divide RDX:RAX with mem, the quotient in RAX and remainder in RDX


    hlt         ; Halt the execution
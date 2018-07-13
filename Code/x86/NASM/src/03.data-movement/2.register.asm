; register.asm
;
; Data movement of value in registers.
; Value inside a register can be assign to other location,
; either another register or memory address.
; 
; Compile:
;   (linux)
;   $ nasm -f elf32 -o register.o register.asm
;
;   (win32)
;   $ nasm -f win32 -o register.o register.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o register register.o
;
;   (windows)
;   $ ld -m i386pe -o register register.o
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

; MOV
    ; assign registers with value from other register
    ; the data-width of both source and destination must match

    mov      bl,  al                ; 8-bit         88 c3
    mov      bh,  ah                ; 8-bit         88 e7
    mov      bx,  ax                ; 16-bit        66 89 c3
    mov     ebx, eax                ; 32-bit        89 c3
    ; comment it or it might be error in 32-bit
    mov     rbx, rax                ; 64-bit        48 89 c3
    
    ; assign memory address with value from register
    ; the data-width of both source and destination must match
    mov     byte  [bblock], al      ; 8-bit
    mov     byte  [bblock+1], bh    ; 8-bit
    mov     word  [wblock], cx      ; 16-bit
    mov     dword [dblock], edx     ; 32-bit
    ; comment it or it might be error in 32-bit
    mov     qword [qblock], r8      ; 64-bit


; PUSH
    ; Store the value of register to stack (an address pointed by ESP).
    ; The stack should always be aligned, the size of element equals
    ; the memory alignment, which always:
    ;   * 4-byte in 32-bit program
    ;   * 8-byte in 64-bit program

    ; comment it or it might be error in 64-bit
    push    eax         ; push 32-bit data

    ; comment it or it might be error in 32-bit
    push    rax         ; push 64-bit data


; POP
    ; Load the value of stack's top to register and discard the top.
    ; The stack should be aligned, the size of element equals the memory
    ; alignment, which always:
    ;   * 4-byte in 32-bit program
    ;   * 8-byte in 64-bit program

    ; comment it or it might be error in 64-bit
    pop     eax         ; push 32-bit data

    ; comment it or it might be error in 32-bit
    pop     rax         ; push 64-bit data


; LEA (Load Effective Address)
    ; put a memory address into destination, instead of the referenced value.
    ; the memory address is calculated from the source operand which met
    ; the addressing mode.
    
    ; lea reg, <address>
    ; [1] Displacement
    lea     eax, [bblock]                       ; eax = bblock
    lea     eax, [0x12345678]                   ; eax = 0x12345678

    ; [2] Base
    lea     eax, [ecx]                          ; eax = ecx

    ; [3] Base + Displacement
    lea     eax, [ecx + 4]                      ; eax = ecx + 4

    ; [4] (Index * Scale) + Displacement
    lea     eax, [wblock + ecx*4]               ; eax = wblock + ecx * 4

    ; [5] Base + Index + Displacement
    lea     eax, [wblock + ecx + 4]             ; eax = wblock + ecx + 4

    ; [6] Base + Index * Scale + Displacement
    lea     eax, [wblock + ecx * 4 + 4]         ; eax = wblock + ecx * 4 + 4

    ; LEA is often abused for calculating value.


; LODSB / LODSW / LODSD / LODSQ
    ; Load byte / word / dword.
    ; Load data at address DS:SI into AL / AX / EAX.
    ; After loading finish, the SI will be point to the next position in string, according to 
    ; direction flag (DF).

    ; the operation is equivalent to following C code:
    ;   if (DF == 0)   AL = *SI ++;
    ;   else           AL = *SI --; 

    lodsb       ; load data into AL
    lodsw       ; load data into AX
    lodsd       ; load data into EAX
    ; comment it or it might be error in 32-bit
    lodsq       ; load data into RAX



    hlt         ; Halt the execution
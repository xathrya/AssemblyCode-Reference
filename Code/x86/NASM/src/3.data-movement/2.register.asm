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
;---------------------------------------------------

    global _start

section .bss 
    bblock  resb    2
    wblock  resw    1
    dblock  resd    1
    qblock  resq    1


section .text
_start:
; move
    ; assign registers with value from other register
    ; the data-width of both source and destination must match
    mov      bl,  al                ; 8-bit         88 c3
    mov      bh,  ah                ; 8-bit         88 e7
    mov      bx,  ax                ; 16-bit        66 89 c3
    mov     ebx, eax                ; 32-bit        89 c3
    ; (might be error in 32-bit)
    mov     rbx, rax                ; 64-bit        48 89 c3
    
    ; assign memory address with value from register
    ; the data-width of both source and destination must match
    mov     byte  [bblock], al      ; 8-bit
    mov     byte  [bblock+1], bh    ; 8-bit
    mov     word  [wblock], cx      ; 16-bit
    mov     dword [dblock], edx     ; 32-bit
    ; (might be error in 32-bit)
    mov     qword [qblock], r8      ; 64-bit


; push
    ; push the value of register to stack
    ; the stack should always be aligned.
    ; the data should has size that match the memory alignment
    ; It most case, it is always:
    ;   * 4-byte in 32-bit program 
    ;   * 8-byte in 64-bit program

    ; comment it or it might be error in 64-bit
    push    eax         ; push 32-bit data

    ; comment it or it might be error in 32-bit
    push    rax         ; push 64-bit data

; pop
    ; pop the value from top of stack to register
    ; the stack should always be aligned.
    ; the data should has size that match the memory alignment
    ; It most case, it is always:
    ;   * 4-byte in 32-bit program 
    ;   * 8-byte in 64-bit program

    ; comment it or it might be error in 64-bit
    pop     eax         ; push 32-bit data

    ; comment it or it might be error in 32-bit
    pop     rax         ; push 64-bit data


; lea

    hlt         ; Halt the execution
; memory.asm
;
; Data movement of value in memory.
; Value inside a memory can be assign to other location.
; However only register is supported. 
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o memory.o memory.asm
;
;   (win32)
;   $ nasm -f win32 -o memory.o memory.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o memory memory.o
;
;   (windows)
;   $ ld -m i386pe -o memory memory.o
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
    ; assign registers with value from memory
    ; the data-width of both source and destination must match
    mov      bl, byte  [bblock]             ; 8-bit 
    mov      bh, byte  [bblock]             ; 8-bit 
    mov      bx, word  [wblock]             ; 16-bit
    mov     ebx, dword [dblock]             ; 32-bit
    ; comment it or it might be error in 32-bit
    mov     rbx, qword [qblock]             ; 64-bit


; PUSH
    ; Store the data at memory to stack (an address pointed by ESP).
    ; The stack should always be aligned, the size of element equals
    ; the memory alignment, which always:
    ;   * 4-byte in 32-bit program
    ;   * 8-byte in 64-bit program

    ; comment it or it might be error in 64-bit
    push    dword [dblock]      ; push 32-bit data

    ; comment it or it might be error in 32-bit
    push    qword [qblock]      ; push 64-bit data


; STOSB / STOSW / STOSD / STOSQ
    ; store byte / word / dword.
    ; Store data from AL / AX / EAX into address at DS:SI.
    ; After loading finish, the SI will be point to the next position in string,
    ; according to direction flag (DF).

    ; the operation is equivalent to following C code:
    ;   if (DF == 0)   *SI ++ = AL;
    ;   else           *SI -- = AL; 

    stosb       ; store from  AL
    stosw       ; store from  AX
    stosd       ; store from EAX
    stosq       ; store from RAX


; MOVSB / MOVSW / MOVSD / MOVSQ
    ; Move data at address DS:SI into ES:DI
    ; After moving finish, the SI and DI will point to the next position string, according
    ; to the direction flag (DF).

    ; the operation is equivalent to following C code:
    ;   if (DF == 0)    *DI ++ = *SI ++;
    ;   else            *DI -- = *SI --;

    movsb
    movsw
    movsd
    movsq



    hlt         ; Halt the execution
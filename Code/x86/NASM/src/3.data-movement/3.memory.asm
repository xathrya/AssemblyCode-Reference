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
;---------------------------------------------------

    global _start

section .bss 
    bblock  resb    1
    wblock  resw    1
    dblock  resd    1
    qblock  resq    1


section .text
_start:
; move
    ; assign registers with value from other register
    ; the data-width of both source and destination must match
    mov      bl, byte  [bblock]             ; 8-bit 
    mov      bh, byte  [bblock+1]           ; 8-bit 
    mov      bx, word  [wblock]             ; 16-bit
    mov     ebx, dword [dblock]             ; 32-bit
    ; (might be error in 32-bit)
    mov     rbx, qword [qblock]             ; 64-bit

; push
    ; push the value of register to stack
    ; the stack should always be aligned.
    ; the data should has size that match the memory alignment
    ; It most case, it is always:
    ;   * 4-byte in 32-bit program 
    ;   * 8-byte in 64-bit program

    ; comment it or it might be error in 64-bit
    push    dword [dblock]      ; push 32-bit data

    ; comment it or it might be error in 32-bit
    push    qword [qblock]      ; push 64-bit data
; stack.asm
;
; Stack access and modification.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o stack.o stack.asm
;
;   (win32)
;   $ nasm -f win32 -o stack.o stack.asm
;
; Linking:
;   $ gcc -m32 -o stack stack.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start

; Stack
; 
; Also called as `Last In First Out` (LIFO) structure.
; A segment in memory for storing data in ordered way by two primitive 
; operations: push and pop.
; Push is putting value to the top of the stack and pop is retrieving
; the value from the top.
; 
; Stack grows from high-memory to low-memory.


; Stack Frame
; 
; A stack frame is a portion of stack segment bound by ESP and EBP.
; Stack consists of several stack frames with active frame is on top
; of the stack.
;
; The frame define the local area of a function.
; Arguments and local variables are defined here.
;
;
;        ----------------
;       |      TOP       |     <--- ESP
;       |----------------|
;       |      ....      |
;       |----------------|
;       |    <N data>    |
;       |----------------|
;       |     BOTTOM     |     <--- EBP
;       |----------------|
;       | Previous Frame |
;


section .bss
    dblock  resd    1
    qblock  resq    1


section .text
_start:

; Space allocation & deallocation
    ; Allocating some space in stack is done by expanding the stack.
    ; Technically, it is done by decreasing the ESP.

    sub     esp, 128                ; allocating 128 bytes in stack

    ; Deallocating some space in stack is done by shrinking the stack.
    ; Technically, it is done by decreasing the ESP.
    ; The ESP should be consistent so all allocated area should be deallocated.

    add     esp, 128                ; deallocating 128 bytes in stack


; PUSH value
    ; Store the value of register to stack (an address pointed by ESP).
    ; The stack should always be aligned, the size of element equals
    ; the memory alignment, which always:
    ;   * 4-byte in 32-bit program
    ;   * 8-byte in 64-bit program

    ; push immediate value 
    push    135

    ; push register
    push    eax                     ; 32-bit program = 32-bit stack entry
    ; push    rax                     ; 64-bit program = 64-bit stack entry

    ; push content at memory address
    push    dword [dblock]          ; 32-bit program = 32-bit stack entry
    ; push    qword [qblock]          ; 64-bit program = 64-bit stack entry

    ; When pushing value is success, the stack is growing.
    ; Stack grows from high-memory to low-memory,
    ; indicated by current value of ESP register is less than before.


; Modification stack entry
    ; Modification of stack entry, either the address or the content.

    ; get the address
    mov     eax, esp                ; address of top (0th entry) of the stack
    lea     eax, [esp]
    lea     eax, [esp + 4]          ; get the 1st entry of the stack

    ; get the data of stack's top entry
    mov     eax, dword [dblock]     ; 32-bit program = 32-bit stack entry
    ; mov     rax, qword [qblock]     ; 64-bit program = 64-bit stack entry

    ; modify stack entry
    mov     dword [esp], eax        ; 32-bit program = 32-bit stack entry
    ; mov     qword [rsp], rax        ; 64-bit program = 64-bit stack entry

    ; usually local variable are referred as positive offset to ESP
    ; or negative offset to EBP

    ; usually function arguments are referred as positive offset to EBP

; POP value
    ; Load the value of stack's top to register and discard the top.
    ; The stack should be aligned, the size of element equals the memory
    ; alignment, which always:
    ;   * 4-byte in 32-bit program
    ;   * 8-byte in 64-bit program

    ; pop register
    pop     eax                     ; 32-bit program = 32-bit stack entry
    ; pop     rax                     ; 64-bit program = 64-bit stack entry

    ; pop content at memory address
    pop     dword [dblock]          ; 32-bit program = 32-bit stack entry
    ; pop     qword [qblock]          ; 64-bit program = 64-bit stack entry


    hlt         ; Halt the execution
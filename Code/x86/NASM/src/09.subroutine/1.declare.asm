; declare.asm
;
; declaring function and implementing it.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o declare.o declare.asm
;
;   (win32)
;   $ nasm -f win32 -o declare.o declare.asm
;
; Linking:
;   $ gcc -m32 -o declare declare.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start

; Function is a block of instructions identified by unique name (label), and 
; accomplish a specific task. A function might take a number of data, process it, and
; return a result. Once a function is defined, it can be used for many times.

section .data


section .text
_start:
    
    ; When a function is called, the execution is transferred to that block. 
    ; Following things happen:
    ;   - EIP / RIP points to function location, indicated by label
    ;   - stack is expanded with top entry contain the Return Address
    ;     or address which will be executed next when function has completed.

    ; There are different call conventions that should be noted. This module will not
    ; discuss any of them. See also following topic to learn each of them.
    ;   - cdecl
    ;   - stdcall
    ;   - fastcall
    ;   - thiscall
    ; 
    ; But calling a function all have same instruction, realized by CALL.
    
    ; call the function label directly
    call    func_empty 
    call    func_retval 
    call    func_complete

    ; indirect call, call the address pointed by a register
    mov     eax, func_empty 
    call    eax



    hlt         ; Halt the execution


;-----------------------------------------------------------------------------

; Declare an empty function
; The function is just return to caller after it is called.
func_empty:
    ; return to the caller
    ret 


;-----------------------------------------------------------------------------

; Declare a function that returning a value
; The function is returning a onstant value 135
func_retval:

    ; Most of codes use EAX to store the return value, though there is no prohibition
    ; to use other registers but we will use this common convention.

    mov     eax, 135
    ret 


;-----------------------------------------------------------------------------

; Declare a complete function with prologue and epilogue
func_complete:

    ; Function prologue is a set of instruction in earlier part of function.
    ; The purpose is to preserve the previous stack frame, creating new stack
    ; frame for current function, and allocating space if necessary.
    ;
    ; See also stack.asm

    push    ebp         ; preserve the previous stack base
    mov     ebp, esp    ; make EBP point to same address such as ESP
    sub     esp, 30     ; expand the stack frame


    ; some instructions here ...


    ; Function epilogue is a set of instruction in late part of function
    ; (before return). The purpose is to revert the stack frame to deallocating space
    ; if necessary, destroying current stack frame, and revert to previous stack frame.

    add     esp, 30     ; shrink the stack frame
    pop     ebp         ; obtain the old EBP value

    ret 
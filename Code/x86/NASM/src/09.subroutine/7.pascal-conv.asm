; pascal-conv.asm
;
; Pascal calling convention.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o pascal-conv.o pascal-conv.asm
;
;   (win32)
;   $ nasm -f win32 -o pascal-conv.o pascal-conv.asm
;
; Linking:
;   $ gcc -m32 -o pascal-conv pascal-conv.o
;
; Run in debuggin environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start

; Calling convention is a convention or set of rules which governs the function-calling.
; In general, it governs following things:
;   - how arguments are given.
;   - where the return value is stored
;   - who are responsible for cleaning the stack (arguments) after function-call.
;
; Based on Borland Pascal's calling convention
;
; In pascal caling convention, 
;   - The arguments are pushed on the stack in left-to-right order
;   - The return value is stored in
;       - EAX register for 'Ordinal' and pointer
;       - DX:BX:AX for 'Read' 
;       - ST0 for floating point
;   - The called function is responsible for cleaning the stack.


section .data


section .text
_start:

    ; Arguments are stored in registers. The most common registers are EDX, EAX, and ECX
    ; for storing arg1, arg2, and arg3 respectively. The rest (arg4) are stored in stack.
    ; In this case, we only need to pay attention on the order of stack when we
    ; pass the arguments.

    push    1       ; arg1
    push    2       ; arg2
    push    3       ; arg3
    push    4       ; arg4

    call    func_pascal


    hlt         ; Halt the execution


;-----------------------------------------------------------------------------

; Declare a function with pascal
;
; func_pascal(arg1, arg2, arg3 arg4)
;   => arg1 + arg2 + arg3 + arg4

func_pascal:

    ; function prologue
    push    ebp 
    mov     ebp, esp 

    ; function body
    ; in most case EDX, EAX, and ECX are used as 1st, 2nd, and 3rd arguments
    ; example of function body
    mov     eax, dword [ebp + 8]
    add     eax, dword [ebp + 12]
    add     eax, dword [ebp + 16]
    add     eax, dword [ebp + 20]

    ; function epilogue
    pop     ebp 

    ; Callee is cleaning the stack.
    ; This instruction make 4-bytes data is shrinked from the stack upon the return.
    ret     16
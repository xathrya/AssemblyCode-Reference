; fastcall-conv.asm
;
; Fastcall calling convention.
;
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o fastcall-conv.o fastcall-conv.asm
;
;   (win32)
;   $ nasm -f win32 -o fastcall-conv.o fastcall-conv.asm
;
; Linking:
;   $ gcc -m32 -o fastcall-conv fastcall-conv.o
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
; In fastcall caling convention, 
;   - The first two or three arguments are passed in registers. Additional arguments
;     or argument larger than the register size are passed to the stack with
;     right-to-left order.
;   - The return value is stored in EAX register 
;   - The calling function is responsible for cleaning the stack, if necessary.
;
; Because of the ambiguities, it is recommended that fastcall is used in situations
; with 1, 2, or 3 arguments only where speed is essential.


section .data


section .text
_start:

    ; Arguments are stored in registers. The most common registers are EDX, EAX, and ECX
    ; for storing arg1, arg2, and arg3 respectively. The rest (arg4) are stored in stack.
    ; In this case, we only need to pay attention on the order of stack when we
    ; pass the arguments.

    push    4           ; arg4
    mov     ecx, 3      ; arg3
    mov     eax, 2      ; arg2
    mov     edx, 1      ; arg1

    call    func_fastcall


    hlt         ; Halt the execution


;-----------------------------------------------------------------------------

; Declare a function with fastcall
;
; func_fastcall(arg1, arg2, arg3 arg4)
;   => arg1 + arg2 + arg3 + arg4

func_fastcall:

    ; function prologue
    push    ebp 
    mov     ebp, esp 

    ; function body
    ; in most case EDX, EAX, and ECX are used as 1st, 2nd, and 3rd arguments
    ; example of function body
    add     eax, edx                ; arg2 += arg1
    add     eax, ecx                ; arg2 += arg3
    add     eax, dword [ebp + 8]    ; arg2 += arg4

    ; function epilogue
    pop     ebp 

    ; Callee is cleaning the stack.
    ; This instruction make 4-bytes data is shrinked from the stack upon the return.
    ret     4
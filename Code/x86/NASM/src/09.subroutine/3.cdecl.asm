; cdecl.asm
;
; Create function with CDECL calling convention
;
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o cdecl.o cdecl.asm
;
;   (win32)
;   $ nasm -f win32 -o cdecl.o cdecl.asm
;
; Linking:
;   $ gcc -m32 -o cdecl cdecl.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start

; Calling convention is a convention or set of rules which governs the function-calling.
; In general, it governs following things:
;   - how arguments are given.
;   - where the return value is stored.
;   - preserved register across function call.
;   - who are responsible for cleaning the stack (arguments) after function-call.
;
; Cdecl is the standard / default calling convention in C.
;
; In cdecl calling convention,
;   - Arguments are passed in right-to-left order to stack.
;   - Integer values and memory address are returned in the EAX register,
;     floating point values in ST0.
;   - EAX, ECX, EDX are caller-saved and the rest are callee-saved.
;   - The caller is responsible to clean the stack.

section .data


section .text
_start:

    ; Arguments are pushed to the stack
    push    4       ; arg4
    push    3       ; arg3
    push    2       ; arg2
    push    1       ; arg1

    call    func_cdecl

    ; Caller is responsible for cleaning the stack.
    add     16      ; because we push four 32-bit data

    ; We can clean the stack everytime we call a function, or reuse the space
    ; and clean the stack in the end of execution.

    hlt         ; Halt the execution


;-----------------------------------------------------------------------------

; Declare a function with cdecl.
;
; func_cdecl(arg1, arg2, arg3, arg4)
;   => arg1 + arg2 + arg3 + arg4

func_cdecl:

    ; function prologue
    push    ebp
    mov     ebp, esp 

    ; function body
    mov     eax, dword [ebp +  8]       ; eax  = arg1
    mov     eax, dword [ebp + 12]       ; eax += arg2
    mov     eax, dword [ebp + 16]       ; eax += arg3
    mov     eax, dword [ebp + 20]       ; eax += arg4

    ; function epilogue
    pop     ebp 

    ret
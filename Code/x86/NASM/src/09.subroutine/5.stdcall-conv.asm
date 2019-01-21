; stdcall-conv.asm
;
; Creating function with STDCALL calling convention
;
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o stdcall-conv.o stdcall-conv.asm
;
;   (win32)
;   $ nasm -f win32 -o stdcall-conv.o stdcall-conv.asm
;
; Linking:
;   $ gcc -m32 -o stdcall-conv stdcal-convl.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start

; Calling convention is a convention or set of rules which governs the function-calling.
; In general, it governs following things:
;   - how arguments are given.
;   - where the return value is stored.
;   - who are responsible for cleaning the stack (arguments) after function-call.
;
; Stdcall is mostly used as Microsoft's standard calling convention for Win32 API.
;
; In stcall calling convention, 
;   - Arguments are passed in right-to-left order to stack.
;   - Return value is stored in eax register.
;   - The called function is responsible to clean the stack.
;
; Therefore, the stdcall doesn't allow variable-length arguments list.

section .data


section .text
_start:

    ; Arguments are pushed to the stack.
    push    4       ; arg4
    push    3       ; arg3
    push    2       ; arg2
    push    1       ; arg1

    call    func_stdcall

    hlt         ; Halt the execution



;-----------------------------------------------------------------------------

; Declare a function with stdcall.
;
; func_stdcall(arg1, arg2, arg3, arg4)
;   => arg1 + arg2 + arg3 + arg4

func_stdcall:

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

    ; Callee is cleaning the stack.
    ; This instruction make 16-bytes data is shrinked from the stack upon the return.
    ret     16
; optilink.asm
;
; Create function with CDECL calling convention
;
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o optilink.o optilink.asm
;
;   (win32)
;   $ nasm -f win32 -o optilink.o optilink.asm
;
; Linking:
;   $ gcc -m32 -o optilink optilink.o
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
; Optilink is used by IBM VisualAge compilers.
;
; In optilink calling convention,
;   - The first three arguments are passed in registers EAX, EDX, and ECX respectively
;     and up to four floating-point arguments are passed in ST0 to ST3.
;   - The return value is stored in EAX register or ST0 register.
;   - EBP, EBX, ESI, and EDI are preserved by caller.
;   - The caller is responsible to clean the stack.

section .data


section .text
_start:

    ; Arguments are pushed to the stack and register
    push    4           ; arg4
    mov     ecx, 3      ; arg3
    mov     edx, 2      ; arg2
    mov     eax, 1      ; arg1

    call    func_optilink

    ; Caller is responsible for cleaning the stack.
    add     4           ; because we push four 32-bit data

    ; We can clean the stack everytime we call a function, or reuse the space
    ; and clean the stack in the end of execution.

    hlt         ; Halt the execution


;-----------------------------------------------------------------------------

; Declare a function with optilink.
;
; func_optilink(arg1, arg2, arg3, arg4)
;   => arg1 + arg2 + arg3 + arg4

func_optilink:

    ; function prologue
    push    ebp
    mov     ebp, esp 

    ; function body
    mov     eax, edx                ; arg1 += arg2
    mov     eax, ecx                ; arg1 += arg3
    mov     eax, dword [ebp + 8]    ; arg1 += arg4

    ; function epilogue
    pop     ebp 

    ret
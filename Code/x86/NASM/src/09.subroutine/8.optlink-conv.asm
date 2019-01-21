; optlink-conv.asm
;
; Create function with Optlink calling convention
;
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o optlink-conv.o optlink-conv.asm
;
;   (win32)
;   $ nasm -f win32 -o optlink-conv.o optlink-conv.asm
;
; Linking:
;   $ gcc -m32 -o optlink-conv optlink.o
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
; In optlink calling convention,
;   - The first three arguments are passed in registers EAX, EDX, and ECX respectively
;     and up to four floating-point arguments are passed in ST0 to ST3.
;   - The rest of arguments are pushed right-to-left.
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

    call    func_optlink

    ; Caller is responsible for cleaning the stack.
    add     esp, 4      ; because we push 32-bit data (4th argument)

    ; We can clean the stack everytime we call a function, or reuse the space
    ; and clean the stack in the end of execution.

    hlt         ; Halt the execution


;-----------------------------------------------------------------------------

; Declare a function with optlink.
;
; func_optlink(arg1, arg2, arg3, arg4)
;   => arg1 + arg2 + arg3 + arg4

func_optlink:

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
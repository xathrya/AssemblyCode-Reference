; ms-x64-conv.asm
;
; Create function with Microsoft x64 calling convention
;
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o ms-x64-conv.o ms-x64-conv.asm
;
;   (win32)
;   $ nasm -f win32 -o ms-x64-conv.o ms-x64-conv.asm
;
; Linking:
;   $ gcc -m32 -o ms-x64-conv ms-x64.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start

; This calling convention is specific to x64
; The Microsoft x64 calling convention is followed on Windows and pre-boot UEFI.

; Calling convention is a convention or set of rules which governs the function-calling.
; In general, it governs following things:
;   - how arguments are given.
;   - where the return value is stored.
;   - preserved register across function call.
;   - who are responsible for cleaning the stack (arguments) after function-call.
;
; This is the only one calling convention for x64 of Windows.
;
; In this calling convention,
;   - The first four arguments are passed in registers RCX, RDX, R8, R9 respectively
;     for integer / pointers, and up to four floating-point arguments are passed in
;     XMM0, XMM1, XMM2, XMM3.
;   - The rest of arguments are pushed to stack in right-to-left order.
;   - The return value is stored in RAX register or XMM0 register.
;   - EBP, EBX, ESI, and EDI are preserved by caller.
;   - The caller is responsible to clean the stack.

section .data


section .text
_start:

    ; Arguments are pushed to the stack and register
    mov     rcx, 1      ; arg1
    mov     rdx, 2      ; arg2
    mov     r8,  3      ; arg3
    mov     r9,  4      ; arg4

    call    func_x64

    ; Caller is responsible for cleaning the stack.

    ; We can clean the stack everytime we call a function, or reuse the space
    ; and clean the stack in the end of execution.

    hlt         ; Halt the execution


;-----------------------------------------------------------------------------

; Declare a function with ms-x64.
;
; func_x64(arg1, arg2, arg3, arg4)
;   => arg1 + arg2 + arg3 + arg4

func_x64:

    ; function prologue
    push    rbp
    mov     rbp, rsp 

    ; function body
    add     rcx, rdx                ; arg1 += arg2 
    add     r8, r9                  ; arg3 += arg4
    add     rcx, r8 
    mov     rax, rcx 

    ; function epilogue
    pop     rbp 

    ret
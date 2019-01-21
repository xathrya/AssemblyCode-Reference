; sysv-abi-conv.asm
;
; Create function with Microsoft x64 calling convention
;
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o sysv-abi-conv.o sysv-abi-conv.asm
;
;   (win32)
;   $ nasm -f win32 -o sysv-abi-conv.o sysv-abi-conv.asm
;
; Linking:
;   $ gcc -m32 -o sysv-abi-conv sysv-abi-conv.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start

; This calling convention is specific to x64
; The System-V AMD64 ABI is followed on Solaris, Linux, FreeBSD, macOS and defacto on
; Unix (and Unix-like) operating system.

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
;   - The first six arguments are passed in registers RDI, RSI, RDX, RCX, R8, R9 respectively 
;     (R10 is used as static chain pointer in case of nested function) for integers / pointer,
;     and up to six floating-point arguments are passed in XMM0, XMM1, XMM2, XMM3, XMM4, XMM5.
;   - The rest of arguments are pushed to stack in right-to-left order.
;   - The return value is stored in RAX (64-bit) register or RDX:RAX (128-bit) for integer, and
;     XMM0 or XMM1:XMM0 for floating point.
;   - EBP, EBX, ESI, and EDI are preserved by caller.
;   - The caller is responsible to clean the stack.

section .data


section .text
_start:

    ; Arguments are pushed to the stack and register
    mov     rdi, 1      ; arg1
    mov     rsi, 2      ; arg2
    mov     rdx, 3      ; arg3
    mov     rcx, 4      ; arg4

    call    func_x64

    ; Caller is responsible for cleaning the stack.

    ; We can clean the stack everytime we call a function, or reuse the space
    ; and clean the stack in the end of execution.

    hlt         ; Halt the execution


;-----------------------------------------------------------------------------

; Declare a function with Sys-V ABI.
;
; func_x64(arg1, arg2, arg3, arg4)
;   => arg1 + arg2 + arg3 + arg4

func_x64:

    ; function prologue
    push    rbp
    mov     rbp, rsp 

    ; function body
    add     rdi, rsi                ; arg1 += arg2 
    add     rdx, rcx                ; arg3 += arg4
    add     rdi, rdx 
    mov     rax, rdi 

    ; function epilogue
    pop     rbp 

    ret
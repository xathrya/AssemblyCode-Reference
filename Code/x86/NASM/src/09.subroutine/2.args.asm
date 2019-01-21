; args.asm
;
; Creating a function that need argument and pass it to functions
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o args.o args.asm
;
;   (win32)
;   $ nasm -f win32 -o args.o args.asm
;
; Linking:
;   $ gcc -m32 -o args args.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start

; Function arguments are some data that passed to a function. Mostly they are
; predefined, in terms of number and type.
; There exists some calling conventions, but let's learn the very basic one.

; Function arguments are series / array of data, located in the stack,
; accessible by function in runtime. 


section .data


section .text
_start:

    ; Arguments are passed to function by push them in certain order. In this case,
    ; arguments are passed in right-to-left order or from the last argument to the
    ; first argument.
    ; Therefore, if the function is something like this:
    ;       f (arg1, arg2, arg3, arg4)
    ; 
    ; then the arguments would be pushed in following order:
    ;       arg4, arg3, arg2, arg1
    
    push    4
    push    3
    push    2
    push    1

    ; This will result in following layout of stack, just before the calling.
    ;
    ;      ESP                                 EBP
    ;   | arg1 | arg2 | arg3 | arg4 | ... other entry, don't care |

    call    func_arg4

    hlt         ; Halt the execution


;-----------------------------------------------------------------------------

; Declare a function that need 4 arguments
func_arg4:

    ; Once in the function body, the stack layout would be:
    ;
    ;         ESP                                          EBP
    ;   | Ret Address | arg1 | arg2 | arg3 | arg4 | ... other entry, don't care |
    ; 
    ; That is the stack frame of the previous function (the caller).
    ; In most case, a function will create new stack frame using the function prolog.

    ; function prologue
    push    ebp 
    mov     ebp, esp

    ; which makes the stack layout become this:
    ;
    ;     ESP & EBP
    ;   | Saved EBP | Ret Address | arg1 | arg2 | arg3 | arg4 | ... other entry, don't care |
    ; 
    ; In this case, it safe to assume that the arguments are located below the EBP.
    

    ; Accessing the arguments

    ; The most common way to access arguments are using EBP.
    ; If the function prologue exists, then the first argument is located in
    ; 2 entries below the EBP.

    ; 32-bit program
    mov     eax, dword [ebp +  8]       ; arg1
    mov     ebx, dword [ebp + 12]       ; arg2
    mov     ecx, dword [ebp + 16]       ; arg3
    mov     edx, dword [ebp + 20]       ; arg4

    ; 64-bit program
    mov     rax, qword [rbp + 16]       ; arg1
    mov     rbx, qword [rbp + 24]       ; arg2
    mov     rcx, qword [rbp + 32]       ; arg3
    mov     rdx, qword [rbp + 40]       ; arg4

    ; If not, then the first argument is located in 1 entry below the EBP

    ; 32-bit program
    mov     eax, dword [ebp +  8]       ; arg1
    mov     ebx, dword [ebp + 12]       ; arg2
    mov     ecx, dword [ebp + 16]       ; arg3
    mov     edx, dword [ebp + 20]       ; arg4

    ; 64-bit program
    mov     rax, qword [rbp + 16]       ; arg1
    mov     rbx, qword [rbp + 24]       ; arg2
    mov     rcx, qword [rbp + 32]       ; arg3
    mov     rdx, qword [rbp + 40]       ; arg4

    ; Other way to access arguments are using ESP.
    ; The concept is similar but we need to carefully trace the stack.


    ; function epilogue
    pop     ebp 

    ret
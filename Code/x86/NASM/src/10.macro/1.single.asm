; single.asm
;
; NASM support macros as preprocessing.
; A macro can be single-line or multiline.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o single.o single.asm
;
;   (win32)
;   $ nasm -f win32 -o single.o single.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o single single.o
;
;   (windows)
;   $ ld -m i386pe -o single single.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;-----------------------------------------------------------------------------

    global _start

; All single-line macro must be defined using %define directive.
; The general structure of a single-line macro is:
;
;   %define macro_name(parameter) value


; define a variable
;           name    value
%define     argc    esp + 8
%define     ctrl    0x1F &

; define a "function"
%define     param(a,b)      ((a)+(a)*(b))

; When expansion of single-line macro contains token which invoke another macro
; the expansion is performed at invocation time not definition time.

%define     a(x)    1 + b(x)
%define     b(x)    2 * x

; A macro can be overload as long as it has different signature

%define     foo(x)      1 + x
%define     foo(x,y)    1 + x * y



section .text 
_start:
    ; when macro is used, it will be expanded

    ; argc will be expanded to rsp + 8
    mov     eax, [argc]     ; in the end it would be `mov rax, [argc]

    ; expand this to `mov byte [(2)+(2)*(ebx)], 0x1F & 'D'
    mov     byte [param(2,ebx)], ctrl 'D'

    ; expand this to `mov eax, 1 + 2 * 3` or it will be `mov eax, 7`
    mov     eax, a(3)

    mov     eax, foo(2)
    mov     eax, foo(2,3)

    hlt
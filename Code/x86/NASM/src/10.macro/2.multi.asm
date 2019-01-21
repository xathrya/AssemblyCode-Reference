; multi.asm
;
; NASM support macros as preprocessing.
; A macro can be multi-line or multiline.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o multi.o multi.asm
;
;   (win32)
;   $ nasm -f win32 -o multi.o multi.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o multi multi.o
;
;   (windows)
;   $ ld -m i386pe -o multi multi.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;-----------------------------------------------------------------------------

    global _start

; All multi-line macro must be defined by enclosing them inside the %macro
; and %endmacro directive. The general structure of a multi-line macro is:
;
;   %macro  macro_name  number_of_parameters
;       instruction
;       instruction
;       ...
;   %endmacro

%macro prologue 1
    push    ebp
    mov     ebp, esp
; the parameter is referred by number (of order) such as %1, %2, etc
    sub     esp, %1
%endmacro


; Macro can have a local labels
; each call to label will instantiate a different string as label.
%macro retz 0
    jnz     %%skip
    ret 
%%skip:
%endmacro


; when expansion of multi-line macro contains token which invoke another macro
; the expansion is performed at invocation time not definition time.

%macro PRINT 1
    jmp %%astr
%%str      db %1, 0
; all label defined inside the macro must start with %%
%%strlen   equ $ - %%str 
%%astr: _syscall_write %%str, %%strlen 
%endmacro 


%macro _syscall_write 2
    mov     eax, 1
    mov     edi, 1
    mov     esi, %1
    mov     edx, %2
    syscall
%endmacro 



section .text 
_start:
    ; when macro is used, it will be expanded

    ; expanding prologue to 3 instructions
    prologue 12
    ; push    ebp
    ; mov     ebp, esp
    ; sub     esp, 12


    ; use the PRINT
label: PRINT "Hello World!"  

    hlt
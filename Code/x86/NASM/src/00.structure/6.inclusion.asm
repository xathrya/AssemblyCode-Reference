; inclusion.asm
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o inclusion.o inclusion.asm
;
;   (win32)
;   $ nasm -f win32 -o inclusion.o inclusion.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o inclusion inclusion.o
;
;   (windows)
;   $ ld -m i386pe -o inclusion inclusion.o
; 
;-----------------------------------------------------------------------------

; An external module (code, data, or both) can be included into current module,
; just like import function in other language
; The extension is not strictly define but it would be good to have some
; convention like this

%include "external.inc"

    global _start


section .data


section .text
_start:
    ; Other module can be included inside a function, which will directly rendered here.
    ; In this case, the "instr.inc" has instruction.
    ; Our _start would be expanded and have that instruction included.

    %include "instr.inc"
    
    hlt         ; Halt the execution
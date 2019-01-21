; param-range.asm
;
; NASM support macros as preprocessing.
; A special construction can be used to deal with range
; and its element.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o param-range.o param-range.asm
;
;   (win32)
;   $ nasm -f win32 -o param-range.o param-range.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o param-range param-range.o
;
;   (windows)
;   $ ld -m i386pe -o param-range param-range.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;-----------------------------------------------------------------------------

    global _start

; NASM allow to expand parameters via special construction %{x:y} where x is
; the first parameter index and y is the last.

; Any index can be negative or positive but must never be zero

; this macro receive variable number of parameter
%macro mpar 1-*
    db %{3:5}
%endmacro

; Valid range:
; Positive range
;   ${1:3}

; Negative range, which the order comes from the back.
; this will expand 1,2,3,4 to 4,3,2
;   %{-1:-3}

; Mix range
;   %{3:-3}

; Single element
;   %{-1:-1}



section .data
    ; when macro is used, it will be expanded

    ; expanding macro to accept element 3, 4, 5
arr:  mpr 1,2,3,4,5,6
    ; db 3, 4, 5

section .text 
_start:

    hlt
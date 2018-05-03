; constants.asm
;
; creating a constants value.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o constants.o constants.asm
;
;   (win32)
;   $ nasm -f win32 -o constants.o constants.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o define-data define-data.o
;
;   (windows)
;   $ ld -m i386pe -o define-data define-data.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;---------------------------------------------------

    global _start

; A constant can be declared by using 'equ' or equate instruction.
; There would be no space allocation in the final code.
; The symbol or token is simple will be evaluate later and any 
; occurrence of it will be replaced by corresponding value.
;
; Therefore, defining a constant would simply sets it to be the value.
lenequ:  equ 4      ; whenever `lenequ` is found in source code
                    ; it will be replace with 4

; The equ is used similar to what #define did in C
; #define lenequ 4


section .data
; Lets compare it to the 'db'
    lendb:   db 4   ; reserve 1 byte of memory 

section .text
_start:
; to illustrate the memory layout, we will use following code
    mov     eax, lenequ
    mov     eax, dword [lendb]
    
; if we illustrate the memory layout, it would be 
; something like this (assuming that the address of code is directly
; after the data section)
;
; addr      code            label   instruction
;-------------------------------------------
; 402000                    lenequ  equ 4
; 402000    04              lendb   db  4
; 402001    b8 04 00 00 00          mov eax, lenequ
; 402006    a1 00 20 40 00          mov eax, [lendb]

    hlt         ; Halt the execution
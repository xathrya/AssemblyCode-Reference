; declare.asm
;
; Goal:
;
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o declare.o declare.asm
;
;   (win32)
;   $ nasm -f win32 -o declare.o declare.asm
;
; Linking:
;   $ gcc -m32 -o declare declare.o
;
; Run in debugging environment / emulator
; 
;---------------------------------------------------

    global _start

;---------------------------------------------------
; Stack
;
; A segment in memory with special properties.
; Also called as `Last In First Out` memory (LIFO).
; Stack is storing value in ordered way.
; Primitive operation in a stack is a push-pop, where
; push is put value to the top of the stack and pop
; is retrieve the value from the top.
;
; A stack frame is a region bound by pair of ESP and EBP.
; This frame define the local area that can be viewed by
; a function. 
; Arguments and local variables are defined here.
;
;  
;---------------------------------------------------

section .data


section .text
_start:
    hlt         ; Halt the execution
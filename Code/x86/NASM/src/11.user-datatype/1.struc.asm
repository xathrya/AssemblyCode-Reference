; struc.asm
;
; define a data structure definition using NASM macro
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o struc.o struc.asm
;
;   (win32)
;   $ nasm -f win32 -o struc.o struc.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o struc struc.o
;
;   (windows)
;   $ ld -m i386pe -o struc struc.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;-----------------------------------------------------------------------------

; A structure is a collection of data which has certain layout. All struc must
; be define by enclosing them inside the "struct" and "endstruct".

; Define the data structure
struc person
    .name: resb 10
    .age:  resb 1
endstruc


    global _start

section .data
; creating instance of structure
xathrya: istruc person 
        at person.name, db "Xathrya"
        at person.age,  db 19
    iend 

section .text 
_start:
    ; accessing the field of structure
    mov     eax, [xathrya + person.name]

    hlt
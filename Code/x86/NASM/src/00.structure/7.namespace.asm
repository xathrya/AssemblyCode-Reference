; namespace.asm
;
; creating a namespace
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o namespace.o namespace.asm
;
;   (win32)
;   $ nasm -f win32 -o namespace.o namespace.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o namespace namespace.o
;
;   (windows)
;   $ ld -m i386pe -o namespace namespace.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start

section .data

section .text

; Label is a token which identify the position in code (and later in memory). 
; A label can be viewed as function, destination on branching, and
; part of loop.

_start:

; Labels that start with a period `.` get the previous non-local label 
; prepend to them, which may give them uniqueness.

; This namespace is useful break the program into smaller components without
; polluting the global naming 

outside_label:

    ; This should not be done in practice, but it shows how it works
    ; under the hood

    jmp     outside_label.inside_label
    mov     eax, 1
    hlt

.inside_label:
    
    ; This is what we should do in practice labels also get appended
    ; when used as arguments.
    
    jmp     .inside_label2
    mov     eax, 2
    hlt 

.inside_label2:
    mov     eax, 3
    hlt 

; Both .inside_label and .inside_label2 are inside the outside_label namespace
; they can be accessed by full name or partial. It is also possible to
; deepen the hierarchy.

    hlt         ; Halt the execution
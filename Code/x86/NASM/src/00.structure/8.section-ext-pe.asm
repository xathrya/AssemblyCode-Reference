; section-ext-pe.asm
;
; Learn the section extension (win32).
;
; Compile:
;   (win32)
;   $ nasm -f win32 -o section-ext-pe.o section-ext-pe.asm
;
; Linking:
;   (windows)
;   $ ld -m i386pe -o section-ext-pe section-ext-pe.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
; An extra directives are available to control the type and properties of 
; declared sections. If nothing declared, NASM will try to generate the properties
; automatically. The standard section names are assigned automatically. We can
; also give properties to a section, especially custom section.
;-----------------------------------------------------------------------------

    global _start

; The available qualifier:
;   - code (or text): the section is a code section which will have readable and
;                     and executable but not writable.
;   - data & bss: the section is a data section which have readable and writable
;                     but not executable. The only difference is about the state
;                     of initialization.
;   - info: the section is an informational section, which is not produced in
;                     final binary by linker.

; NASM also give liberty in alignment, which is a power of 2.

; The ".data" section is a "data section" with alignment of 4
section .data data align=4
    immutable_data: db 10

; The ".bss" section is a "bss section" with alignment of 4
section .bss  bss align=4
    mutable_data: resb 1

; The ".text" section is a "code section" with alignment of 16 
section .text code align=16
_start:

    hlt         ; Halt the execution
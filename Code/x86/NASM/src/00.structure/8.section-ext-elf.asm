; section-ext-elf.asm
;
; Learn the section ext (elELFf).
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o section-ext-elf.o section-ext-elf.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o section-ext-elf section-ext-elf.o
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
;   - alloc / noalloc:  defines whether the section is loaded into memory 
;                       when the program is run.
;   - exec / no exec:   defines whether the section is executable when the program
;                       is run.
;   - write / nowrite:: defines whether the section should be writable when
;                       the program is run.
;   - progbits / nobits:defines the section as having explicit content stored
;                       in object file.
;   - align:            define the allignment of section
;   - tls:              define the section as having Thread Local variables.

section .data progbits alloc noexec write align=4
    immutable_data: db 10

section .bss  nobits alloc noexec wrie align=4
    mutable_data: resb 1

section .text progbits alloc exec nowrite align=16
_start:

    hlt         ; Halt the execution

; Other:
; section .rodata    progbits alloc noexec nowrite align=4
; section .lrodata   progbits alloc noexec nowrite align=4
; section .ldata     progbits alloc noexec write align=4
; section .lbss      nogbits  alloc noexec write align=4
; section .tdata     progbits alloc noexec write align=4 tls
; section .tbss      nobits   alloc noexec write align=4 tls
; section .comment   progbits alloc noexec nowrite align=1
; section other      progbits alloc noexec nowrite align=1

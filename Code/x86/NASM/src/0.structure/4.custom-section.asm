; custom-section.asm
;
; NASM support custom section.
; We can declare a user-defined section, fill something,
; refer it anywhere.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o custom-section.o custom-section.asm
;
;   (win32)
;   $ nasm -f win32 -o custom-section.o custom-section.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o custom-section custom-section.o
;
;   (windows)
;   $ ld -m i386pe -o custom-section custom-section.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
;
; Use viewer for executable header to read the sections.
; 
;---------------------------------------------------

    global _start

; Some constants value
MAGIC  equ 0xBADBABE
MBALIGN equ 1 << 0
MEMINFO equ 1 << 1

; Declaring a user-defined section
section .custom
align 4         ; the data here should be 4-byte aligned
    magic: dd MAGIC
    dd MBALIGN
    dd MEMINFO

section .text
_start:

; Accessing the custom section is similar to standard one.
    push        dword magic
    hlt         ; Halt the execution

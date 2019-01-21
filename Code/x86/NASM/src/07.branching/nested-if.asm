; nested-if.asm
;
; A branching to multiple alternative condition and implications.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o nested-if.o nested-if.asm
;
;   (win32)
;   $ nasm -f win32 -o nested-if.o nested-if.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o nested-if nested-if.o
;
;   (windows)
;   $ ld -m i386pe -o nested-if nested-if.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start

; Branching is an act of switching execution to a different instruction sequence
; as result of executing a branch instruction, thus deviate from its default
; behavior of executing instruction in order.
; 
; Branch instruction can be either an unconditional branch (always result in branching)
; or conditional branch (may or may not result in branching). This basic block
; then make up to various control flow in higher programming language.
; for a more detail on conditional instructions, see topic "Conditional"
;
; The goal:
;   Simple branching inside of another simple branching.
;
;

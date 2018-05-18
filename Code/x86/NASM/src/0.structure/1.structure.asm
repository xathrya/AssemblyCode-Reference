; structure.asm
;
; Assembly source code consists of several component
; in structured way.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o structure.o structure.asm
;
;   (win32)
;   $ nasm -f win32 -o structure.o structure.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o structure structure.o
;
;   (windows)
;   $ ld -m i386pe -o structure structure.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;---------------------------------------------------

; This is one of directive
; The directive `global` tell the assembler which symbol 
; is available in global context.
    global _start

; This is one of section
; The section .data tells the assembler that an area of memory
; should be viewed as data, not instruction.
; Generally we put constant data in a section .data
section .data
    string: db "A string", 10


; This is one of section
; The section .text tells the assembler that an area of memory
; should be viewed as instruction.
; Generally we put code in section .text
section .text

; This is one of label
; Label is an identification to position in code (and later in memory)
; A label can be viewed as function, destination of branching, and 
; part of loop.
_start:         ; This label is a global, it means the linker or
                ; outside code can refer to this position.

; These are instructions
; Instruction is a statement that tells processor what to do.
; See more declaration example on `data-movement`,
; `arithmetic-operation`, `comparison`, and `logical`.
    mov     eax, 1
    mov     ebx, 2
    cmp     eax, ebx 
    hlt         ; Halt the execution

; A program can be divided into two components: data and instructions.
; However at least there are three distinct sections:
;   - The data section
;   - The bss section
;   - The text section

; The data section is used for declaring initialized data or constants.
; This data does not change at runtime.
; More on this section on `declaration`

; The bss section is used for declaring variables.
; This data is mutable or can change at runtime.
; More on this section on `declaration`

; The text section is used for keeping the actual code.
; Some compiler has common rule: the first instruction is pointed
; at _start label.
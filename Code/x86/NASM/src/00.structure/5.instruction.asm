; instruction.asm
;
; Instruction are statement that tells processor what to do.
; Grammatically, an instruction has a format.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o instruction.o instruction.asm
;
;   (win32)
;   $ nasm -f win32 -o instruction.o instruction.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o instruction instruction.o
;
;   (windows)
;   $ ld -m i386pe -o instruction instruction.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;-----------------------------------------------------------------------------

    global _start

section .data
    MEMVAR: dd 0


; Instruction is a one-line statement.
; Each instruction follows the format:
;   [label:] mnemonic [operands] [;comment]
;
; The fields in the square brackets are optional.
; 
; Typically an instruction has two parts. 
; The first part is the mnemonic (name of instruction which is to be executed.
; The second part is the operands, or parameters to the instruction.
;
; Not all instruction has operands. Some have only one operand while other
; can have two.
;
; Instruction should be inside the code segment. However, some peculiar executables
; might not follow this.

section .text
_start:

; Examples of instructions
; Two operands
    mov     ah, 10  ; assign the AH with 10
    add     ah, bh  ; add the content of BH register into AH register

; One operands
    inc     eax     ; increase the value by 1, for the register EAX
    dec     bh      ; decrease the content of the register BH
    push    eax     ; push the content of the register EAX to stack

; No operands
    syscall         ; invoke the OS syscall, OS dependant
    ret             ; return from function

; If the instruction has repetition, the `times` prefix can be used for 
; indicating that the next instruction should be replicated for a certain copies.
    times 100 movsb ; the result code will have 100 instructions of movsb

    hlt             ; Halt the execution
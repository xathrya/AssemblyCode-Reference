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
    ; Two-operands instructions involving two operands with one operands act as source
    ; and another act as destination. NASM follow the intel-style, which, in most case,
    ; we can generalize the instruction as:
    ;
    ;   INSTR   DST, SRC
    ;
    ; Where the INSTR is the instruction, SRC is the source of operation, and DST
    ; is the destination of operations. The DST is where the result of operation will
    ; be held. The DST can be though as LHS (Left Hand Side) of formula while the SRC
    ; as RHS (Right Hand Side).
    ; Thus, it can be translated such as:
    ;
    ;   DST INSTR SRC

    mov     ah, 10      ; assign the AH with 10
                        ; i.e. ah = 10
    add     ah, bh      ; add the content of BH register into AH register
                        ; i.e. ah = ah + bh

; One operands
    ; One-operand operation involving one operand only. In this case, the operand can be
    ; a source, or destination, depends on the instruction.

    inc     eax         ; increase the value by 1, for the register EAX
    dec     bh          ; decrease the content of the register BH
    push    eax         ; push the content of the register EAX to stack

; No operands
    syscall             ; invoke the OS syscall, OS dependant
    ret                 ; return from function

; If the instruction has repetition, the `times` prefix can be used for 
; indicating the next instruction should be replicated for a certain copies.
    times 100 movsb     ; the result code will have 100 instructions of movsb


    hlt         ; Halt the execution
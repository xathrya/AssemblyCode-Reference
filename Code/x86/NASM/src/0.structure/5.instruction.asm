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
;   $ gcc -m32 -o instruction instruction.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;---------------------------------------------------

    global _start

section .data
    MEMVAR: dd 0

;---------------------------------------------------
; Instruction is one-line statement.
; Each instruction follows the format:
;   [label:] mnemonic [operands] [;comment]
;
; The fields in the square brackets are optional.
; 
; Typically an instruction has two parts. 
; The first part is the mnemonic (name of instruction)
; which is to be executed.
; The second part is the operands, or parameters
; to the instruction.
;
; Not all instruction has operands. Some have only 
; one operand while other can have two.
;
; Instruction should be inside the code segment.
; However, some peculiar executables might not follow
; this.

;---------------------------------------------------
; There are three kinds of operands, as you can see above.
; Operands can be a register, a memory address, or immediate values.

;---------------------------------------------------
; Registers operands are the registers.
; The validregisters in operation are general purpose registers 
; (RAX, EBX, CX, DH, DL, etc) and the XMM registers.

;---------------------------------------------------
; Immaediate operands are the immediate values
; It is a number, or value.
; Value can be expressed in various way:
;   200              (decimal)
;   0200             (still decimal - the leading 0 does not make it octal)
;   0200d            (explicitly decimal - d suffix)
;   0d200            (also decimal - 0d prefex)
;   0c8h             (hex - h suffix, but leading 0 is required because c8h looks like a var)
;   0xc8             (hex - the classic 0x prefix)
;   0hc8             (hex - for some reason NASM likes 0h)
;   310q             (octal - q suffix)
;   0q310            (octal - 0q prefix)
;   11001000b        (binary - b suffix)
;   0b1100_1000      (binary - 0b prefix, and by the way, underscores are allowed)

;---------------------------------------------------
; Memory operands are the memory address.
; The operands are following this pattern:
;   [ base + index * scale + offset ]
;
; Base is the base value of the address.
;   It can be:
;   - register
;   - immediate (number)
; Scale is the multplier or scale of the base. 
;   It can only be: 1, 2, 4, 8 
; Index is the i-th scale.
; Offset or displacement is the displacement from the base.
;   It can be:
;   - register
;   - immediate (number)
;
; These are the examples of addressing
;   [ number ]
;   [ reg ]
;   [ reg * scale + reg ]
;   [ reg + reg * scale + number ]

;---------------------------------------------------
; In most case, the valid instructions can be:
;   inst reg, reg 
;   inst reg, mem 
;   inst reg, imm 
;   inst mem, reg 
;   inst mem, imm 

section .text
_start:

; Examples of instructions
; Two operands
    mov     AH, 10  ; assign the AH with 10
    add     AH, BH  ; add the content of BH register into AH register

; One operands
    inc     EAX     ; increase the value by 1, for the register EAX
    dec     BH      ; decrease the content of the register BH
    push    EAX     ; push the content of the register EAX to stack

; No operands
    syscall         ; invoke the OS syscall, OS dependant
    ret             ; return from function

    hlt             ; Halt the execution
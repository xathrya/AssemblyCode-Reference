; addressing-modes.asm
;
; Some instructions need data, which is stored somewhere.
; Addressing mode refers to the specification of the 
; location of data required by an operation.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o addressing-modes.o addressing-modes.asm
;
;   (win32)
;   $ nasm -f win32 -o addressing-modes.o addressing-modes.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o addressing-modes addressing-modes.o
;
;   (windows)
;   $ ld -m i386pe -o addressing-modes addressing-modes.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;-----------------------------------------------------------------------------

    global _start

; In most two operands instructions, one operand acts as source operand and
; the another one acts as destination operand.
;
; The data for a source operand can be located in:
;   - instruction itself (immediate operand)
;   - a register
;   - a memory location
;   - an I/O port
;
; While the destination operand, can be:
;   - a register
;   - a memory location
;   - an I/O port
;
; In most case, the valid instructions can be:
;   inst reg, reg 
;   inst reg, mem 
;   inst reg, imm 
;   inst mem, reg 
;   inst mem, imm 


; Registers operands are the registers.
; The valid registers in operation are general purpose registers 
;   - 64-bit GPR: RAX, RBX, RCX, RDX, RSI, RDI, RSP, RBP, R8-R15
;   - 32-bit GPR: EAX, EBX, ECX, EDX, ESI, EDI, ESP, EBP, R8D-R15D
;   - 16-bit GPR:  AX,  BX,  CX,  DX,  SI,  DI,  SP,  BP, R8W-R15W
;   -  8-bit GPR:  AL,  BL,  CL,  DL, SIL, DIL, SPL, BPL, R8L-R15L
; and also MMX registers (MM0 - MM7) and XMM registers (XMM0 - XMM15)


; Immediate operands are the immediate values. It is a number, or value.
;
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


; Memory operands are the memory address.
; The operands are following this pattern:
;   [ base + index * scale + displacement ]
;
; Base is the base value of the address.
; It can be a general purpose registers:
;   EAX, EBX, ECX, EDX, ESP, EBP, ESI, EDI
;   R8, R9, R10, R11, R12, R13, R14, R15
;
; Scale is the multplier or scale of the base. 
;   It can only be: 1, 2, 4, 8 
;
; Index is the i-th chunk of data, with size of `scale`. It can be a general
; purpose registers:
;   EAX, EBX, ECX, EDX, EBP, ESI, EDI
;   R8, R9, R10, R11, R12, R13, R14, R15
;
; Displacement is a direct (uncomputed) offset to the address. It can be
; an immediate value.

section .data
    BYTE_VALUE: db 150                  ; Defining a byte value
    WORD_VALUE: dw 300                  ; Defining a word value
    BYTE_TABLE: db 14, 15, 22, 45       ; Tables of bytes
    WORD_TABLE: dw 134, 345, 564, 123   ; Tables of words


section .text
_start:

; Various components of address operand can have valid combination for
; addressing a location.

    ; [1] Displacement 
    ; Displacement alone represent a direct (uncomputed) offset to the address.
    ; Sometimes it is called an absolute or static address.
    ; Commonly used to access a statically allocated scalar operand.

    mov     [BYTE_VALUE], dl
    mov     bx, [0x12345678]

    ; [2] Base
    ; Base alone represent an indirect offset to the address.
    ; Since the value in the base can change, it can be used for dynamic storage
    ; of variables and data structure.

    mov     eax, [eax]
    mov     ebx, [eax]

    ; [3] Base + Displacement
    ; Base register and displacement can be used together for two distinct purposes:
    ;   - to access a field of a record
    ;   - to access element of array where the size is not 2, 4, or 8 bytes.

    mov     ecx, [ecx + 4]
    mov     dword [edx + 6], 135

    ; [4] (Index * Scale) + Displacement
    ; Offers an efficient way to index into a static array when the element size is
    ; 2, 4, or 8 bytes.

    mov     ecx, [WORD_TABLE + eax*4]
    mov     dword [WORD_TABLE + eax*4], 10

    ; [5] Base + Index + Displacement
    ; Use two registers together supports either a two-dimensional array
    ; (the displacement holds the address of the beginning of the array) or
    ; one of array of records.

    mov     edx, [WORD_TABLE + eax + 4]
    mov     [WORD_TABLE + eax + 4], edx

    ; [6] Base + Index * Scale + Displacement
    ; Using all addressing components for accessing address.

    mov     edx, [WORD_TABLE + eax * 4 + 4]
    mov     [WORD_TABLE + eax * 4 + 4], edx

; RIP Relative Addressing
; In 64-bit mode, a new form of effective addressing is available to make it
; easier to write a Position-Independent Code (PIC). Any memory reference may be
; made RIP relative.

    mov     rax, [rel BYTE_VALUE]
    mov     [rel BYTE_VALUE], rax

    ; And the previous six addressing mode can be expressed as absolute address
    mov     rax, [abs BYTE_VALUE]       ; [abs BYTE_VALUE] is equivalent to [BYTE_VALUE]
    mov     [abs BYTE_VALUE], rax


    hlt         ; Halt the execution
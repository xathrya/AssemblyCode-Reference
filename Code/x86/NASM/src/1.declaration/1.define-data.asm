; define-data.asm
;
; Define initialized data in .data section.
; Data is constant and the size is varying.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o define-data.o define-data.asm
;
;   (win32)
;   $ nasm -f win32 -o define-data.o define-data.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o define-data define-data.o
;
;   (windows)
;   $ ld -m i386pe -o define-data define-data.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;---------------------------------------------------

    global _start

; Define initialized data
; When generating the binary code, NASM will create a stream
; of bytes in the corresponding setion. The value, which defined 
; by user, will be written to the reserve space.
;
; Because the x86 is a little endian processor then the hexpairs
; will be stored in reverse order, from LSB to MSB.
;
; Labelling is not a requirement, but if data is going to be 
; referred then labelling is a must.
;
; Defining data is done by the dX instruction where X is the data type.
;   db = write bytes (8-bit)
;   dw = write words (16-bits)
;   dd = write double words (32-bits)
;   dq = write quad words (64-bits) or double-precision float
;   dt = write 80-bits floating-point constant (extended-precision float)
;
section .data
    ; declare integers
    db    0x55                ; just the byte 0x55
    db    0x55, 0x56, 0x57    ; three bytes in succession
    db    'a', 0x55           ; character constants are OK
    db    'hello',13,10,'$'   ; so are string constants
    dw    0x1234              ; 0x34 0x12
    dw    'a'                 ; 0x61 0x00 (it's just a number)
    dw    'ab'                ; 0x61 0x62 (character constant)
    dw    'abc'               ; 0x61 0x62 0x63 0x00 (string)
    dd    0x12345678          ; 0x78 0x56 0x34 0x12
    dd    1.234567e20         ; floating-point constant
    dq    0x123456789abcdef0  ; eight byte constant

    ; declare floating points
    dq    1.234567e20         ; eight byte as double-precision float
    dt    1.234567e20         ; extended-precision float

; NASM can also write data imported from specified binary data file.
; This instruction is equivalent to using db with content of file.
    incbin  "file.txt"

section .text
_start:
    hlt         ; Halt the execution
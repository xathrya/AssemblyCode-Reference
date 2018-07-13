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
;-----------------------------------------------------------------------------

    global _start

; Define initialized data
;
;   [label:] dX value [;comment]
;
; When generating the binary code, NASM will allocate space for a stream of
; bytes in the corresponding setion. The value, which defined by user, will
; be written to the reserve space.
;
; Because the x86 is a little endian processor then the hexpairs will be stored
; in reverse order, from LSB to MSB.
;
; Labelling is not a requirement, but if data is going to be referred then
; labelling is a must.
;
; Defining data is done by the dX instruction where X is the data type.
;   db = write bytes (8-bit)
;   dw = write words (16-bits)
;   dd = write double words (32-bits)
;   dq = write quad words (64-bits) or double-precision float
;   dt = write ten bytes (80-bits) or extended-precision float

section .data
    ; declare integers
    db    0x55                      ; just the byte 0x55
    db    0x55, 0x56, 0x57          ; three bytes in succession
    db    'a', 0x55                 ; character constants are OK
    db    'hello',13,10,'$'         ; so are string constants
    dw    0x1234                    ; 0x34 0x12
    dw    'a'                       ; 0x61 0x00 (it's just a number)
    dw    'ab'                      ; 0x61 0x62 (character constant)
    dw    'abc'                     ; 0x61 0x62 0x63 0x00 (string)
    dd    0x12345678                ; 0x78 0x56 0x34 0x12
    dd    1.234567e20               ; floating-point constant
    dq    0x123456789abcdef0        ; eight bytes constant
    ; comment it or it might be error in 32-bit
    dt    0x123456789abcdef01234    ; ten bytes constant

    ; declare floating points
    dq    1.234567e20           ; eight byte as double-precision float
    dt    1.234567e20           ; extended-precision float

; NASM can also write data imported from specified binary data file.
; This instruction is equivalent to using db with content of file.

    incbin  "file.txt"

; If the data has repetition, the `times` prefix can be used for 
; indicating that the next data should be replicated for a certain copies.

    buffer1: times 10 db 0xA5   ; buffer1 would have 10 consecutive of 0xA5 (e.g: 0xA5, 0xA5, 0xA5, ...)
    buffer2: times 5 db 1, 2    ; buffer2 would have 5 consecutive of 1 and 2 (e.g: 1, 2, 1, ...)

    ; `times` is so versatile that the argument is not just a numeric constant
    ; but also a numeric expression.
    
    buffer3: db 'Hello NASM'            ; this will ensure a 64 string buffer
             times 64-$+buffer3 db ' '

section .text
_start:
    hlt         ; Halt the execution
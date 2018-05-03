; reserve-space.asm
;
; Reserve space for uninitialized data in .bss section.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o reserve-space.o reserve-space.asm
;
;   (win32)
;   $ nasm -f win32 -o reserve-space.o reserve-space.asm
;
; Linking:
;   $ gcc -m32 -o reserve-space reserve-space.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;---------------------------------------------------

    global _start

; Reserve some space in memory
; 
; When generating the binary code, NASM will create a stream
; of bytes in the corresponding setion. This stream of data is
; unintialized or filled with zeroes.
;
; Labelling is not a requirement, but if data is going to be 
; referred then labelling is a must.
;
; Reserving space is done by the resX instruction where X is the data type.
;   resb = write bytes (8-bit)
;   resw = write words (16-bits)
;   resd = write double words (32-bits)
;   resq = write quad words (64-bits) or double-precision float
;   rest = write 80-bits floating-point constant (extended-precision float)
;
section .bss
    bbuffer:    resb    5       ; reserve 5 bytes space 
    wbuffer:    resw    1       ; reserve a word
    qbuffer:    resd    10      ; array of qword

section .text
_start:
    hlt         ; Halt the execution
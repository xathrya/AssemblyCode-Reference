; signness.asm
;
; Data is a stream of bytes.
; It can represent anything from simple number
; to various user defined data.
; A number can also be viewed as sign or unsign.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o signness.o signness.asm
;
;   (win32)
;   $ nasm -f win32 -o signness.o signness.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o signness signness.o
;
;   (windows)
;   $ ld -m i386pe -o signness signness.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;---------------------------------------------------

    global _start

; Signness is a representation of a number which it is
; capable to encode negative numbers in binary number system.

section .data

; A memory is stream of bytes. It can be filled with sign
; or unsigned value. All we know is data are binary and we
; can not ensure that data is sign or unsigned.
;
; One can argue that a value is a two complements value, but
; it is not always the case.
;
; The negativity of a value can be deduced for some
; obvious values (tend to negative end). But this deduction
; can not be applied universally.

    data1: db    15     ; data1 = 0F
    data2: db   -15     ; data2 = F1
    data3: db  0xF1     ; data3 = F1
    data4: dw  -135     ; data4 = FF 79
    data5: dw 65401     ; data5 = FF 79

; The data2 is a signed number, while data3 is unsigned value.
; In final binary data, both of them have same value, 0xF1.
; This can be verified with hexdump or disassembler.
;
; If we see the source, we might know that the data is declared as
; sign variable. But when we see the binary data, we do not.
;
; The question is, how can you know that the value is a negative number?
; One can not determine it from the byte stream only. It has to be deduced 
; also from the instruction that manipulate the data.

section .text
_start:
    hlt         ; Halt the execution
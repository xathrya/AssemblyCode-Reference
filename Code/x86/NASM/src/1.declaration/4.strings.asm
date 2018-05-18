; strings.asm
;
; More about string declaration.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o strings.o strings.asm
;
;   (win32)
;   $ nasm -f win32 -o strings.o strings.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o strings strings.o
;
;   (windows)
;   $ ld -m i386pe -o strings strings.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;---------------------------------------------------

    global _start

; String is a array of characters.
; Character is a representational byte.
; A string can be defined in various combinations

section .data
; [1] String constant
; Like a character constant, but longer.
    db 'Hello'                  ; string constant
    db 'H', 'e', 'l', 'l', 'o'  ; equivalent character constant

    dd 'ninechars'              ; doubleword string constant
    dd 'nine', 'char', 's'      ; becomes three doublewords
    db 'ninechars', 0, 0, 0     ; similar with two others.

; [2] Unicode string 
; Special operators exist to allow definition of unicode strings.
;   __utf16__       __utf16le__         __utf16be__
;   __utf32__       __utf32le__         __utf32be__
;
; They take a string in UTF-8 format and converts it to UTF-16 or UTF-32
; Respectively, unless the forms specified, the output is little endian.
    dw __utf16__('C:\WINDOWS'), 0       ; pathname in UTF-16
    dd __utf32__('A + B = \u206a'), 0   ; string in UTF-32

section .text
_start:
    hlt         ; Halt the execution
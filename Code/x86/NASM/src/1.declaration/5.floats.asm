; floats.asm
;
; More about floating-point declaration.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o floats.o floats.asm
;
;   (win32)
;   $ nasm -f win32 -o floats.o floats.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o floats floats.o
;
;   (windows)
;   $ ld -m i386pe -o floats floats.o
;
; This code snippet is for examples to topics
; and should not be run as an executable.
; 
;---------------------------------------------------

    global _start

; Floating point constants are acceptable only as arguments to
;   DB, DW, DD, DQ, DT, and D0

; or as arguments to the special operators
;   __float8__,    __float16__,  __float32__, 
;   __float64__,   __float80m__, __float80e__,
;   __float128l__, __float128h__

; Floating point constants are expressed in the traditional form:
;   digit, period, optonally more digits, E, exponent

; The period is mandatory.
; Underscores to break up groups of digits are permitted.

section .data
    db    -0.2                    ; "Quarter precision" 
    dw    -0.5                    ; IEEE 754r/SSE5 half precision 
    dd    1.2                     ; an easy one 
    dd    1.222_222_222           ; underscores are permitted 
    dd    0x1p+2                  ; 1.0x2^2 = 4.0 
    dq    0x1p+32                 ; 1.0x2^32 = 4 294 967 296.0 
    dq    1.e10                   ; 10 000 000 000.0 
    dq    1.e+10                  ; synonymous with 1.e10 
    dq    1.e-10                  ; 0.000 000 000 1 
    dt    3.141592653589793238462 ; pi 
    do    1.e+4000                ; IEEE 754r quad precision

section .text
_start:

; A special operators are used to produce floating-point numbers in
; other contexts. They produce the binary representations of
; a specific floating numbers as an integer and can use anywhere
; integer constants are used in an expression.

    mov     eax, __float32__(3.141592653589793238462)

    ; will become

    mov     eax, 0x40490fdb

; As of IEEE754 specification, special tokens of infinity and NaN
; representation also exists.
;   __Infinity__        floating point number infinity value
;   __QNaN__, __NaN__   quiet NaN
;   __SNaN__            signaling NaN   

    hlt         ; Halt the execution
; jump.asm
;
; Jumps and program flow redirection.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o jump.o jump.asm
;
;   (win32)
;   $ nasm -f win32 -o jump.o jump.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o jump jump.o
;
;   (windows)
;   $ ld -m i386pe -o jump jump.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start

; Jumping is a redirection of execution flow to other address.
; The address can be a label or the value inside a register.

; There are two jumps available: unconditional jump and conditional jump

; The unconditional jump is a jump where it will force execution to redirect
; to certain memory, whatever the state or condition of CPU.

; The conditional jump is a jump where it would only happen when 
; certain condition met. The condition is seen from status register.
; See the `platform.md` for extra information about status register.

; it is common to do an instruction such as `cmp` or `test` to affect the status
; register before doing a conditional jump.

section .data


section .text
_start:

; JMP (unconditional jump)
    ; jump to a label immediately
    jmp     .target

; conditional jump
; signed
; JE  (jump if equal)
    ; jump if the status ZF is set
    je      .target

; JNE (jump if not equal) 
    ; jump if the status ZF is clear
    jne     .target

; JG  (jump if greater)
    ; jump if the status ~(SF^OF) & ~ZF met
    jg      .target 
    jnle    .target    ; equivalent to jg   

; JGE (jump if greater or equal)
    ; jump if the status ~(SF^OF) met
    jge     .target 
    jnl     .target     ; equivalent to jge

; JL  (jump if lower)
    ; jump if the status SF^OF
    jl      .target
    jnge    .target    ; equivalent to jl

; JLE (jump if lower or equal)
    ; jump if the status (SF^OF) | ZF
    jle     .target
    jng     .target     ; equivalent to jle

; JS (jump if negative)
    ; jump if the status SF is set
    js      .target 

; JNS (jump is nonnegative)
    ; jump if the status SF is clear
    jns     .target


; unsigned
; JZ  (jump if zero)
    ; jump if the status ZF is set
    jz      .target     ; equivalent to je

; JNZ (jump if not zero)
    ; jump if the status ZF is clear
    jnz     .target     ; equivalent to jne

; JE  (jump if above)
    ; jump if the status ~CF & ~ZF met
    ja      .target
    jnbe    .target    ; equivalent to ja

; JAE (jump if above or equal)
    ; jump if the status CF is clear
    jae     .target
    jnb     .target    ; equivalent to jae

; JB  (jump if below)
    ; jump if the status CF is set
    jb      .target
    jnae    .target    ; equivalent to jb

; JBE (jump if below or equal)
    ; jump if the status CF | ZF met
    jbe     .target 
    jna     .target    ; equivalent to jbe

.target:

    hlt         ; Halt the execution
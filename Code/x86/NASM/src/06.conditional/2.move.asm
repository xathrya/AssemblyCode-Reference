; move.asm
;
; Conditional move instructions
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o move.o move.asm
;
;   (win32)
;   $ nasm -f win32 -o move.o move.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o move move.o
;
;   (windows)
;   $ ld -m i386pe -o move move.o
; 
;-----------------------------------------------------------------------------

    global _start

; Conditional move instructions is a data movement instructions that has similar
; effect to common move instructions. The only difference is the conditional move
; will takes effect where the condition is met.

; The source and destination operands must have the same size.

section .data


section .text
_start:

; signed
; CMOVE  (move if equal)
    ; move if the status ZF is set
    cmove   eax, ebx

; CMOVNE (move if not equal) 
    ; move if the status ZF is clear
    cmovne  eax, ebx

; CMOVG  (move if greater)
    ; move if the status ~(SF^OF) & ~ZF met
    cmovg   eax, ebx 
    cmovnle eax, ebx    ; equivalent to cmovg   

; CMOVGE (move if greater or equal)
    ; move if the status ~(SF^OF) met
    cmovge  eax, ebx 
    cmovnl  eax, ebx     ; equivalent to cmovge

; CMOVL  (move if lower)
    ; move if the status SF^OF
    cmovl   eax, ebx
    cmovnge eax, ebx    ; equivalent to cmovl

; CMOVLE (move if lower or equal)
    ; move if the status (SF^OF) | ZF
    cmovle  eax, ebx
    cmovng  eax, ebx     ; equivalent to cmovle

; CMOVS (move if negative)
    ; move if the status SF is set
    cmovs   eax, ebx 

; CMOVNS (move is nonnegative)
    ; move if the status SF is clear
    cmovns  eax, ebx


; unsigned
; CMOVZ  (move if zero)
    ; move if the status ZF is set
    cmovz   eax, ebx     ; equivalent to cmove

; CMOVNZ (move if not zero)
    ; move if the status ZF is clear
    cmovnz  eax, ebx     ; equivalent to cmovne

; CMOVA  (move if above)
    ; move if the status ~CF & ~ZF met
    cmova   eax, ebx
    cmovnbe eax, ebx    ; equivalent to cmova

; CMOVAE (move if above or equal)
    ; move if the status CF is clear
    cmovae  eax, ebx
    cmovnb  eax, ebx    ; equivalent to cmovae

; CMOVB  (move if below)
    ; move if the status CF is set
    cmovb   eax, ebx
    cmovnae eax, ebx    ; equivalent to cmovb

; CMOVBE (move if below or equal)
    ; move if the status CF | ZF met
    cmovbe  eax, ebx 
    cmovna  eax, ebx    ; equivalent to cmovbe

    hlt         ; Halt the execution
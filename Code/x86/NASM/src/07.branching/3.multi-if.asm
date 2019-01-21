; multi-if.asm
;
; Multiple branching options each having a simple condition.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o multi-if.o multi-if.asm
;
;   (win32)
;   $ nasm -f win32 -o multi-if.o multi-if.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o multi-if multi-if.o
;
;   (windows)
;   $ ld -m i386pe -o multi-if multi-if.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start
 
; Branching is an act of switching execution to a different instruction sequence
; as result of executing a branch instruction, thus deviate from its default
; behavior of executing instruction in order.
; 
; Branch instruction can be either an unconditional branch (always result in branching)
; or conditional branch (may or may not result in branching). This basic block
; then make up to various control flow in higher programming language.
; for a more detail on conditional instructions, see topic "Conditional"
;
; The goal:
;   implement "multi-if" statement.
;   Multiple branching options each having a simple condition. Each branching will
;   redirect to a set of instruction if certain condition met.
;

section .data
    var  dd 0
    var2 dd 0

section .text

_start:

; If the conditions are produced from the same expression, then 
; a series of jump instruction will be written together after the compare

    mov     eax, dword [var]    ; move value into eax

    ; condition checking
    cmp     eax, 0              ; based on the value of var

    ; jump when negated condition is met
    jg      .greater            ; jump when eax is bigger
    jl      .less               ; jump when eax is smaller

    ; execute the do_action because the condition are met.
    mov     dword [var], 0
    jmp     .end                 ; avoid executing the "next" block

.greater:
    mov     dword [var], 1 
    jmp     .end                 ; avoid executing the "next" block

.less:
    mov     dword [var], 2 

.end:
    ; this instructions will be executed whether the branching success or not.

;-----------------------------------------------------------------------------

; If the conditions are produced from the different expressions, then
; multiple check is generated in and chained together.

; Generic Form (3 cases):
;     if (condition_1) then
;         do_action_1
;     else if (condition_2)
;         do_action_2
;     else
;         do_alternative_action
;
; Equivalent:
;     if not (condition_1) then goto check_2;
;         do_action_1;
;         goto end;
;     check_2:
;     if not (condition_2) then goto else;
;         do_action_2;
;         goto end;
;     else:
;         do_alternative_action
;     end:

    ; if (var == 0)
    ;     var = 1;
    ; else if (var2 == 0)
    ;     var2 = 1;
    ; else 
    ;     var1 = var2 = 0;

    mov     eax, dword [var]    ; move value into eax

    ; condition checking on condition_1
    cmp     eax, 0              ; if (var == 0)

    ; jump when negated condition is met
    jne     .check2             ; jump when eax is not zero

    ; execute the do_action_1 because the condition are met.
    mov     dword [var], 1
    jmp     .finish             ; avoid executing the "next" block

.check2:
    mov     ebx, dword [var2]   ; move value into ebx

    ; condition checking on condition_2
    cmp     ebx, 0              ; else if (var1 == 0)

    ; jump when negated condition is met
    jne     .else               ; avoid executing the "next" block

    ; execute the do_action_2 because the condition are met.
    mov     dword [var], 1 
    jmp     .finish             ; avoid executing the "next" block

.else:
    ; execute the do_alternative_action because the condition are not met.
    mov     dword [var], 0
    mov     dword [var2], 0

.end:
    ; this instructions will be executed whether the branching success or not.


    hlt         ; Halt the execution

; jump-table.asm
;
; A branching to multiple alternative condition and implications.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o jump-table.o jump-table.asm
;
;   (win32)
;   $ nasm -f win32 -o jump-table.o jump-table.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o jump-table jump-table.o
;
;   (windows)
;   $ ld -m i386pe -o jump-table jump-table.o
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
;   implement "jump-table" statement or in some programming language known as "switch".
;   Branching which have multiple alternative conditions and implications. A jump table
;   is used to determine the target block of instruction.
;
; Generic Form:
;     switch (variable)
;     {
;         case 1: do_action_1; break;
;         case 2: do_action_2; break;
;         ...
;         default: do_alternative_action;
;     }
;
;
;     switch:  test a variable
;     case:    create label that execution will switch to, depending on the value of the variable
;     break:   jumps to the end of switch block.
;     default: a general / alternative action when no other value satisfies.
;
; Equivalent:
;     - at every break statement is equivalent to a unconditional jump to end of switch structure
;     

section .data
    var  dd 0

section .text

_start:

; One Layer Jump-Table

    ; if (var == 0)
    ; {
    ;     var = 1
    ; }
    ; else
    ; {
    ;     var = 2;    
    ; }
    
    ; Code checks the condition and performs a jump only if the condition is false
    ; (negated condition is met).
    ; This is efficient implementation as we only need one jump to implement.

    mov     eax, dword [var]    ; move value into eax

    ; condition checking
    cmp     eax, 0              ; if (var == 0)

    ; jump when negated condition is met
    jne     .else               ; jump when it's not zero

    ; execute the do_action because the condition are met.
    mov     dword [var], eax    ; execute the implication action.
    jmp     end                 ; avoid executing the "else" block

.else:
    ; execute the do_alternative_action because the condition are not met.
    mov     dword [var], eax 

.end:
    ; this instructions will be executed whether the branching success or not.


    hlt         ; Halt the execution

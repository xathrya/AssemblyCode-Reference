; if.asm
;
; A branching with single condition checking and implication.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o if.o if.asm
;
;   (win32)
;   $ nasm -f win32 -o if.o if.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o if if.o
;
;   (windows)
;   $ ld -m i386pe -o if if.o
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
;   implement "if-then" statement.
;   Simple branching which redirect to set of instructions if certain condition met.
;
; Generic Form:
;     if (condition) then
;         do_action
;
; Equivalent:
;     if not (condition) then goto end;
;         do_action;
;     end:

section .data
    var  dd 0

section .text

_start:

    ; if (var == 0)
    ; {
    ;     var = 1
    ; }
    
    ; Code checks the condition and performs a jump only if the condition is false
    ; (negated condition is met).
    ; This is efficient implementation as we only need one jump to implement.

    mov     eax, dword [var]    ; move value into eax

    ; condition checking 
    cmp     eax, 0              ; compare the eax with 0

    ; jump when negated condition is met
    jne     .end                ; jump when it's not zero

    ; execute the do_action because the condition are met.
    mov     dword [var], eax    ; execute the implication action.

.end:
    ; this instructions will be executed whether the branching success or not.


    hlt         ; Halt the execution

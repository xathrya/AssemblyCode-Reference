; complex-condition.asm
;
; A branching with multiple condition checking.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o complex-condition.o complex-condition.asm
;
;   (win32)
;   $ nasm -f win32 -o complex-condition.o complex-condition.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o complex-condition complex-condition.o
;
;   (windows)
;   $ ld -m i386pe -o complex-condition complex-condition.o
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
;   Branching with complex condition checking which execute a set of instructions
;   if the condition met. The complex condition is a combination of simple condition.
;
; Generic Form:
;     if (complex_condition) then
;         do_action
;
;     Case of complex_condition:
;         - condition1 AND condition2
;         - condition1 OR condition2
;
; Equivalent:
;     if not (complex_condition) then goto end;
;         do_action;
;     end:

section .data
    var1  dd 0
    var2  dd 0

section .text

_start:

; It should be noted that a complex condition is nothing more than combination of
; several simple condition. Therefore we need to carefully break the conditions
; and identify it's simple condition.


;-----------------------------------------------------------------------------
; condition1 AND condition2

; This type of expression will be evaluated to True if both of them are true.
; Therefore, when evaluated each condition from left to right, if there is any
; condition evaluated to False, the implication won't be executed.

    ; if (var1 > 0 && va1 > 10)
    ; {
    ;     var1 = 10
    ; }

    mov     eax, dword [var1]   ; move value var1 into eax
    mov     ebx, dword [var2]   ; move value var2 into ebx

    ; condition checking
    cmp     eax, 0
    jle     .fail_1             ; if var1 is less than or equal 0,
                                ; the complex condition will be evaluated as false
    
    cmp     ebx, 10
    jle     .fail_1             ; if var2 is less than or equal 10,
                                ; the complex condition will be evaluated as false

    ; execute the do_action because the condition are met.
    mov     dword [var1], 10    ; execute the implication action.

.fail_1:
    ; this instructions will be executed whether the branching success or not.

;-----------------------------------------------------------------------------

; condition1 OR condition2

; This type of expression will be evaluated to True if any of them are true.
; Therefore, when evaluated each condition from left to right, if there is any
; condition evaluated to True, the implication will be be executed.

    ; if (var1 > 0 || va1 > 10)
    ; {
    ;     var1 = 10
    ; }

    mov     eax, dword [var1]   ; move value var1 into eax
    mov     ebx, dword [var2]   ; move value var2 into ebx

    ; condition checking
    cmp     eax, 0
    jg      .success            ; if var1 is greater than 0,
                                ; the complex condition will be evaluated as true
    
    cmp     ebx, 10
    jle     .fail_2             ; if var2 is less than or equal 10,
                                ; the complex condition will be evaluated as false
    
.success: 
    ; at this point, any of conditions above are met.
    mov     dword [var1], 10    ; execute the implication action.

.fail_2:
    ; this instructions will be executed whether the branching success or not.


    hlt         ; Halt the execution

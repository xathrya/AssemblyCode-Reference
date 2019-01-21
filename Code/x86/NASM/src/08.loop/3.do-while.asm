; do-while.asm
;
; Simple instruction repetition.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o do-while.o do-while.asm
;
;   (win32)
;   $ nasm -f win32 -o do-while.o do-while.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o do-while do-while.o
;
;   (windows)
;   $ ld -m i386pe -o do-while do-while.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start

; Loop is a sequence of statements which is specified once but which may be carried
; out several times in succession under certain condition evaluated in runtime.
;
; In x86, loop can be defined by three different mechanism:
;   - REP (and its derivative) instruction
;   - LOOP (and its derivative) instruction
;   - Branching instruction.
;
; do-while loop is a simplest construction where the set of instructions is executed
; at least once.
;
; General structure:
;   do
;   {
;       action;
;   } while (condition);

section .data
    var     dd  0
    

section .text

_start:

    ; do
    ; {
    ;     x ++;
    ; } while (x != 10);
    ;
    ; The loop body is executed, the condition is tested at the end of the loop and the loop
    ; jumps back to the beginning of the loop if the condition is satisfied.
    
    mov     eax, dword [var]

loop_body:                      ; set of instructions start here
    inc     eax 

    ; In some case, there are some instruction that can change the condition.
    ; For example, change the counter, change the treshold,e tc.

    ; A conditional jump, checking whether we need to continue the loop or not
    cmp     eax, 10
    jne     loop_body           ; loop if the condition is not satisfied.

    ; outside of loop
    mov     dword [var], eax 

    
    hlt         ; Halt the execution
; while.asm
;
; Simple instruction repetition.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o while.o while.asm
;
;   (win32)
;   $ nasm -f win32 -o while.o while.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o while while.o
;
;   (windows)
;   $ ld -m i386pe -o while while.o
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
; In high level language, while is similar to do-while loop but the condition is tested
; first before determining whether the loop_body si executed or not.
;
; General structure:
;   while (condition)
;   {
;       action;
;   }

section .data
    var     dd  0
    

section .text

_start:

    ; while (x <= 10)
    ; {
    ;     x ++;
    ; } 
    ;
    ; It looks simple but it require more condition checking to construct the loop.
    ; The first is conditional jump to execute the block or skip it.
    ; The second is conditional jump to execute the body_loop or not. 
    
    mov     eax, dword [var]

    ; A conditional jump, checking whether we need to execute or skip it.
    cmp     eax, 10
    jg      loop_end

loop_body:                      ; set of instructions start here
    inc     eax 

    ; In some case, there are some instruction that can change the condition.
    ; For example, change the counter, change the treshold,e tc.

    ; A conditional jump, checking whether we need to continue the loop or not
    cmp     eax, 1
    jle     loop_body           ; back to loop_body if the conditions is satisfied

loop_end:
    ; outside of loop
    mov     dword [var], eax 

    
    hlt         ; Halt the execution
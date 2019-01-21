; for.asm
;
; Simple instruction repetition.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o for.o for.asm
;
;   (win32)
;   $ nasm -f win32 -o for.o for.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o for for.o
;
;   (windows)
;   $ ld -m i386pe -o for for.o
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
; In high level language, for is a countable loop where the set of instructions is
; execution for a number of times. Other than implemented using LOOP instructions,
; For can also be implemented using jumps. 
;
; General structure:
;   for (initialization; condition; counter_increment)
;   {
;       actions;
;   } 

section .bss
    arrd    resd  10
    

section .text

_start:

    ; for (i = 0; i < 10; i++)
    ; {
    ;     arrd[i] = x;
    ; } 
    ;
    ; We break the loop structure into four sections:
    ;   - initialization
    ;   - condition checking
    ;   - counter increment
    ;   - loop body
    ; 
    ; to be something like this:
    ;
    ;   initialization;
    ;   while (condition)
    ;   {
    ;       action;
    ;       counter increment;   
    ;   }
    
    mov     edi, arrd

    ; Initialization segment
    mov     eax, 0              ; i = 0

    ; A conditional jump, checking whether we need to execute or skip it.
    cmp     eax, 10
    jg      loop_end

loop_body:                      ; set of instructions start here
    ; action
    mov     dword [edi], eax    ; move the content of eax do [EDI]

    ; counter increment 
    inc     eax 
    add     edi, 4              ; point to the next element of EDI

    ; A conditional jump, checking whether we need to continue the loop or not
    cmp     eax, 10
    jl      loop_body           ; back to loop_body if the conditions is satisfied
    
loop_end:

    
    hlt         ; Halt the execution
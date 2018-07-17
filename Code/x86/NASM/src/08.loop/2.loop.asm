; loop.asm
;
; Simple instruction repetition.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o loop.o loop.asm
;
;   (win32)
;   $ nasm -f win32 -o loop.o loop.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o loop loop.o
;
;   (windows)
;   $ ld -m i386pe -o loop loop.o
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
; LOOP (and its derivative) is a block-level repetition.
; loop a set of instructions to the number of times specified in the
; count register ECX or until indicated condition of the ZF flag is no longer met.
;
; The LOOP family has several instruction:
;   - LOOP   (loop)
;   - LOOPE  (loop while equal)
;   - LOOPNE (loop while not equal)
;   - LOOPZ  (loop while zero)
;   - LOOPNZ (loop while not zero)
;
; LOOP need a label which will be a destination jump.

section .bss 
    dstd    resd 5  
    

section .text

_start:

; LOOP (loop while equal)
    ; loop the following instruction until ECX is 0.

    ; fill an array
    mov     ecx, 5              ; counter ECX
    mov     edi, dstd           ; destination
    mov     eax, 0
    mov     ebx, 0
loop_label:
    stosd  
    inc     ebx 
    add     eax, ebx 
    loop    loop_label          ; loop

    ; dstd = 0, 1, 3, 6, 10


; LOOPE (loop while equal)
; LOOPZ (loop while zero)
    ; loop the following instruction until ECX is 0 or ZF = 0

    ; find nonmatching dword in [EDI] and [ESI]
    mov     ecx, 5              ; counter ECX
    mov     edi, dstd           ; destination
loope_label:
    loope   loope_label         ; loop


; LOOPNE (loop while not equal)
; LOOPNZ (loop while not zero)
    ; loop the following instruction until ECX is 0 or ZF = 1

    ; find matching dword in [EDI] and [ESI]
    mov     ecx, 5              ; counter ECX
    mov     edi, dstd           ; destination
loopnz_label:
    loopnz  loopnz_label        ; loop

    
    hlt         ; Halt the execution
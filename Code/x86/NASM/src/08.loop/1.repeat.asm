; repeat.asm
;
; Simple instruction repetition.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o repeat.o repeat.asm
;
;   (win32)
;   $ nasm -f win32 -o repeat.o repeat.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o repeat repeat.o
;
;   (windows)
;   $ ld -m i386pe -o repeat repeat.o
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
; REP (and its derivative) is a instruction-level repetition.
; Repeat a single string-instruction to the number of times specified in the
; count register ECX or until indicated condition of the ZF flag is no longer met.
;
; The REP family has several instruction:
;   - REP   (repeat)
;   - REPE  (repeat while equal)
;   - REPNE (repeat while not equal)
;   - REPZ  (repeat while zero)
;   - REPNZ (repeat while not zero)

section .bss 
    dstd    resd 5  

section .data
    srcd    dd  1, 2 ,3 ,4, 5
    

section .text

_start:

; REP (repeat while equal)
    ; Repeat the following instruction until ECX is 0.

    ; move data from [ESI] to [EDI]
    mov     ecx, 5                      ; counter ECX
    mov     edi, dstd                   ; destination
    mov     esi, srcd                   ; source
    rep     movsd                       ; repeat

    ; dstd = 1, 2, 3, 4, 5
    ; srcd = 1, 2, 3, 4, 5

    ; move data from EAX do [EDI]
    mov     ecx, 2                      ; counter ECX
    mov     edi, dstd 
    add     edi, 8                      ; destination (index 2 of dstd)
    mov     eax, 0                      ; source
    rep     stosd                       ; repeat

    ; dstd = 1, 2, 0, 0, 5
    ; srcd = 1, 2, 3, 4, 5


; REPE (repeat while equal)
; REPZ (repeat while zero)
    ; Repeat the following instruction until ECX is 0 or ZF = 0

    ; find nonmatching dword in [EDI] and [ESI]
    mov     ecx, 5                      ; counter ECX
    mov     edi, dstd                   ; destination
    mov     esi, srcd                   ; source
    repe    cmpsd                       ; repeat, stop on dstd[2]


; REPNE (repeat while not equal)
; REPNZ (repeat while not zero)
    ; Repeat the following instruction until ECX is 0 or ZF = 1

    ; find matching dword in [EDI] and [ESI]
    mov     ecx, 3                      ; counter ECX
    mov     edi, dstd 
    add     edi, 8                      ; destination (index 2 of dstd)
    mov     esi, srcd                   ; source
    repnz   cmpsd                       ; repeat, stop on dstd[4]

    
    hlt         ; Halt the execution
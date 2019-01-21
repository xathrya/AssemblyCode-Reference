; data-movement.asm
;
; Special registers SIMD operations.
; Move data from and to memory.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o data-movement.o data-movement.asm
;
;   (win32)
;   $ nasm -f win32 -o data-movement.o data-movement.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o data-movement data-movement.o
;
;   (windows)
;   $ ld -m i386pe -o data-movement data-movement.o
;
; Run in debugging environment / emulator
; 
;-----------------------------------------------------------------------------

; There are 8 64-bit MMX registers.
;   MM0, MM1, MM2, MM3, MM4, MM5, MM6, MM7

    global _start

section .data 
    dblock  dd 0xCAFE, 0xBABE
    qblock  dq 0xCAFEBABE, 0x13510030


section .text 
_start:
    mov         eax, dword [dblock]
    mov         ebx, dword [dblock]

; Moving
; possible data movement would be:
;   - MMX registers              ->   MMX registers
;   - general-purpose registers  ->   MMX registers
;   - MMX registers              ->   general-purpose registers
;   - memory                     ->   MMX registers
;   - MMX registers              ->   memory
;
; There is no instruction for moving immediate value to MMX registers. The available
; option is to move it to temporary area (memory / general purpose registers)
; then move it to MMX registers.

    ; movd      mm, r/m32
    movd        mm0, eax
    movd        mm0, dword [dblock]
    ; movd      r/m32, mm
    movd        ebx, mm0  
    movd        dword [dblock], mm0 

    ; movq      mm, mm/r/m64
    movq        mm1, mm0 
    movq        mm1, rax    ; not supported in 32-bit CPU
    movq        mm1, qword [qblock]
    ; movq      r/m64, mm
    movq        rbx, mm1    ; not supported in 32-bit CPU
    movq        qword [qblock], mm0 


; Pack
; packs 128-bits of words or double-words into 64-bits by removing the top half of
; each unit with signed or unsigned saturation

    ; packssdw  mm1, mm2/m64
    ; pack double-words to words (signed with saturation)
    packssdw    mm1, mm0
    packssdw    mm1, qword [qblock]

    ; packssdb  mm1, mm2/m64
    ; pack words to byte (signed with saturation)
    packsswb    mm1, mm0 
    packsswb    mm1, qword [qblock]

    ; packuswb  mm1, mm2/m64
    ; pack words to byte (unsigned with saturation)
    packuswb    mm1, mm0
    packuswb    mm1, qword [qblock] 


; Unpack
; unpacks 64-bits into 128-bits of words or double-words to either top-half or
; lower-half of target registers

    ; punpckhbw mm, mm/m64
    ; unpack and interleave high-order bytes
    punpckhbw   mm1, mm0
    punpckhbw   mm1, qword [qblock] 
    
    ; punpckhwd mm, mm/m64
    ; unpack and interleave high-order words
    punpckhwd   mm1, mm0
    punpckhwd   mm1, qword [qblock] 
    
    ; punpckhdq mm, m/m64
    ; unpack and interleave high-order double-words
    punpckhdq   mm1, mm0    
    punpckhdq   mm1, qword [qblock] 
    
    ; punpcklbw mm, mm/m32
    ; unpack and interleave low-order bytes
    punpcklbw   mm1, mm0
    punpcklbw   mm1, qword [qblock] 
    
    ; punpcklwd mm, mm/m32
    ; unpack and interleave low-order words
    punpcklwd   mm1, mm0
    punpcklwd   mm1, qword [qblock] 
    
    ; punpckldq mm, mm/m32
    ; unpack and interleave low-order double-words
    punpckldq   mm1, mm0
    punpckldq   mm1, qword [qblock] 


; Insertion
; insert at specified location in group
    pinsrw      mm0, 
    pinsrq      mm0, 

; Clear MMX
    emms        ; clear / empty the MMX state.
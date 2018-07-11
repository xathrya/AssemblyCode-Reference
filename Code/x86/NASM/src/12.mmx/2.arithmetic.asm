; arithmetic.asm
;
; Special registers SIMD operations.
; Move data from and to memory.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o arithmetic.o arithmetic.asm
;
;   (win32)
;   $ nasm -f win32 -o arithmetic.o arithmetic.asm
;
; Linking:
;   (linux)
;   $ ld -m elf_i386 -o arithmetic arithmetic.o
;
;   (windows)
;   $ ld -m i386pe -o arithmetic arithmetic.o
;
; Run in debugging environment / emulator
; 
;------------------------------------------------------------------------------------------------------

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

; addition
    ; paddx     mm, mm/m64
    ; add packed integers
    paddb       mm0, mm1                ; 8-bit / byte
    paddb       mm0, qword [qblock]
    paddw       mm0, mm1                ; 16-bit / word
    paddw       mm0, qword [qblock]
    paddd       mm0, mm1                ; 32-bit / double word
    paddd       mm0, qword [qblock]
    paddq       mm0, mm1                ; 64-bit / quad word
    paddq       mm0, qword [qblock]

    ; paddsx    mm, mm/m64
    ; add packed signed integers and saturate
    paddsb      mm0, mm1                ; 8-bit / byte
    paddsb      mm0, qword [qblock]
    paddsw      mm0, mm1                ; 16-bit / word
    paddsw      mm0, qword [qblock]

    ; paddusx   mm, mm/mem64
    ; add packed unsigned integers and saturate
    paddusb     mm0, mm1                ; 8-bit / byte
    paddusb     mm0, qword [qblock]
    paddusw     mm0, mm1                ; 16-bit / word
    paddusw     mm0, qword [qblock]


; subtraction
    ; psubx     mm, mm/m64
    ; sub packed integers
    psubb       mm0, mm1                ; 8-bit / byte
    psubb       mm0, qword [qblock]
    psubw       mm0, mm1                ; 16-bit / word
    psubw       mm0, qword [qblock]
    psubd       mm0, mm1                ; 32-bit / double word
    psubd       mm0, qword [qblock]
    psubq       mm0, mm1                ; 64-bit / quad word
    psubq       mm0, qword [qblock]

    ; psubsx    mm, mm/m64
    ; sub packed signed integers and saturate
    psubsb      mm0, mm1                ; 8-bit / byte
    psubsb      mm0, qword [qblock]
    psubsw      mm0, mm1                ; 16-bit / word
    psubsw      mm0, qword [qblock]

    ; psubusx   mm, mm
    ; sub packed unsigned integers and saturate
    psubusb     mm0, mm1                ; 8-bit / byte
    psubusb     mm0, qword [qblock]
    psubusw     mm0, mm1                ; 16-bit / word
    psubusw     mm0, qword [qblock]


; multiplication
    ; pmadwd    mm, mm/m64
    ; multiply packed words, add adjacent doublewords result
    pmaddwd     mm1, mm0 
    pmaddwd     mm1, qword [qblock] 

    ; pmulhw    mm, mm/m64
    ; multiply packed signed words integers, store high 16-bits
    ; of result
    pmulhw      mm1, mm0 
    pmulhw      mm1, qword [qblock] 

    ; pmullw    mm, mm/m64
    ; multiply packed signed words integers, store low 16-bits
    ; of result
    pmullw      mm1, mm0 
    pmullw      mm1, qword [qblock] 


    hlt         ; Halt the execution
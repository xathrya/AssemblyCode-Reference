; recursion.asm
;
; Recursive call of a function.
;
; Compile:
;   (linux)
;   $ nasm -f elf32 -o recursion.o recursion.asm
;
;   (win32)
;   $ nasm -f win32 -o recursion.o recursion.asm
;
; Linking:
;   $ gcc -m32 -o recursion recursion.o
;
; Run in debuggin environment / emulator
; 
;-----------------------------------------------------------------------------

    global _start

; Recursion is a method of problem solving where the solution depends on solutions
; to smaller instance of the same problem (as opposed to iteration). 

; Based on this, a recursive function is a function that calls itself during its
; execution. This enables the function to repeat itself several times, forming a cycle.

; A recursive function has:
;   - one or more base cases, and
;   - one or more recursive cases.
;
; The base cases means condition where the recursion stop and input are used to produce
; result trivially without recurring. While recursive cases are condition where input
; are broken down to smaller part and solved by the function itself.


section .data


section .text
_start:
    push    5
    call    func_recursion
    
    pop     edx

    hlt     ; Halt the execution


;-----------------------------------------------------------------------------

; Declare a recursive function.
;
; func_recursion(X)
;   => 0                                , if X <= 0
;   => X + func_recursion(X - 1)        , if X > 0 
;
func_recursion:

    ; function prologue
    push    ebp 
    mov     ebp, esp

    ; base-case,        if X <= 0
    mov     edx, dword [ebp + 8]    ; arg1
    cmp     edx, 0
    jg      .recurrence
    mov     eax, 0
    jmp     .result

    ; recurrence case,  if X > 0
.recurrence:
    dec     edx                     ; X - 1
    push    edx 
    call    func_recursion          ; func_recursion(X - 1)

    pop     edx
    add     eax, dword [ebp + 8]    ; X + func_recursion(X - 1)

.result: 
    ; function prologue
    pop     ebp
    ret 

    
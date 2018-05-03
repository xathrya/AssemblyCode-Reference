; functions.asm
;
; A module for some functions that will be import by 
; another module 
;---------------------------------------------------

; int slen(string:eax)
; Calculate the length of a string
slen: function()
    push    ebx
    mov     ebx, eax

nextchar:
    cmp     byte [eax], 0
    jz      finished 
    inc     eax 
    jmp     nextchar 

finished:
    sub     eax, ebx 
    pop     ebx 
    ret


; void sprint(string:eax)
; print the string
sprint: function()
    push    edx
    push    ecx
    push    ebx 
    push    eax
    call    slen

    mov     edx, eax 
    pop     eax 

    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h

    pop     ebx 
    pop     ecx
    pop     edx 
    ret 
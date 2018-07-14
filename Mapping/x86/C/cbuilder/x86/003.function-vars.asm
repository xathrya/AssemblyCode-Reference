	.386p
	ifdef ??version
	if ??version GT 500H
	.mmx
	endif
	endif
	model flat
	ifndef	??version
	?debug	macro
	endm
	endif
	?debug	S "src/003.function-vars.c"
	?debug	T "src/003.function-vars.c"
_TEXT	segment dword public use32 'CODE'
_TEXT	ends
_DATA	segment dword public use32 'DATA'
_DATA	ends
_BSS	segment dword public use32 'BSS'
_BSS	ends
DGROUP	group	_BSS,_DATA
_TEXT	segment dword public use32 'CODE'
_f	proc	near
?live1@0:
 ;	
 ;	void f()
 ;	
	push      ebp
	mov       ebp,esp
	push      ecx
 ;	
 ;	{
 ;	    char    c = 1;
 ;	    int     i = 2;
 ;	    float   f = 3.0;
 ;	
 ;	
 ;	}
 ;	
@1:
@3:
	pop       ecx
	pop       ebp
	ret 
	align 4        
@2:
	db	0,0,64,64
_f	endp
_TEXT	ends
	public	_f
	?debug	D "src/003.function-vars.c" 19692 18833
	end

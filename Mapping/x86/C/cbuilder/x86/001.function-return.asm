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
	?debug	S "src/001.function-return.c"
	?debug	T "src/001.function-return.c"
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
 ;	int f()
 ;	
	push      ebp
	mov       ebp,esp
 ;	
 ;	{
 ;	    return 135;
 ;	
@1:
	mov       eax,135
 ;	
 ;	}
 ;	
@3:
@2:
	pop       ebp
	ret 
_f	endp
_TEXT	ends
	public	_f
	?debug	D "src/001.function-return.c" 19692 18542
	end

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
	?debug	S "src/000.empty.c"
	?debug	T "src/000.empty.c"
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
 ;	
 ;	{
 ;	    return;
 ;	
 ;	
 ;	}
 ;	
@1:
@3:
@2:
	pop       ebp
	ret 
_f	endp
_TEXT	ends
	public	_f
	?debug	D "src/000.empty.c" 19692 5614
	end

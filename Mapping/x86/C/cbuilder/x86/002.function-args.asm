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
	?debug	S "src/002.function-args.c"
	?debug	T "src/002.function-args.c"
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
 ;	int f(int a, int b)
 ;	
	push      ebp
	mov       ebp,esp
 ;	
 ;	{
 ;	    return a + b;
 ;	
@1:
	mov       eax,dword ptr [ebp+8]
	add       eax,dword ptr [ebp+12]
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
	?debug	D "src/002.function-args.c" 19692 18678
	end

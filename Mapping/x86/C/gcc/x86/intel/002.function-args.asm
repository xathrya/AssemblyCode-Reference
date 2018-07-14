	.file	"002.function-args.c"
	.intel_syntax noprefix
	.text
	.globl	_f
	.def	_f;	.scl	2;	.type	32;	.endef
_f:
	push	ebp
	mov	ebp, esp
	mov	edx, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [ebp+12]
	add	eax, edx
	pop	ebp
	ret
	.ident	"GCC: (tdm64-1) 5.1.0"

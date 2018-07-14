	.file	"001.function-return.c"
	.intel_syntax noprefix
	.text
	.globl	_f
	.def	_f;	.scl	2;	.type	32;	.endef
_f:
	push	ebp
	mov	ebp, esp
	mov	eax, 135
	pop	ebp
	ret
	.ident	"GCC: (tdm64-1) 5.1.0"

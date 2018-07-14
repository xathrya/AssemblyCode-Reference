	.file	"003.function-vars.c"
	.intel_syntax noprefix
	.text
	.globl	_f
	.def	_f;	.scl	2;	.type	32;	.endef
_f:
	push	ebp
	mov	ebp, esp
	sub	esp, 16
	mov	BYTE PTR [ebp-1], 1
	mov	DWORD PTR [ebp-8], 2
	fld	DWORD PTR LC0
	fstp	DWORD PTR [ebp-12]
	nop
	leave
	ret
	.section .rdata,"dr"
	.align 4
LC0:
	.long	1077936128
	.ident	"GCC: (tdm64-1) 5.1.0"

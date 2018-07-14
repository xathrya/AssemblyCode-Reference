	.file	"003.function-vars.c"
	.intel_syntax noprefix
	.text
	.globl	f
	.def	f;	.scl	2;	.type	32;	.endef
	.seh_proc	f
f:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 16
	.seh_stackalloc	16
	.seh_endprologue
	mov	BYTE PTR -1[rbp], 1
	mov	DWORD PTR -8[rbp], 2
	movss	xmm0, DWORD PTR .LC0[rip]
	movss	DWORD PTR -12[rbp], xmm0
	nop
	add	rsp, 16
	pop	rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 4
.LC0:
	.long	1077936128
	.ident	"GCC: (tdm64-1) 5.1.0"

	.file	"003.function-vars.c"
	.text
	.globl	f
	.def	f;	.scl	2;	.type	32;	.endef
	.seh_proc	f
f:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movb	$1, -1(%rbp)
	movl	$2, -8(%rbp)
	movss	.LC0(%rip), %xmm0
	movss	%xmm0, -12(%rbp)
	nop
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 4
.LC0:
	.long	1077936128
	.ident	"GCC: (tdm64-1) 5.1.0"

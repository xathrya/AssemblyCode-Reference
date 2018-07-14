	.file	"003.function-vars.c"
	.text
	.globl	_f
	.def	_f;	.scl	2;	.type	32;	.endef
_f:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movb	$1, -1(%ebp)
	movl	$2, -8(%ebp)
	flds	LC0
	fstps	-12(%ebp)
	nop
	leave
	ret
	.section .rdata,"dr"
	.align 4
LC0:
	.long	1077936128
	.ident	"GCC: (tdm64-1) 5.1.0"

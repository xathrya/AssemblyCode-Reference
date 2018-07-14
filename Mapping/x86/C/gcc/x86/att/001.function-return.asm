	.file	"001.function-return.c"
	.text
	.globl	_f
	.def	_f;	.scl	2;	.type	32;	.endef
_f:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$135, %eax
	popl	%ebp
	ret
	.ident	"GCC: (tdm64-1) 5.1.0"

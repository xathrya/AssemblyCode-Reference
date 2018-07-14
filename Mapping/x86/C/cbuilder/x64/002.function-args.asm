	.file	"src/002.function-args.c"
	.text
	.globl	f
	.align	16, 0x90
	.type	f,@function
f:                                      # @f
.Ltmp3:
.seh_proc f
# BB#0:
	pushq	%rbp
.Ltmp4:
	.seh_pushreg 5
	movq	%rsp, %rbp
	andq	$-8, %rsp
	subq	$16, %rsp
.Ltmp5:
	.seh_stackalloc 16
.Ltmp6:
	.seh_endprologue
	movl	%ecx, 12(%rsp)
	movl	%edx, 8(%rsp)
	movl	12(%rsp), %ecx
	addl	%edx, %ecx
	movl	%ecx, %eax
	movq	%rbp, %rsp
	popq	%rbp
	ret
.Ltmp7:
	.size	f, .Ltmp7-f
.Leh_func_end0:
.Ltmp8:
	.seh_endproc


	.section	".note.GNU-stack","",@progbits

	.file	"src/000.empty.c"
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
.Ltmp5:
	.seh_endprologue
	movq	%rbp, %rsp
	popq	%rbp
	ret
.Ltmp6:
	.size	f, .Ltmp6-f
.Leh_func_end0:
.Ltmp7:
	.seh_endproc


	.section	".note.GNU-stack","",@progbits

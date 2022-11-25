	.file	"program.c"
	.text
	.globl	factorial
	.type	factorial, @function
factorial:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	$1, -8(%rbp)
	movl	$1, -12(%rbp)
	jmp	.L2
.L3:
	movl	-12(%rbp), %eax
	cltq
	movq	-8(%rbp), %rdx
	imulq	%rdx, %rax
	movq	%rax, -8(%rbp)
	addl	$1, -12(%rbp)
.L2:
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jle	.L3
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	factorial, .-factorial
	.section	.rodata
.LC3:
	.string	"%lf"
	.text
	.globl	printResult
	.type	printResult, @function
printResult:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movsd	%xmm0, -40(%rbp)
	movl	%edi, -44(%rbp)
	cvtsi2sdl	-44(%rbp), %xmm2
	movsd	-40(%rbp), %xmm1
	movsd	.LC0(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movapd	%xmm2, %xmm1
	call	pow@PLT
	movq	%xmm0, %rax
	movq	%rax, -8(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -16(%rbp)
	movl	$0, -28(%rbp)
	jmp	.L6
.L9:
	movl	$1, -24(%rbp)
	movl	-44(%rbp), %eax
	movl	%eax, -20(%rbp)
	jmp	.L7
.L8:
	movl	-24(%rbp), %eax
	imull	-20(%rbp), %eax
	movl	%eax, -24(%rbp)
	subl	$1, -20(%rbp)
.L7:
	movl	-44(%rbp), %eax
	subl	-28(%rbp), %eax
	cmpl	%eax, -20(%rbp)
	jg	.L8
	cvtsi2sdl	-24(%rbp), %xmm4
	movsd	%xmm4, -56(%rbp)
	cvtsi2sdl	-28(%rbp), %xmm0
	movq	-40(%rbp), %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	mulsd	-56(%rbp), %xmm0
	movsd	%xmm0, -56(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, %edi
	call	factorial
	cvtsi2sdq	%rax, %xmm0
	movsd	-56(%rbp), %xmm3
	divsd	%xmm0, %xmm3
	movapd	%xmm3, %xmm0
	movsd	-16(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -16(%rbp)
	addl	$1, -28(%rbp)
.L6:
	movsd	-8(%rbp), %xmm0
	subsd	-16(%rbp), %xmm0
	movsd	-8(%rbp), %xmm2
	movsd	.LC2(%rip), %xmm1
	mulsd	%xmm2, %xmm1
	comisd	%xmm1, %xmm0
	ja	.L9
	movq	-16(%rbp), %rax
	movq	%rax, %xmm0
	leaq	.LC3(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	printResult, .-printResult
	.section	.rodata
.LC4:
	.string	"%d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-16(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	leaq	-20(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-20(%rbp), %edx
	movq	-16(%rbp), %rax
	movl	%edx, %edi
	movq	%rax, %xmm0
	call	printResult
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L12
	call	__stack_chk_fail@PLT
.L12:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1072693248
	.align 8
.LC2:
	.long	3539053052
	.long	1062232653
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:

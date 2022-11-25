# -20[rbp] => r11d

	.intel_syntax noprefix          # пишем в синаксисе intel     
	.text                           # начинаем секцию
factorial:                          # функция вычисляющая факториал числа 
	push	rbp                     # сохранение rbp на стек
	mov	rbp, rsp                    # rbp := rsp
	mov	r11d, edi                   # r11d = edi
	mov	QWORD PTR -8[rbp], 1        # long sum = 1
	mov	DWORD PTR -12[rbp], 1       # i = 1
	jmp	.L2                         # go to .L2
.L3:
	mov	eax, DWORD PTR -12[rbp]     # eax = i
	cdqe                            # преобразование в sign-extend
	mov	rdx, QWORD PTR -8[rbp]      # rdx := sum
	imul	rax, rdx                # выполянет умножение rax, rdx
	mov	QWORD PTR -8[rbp], rax      # sum := rax
	add	DWORD PTR -12[rbp], 1       # ++i
.L2:
	mov	eax, DWORD PTR -12[rbp]     # eax := i 
	cmp	eax, r11d                   # сравниванием eax и r11d
	jle	.L3                         # если i <= x, то jump .L3 
	mov	rax, QWORD PTR -8[rbp]      # rax := sum
	pop	rbp                         # / завершение метода
	ret                             # |
.LC3:
	.string	"%lf"
	.text
printResult:                        # Метод, вычисляющий и печатающий результат 
	push	rbp                     # сохранение rbp на стек
	mov	rbp, rsp                    # rbp := rsp
	sub	rsp, 64                     # rsp -= 64 
	movsd	QWORD PTR -40[rbp], xmm0    # перемещаем в -40[rbp] с расширением разрядности 
	mov	DWORD PTR -44[rbp], edi         
	cvtsi2sd	xmm2, DWORD PTR -44[rbp] # преобразуем числа в double и записываем его в xmm2
	movsd	xmm1, QWORD PTR -40[rbp]    # перемещаем в xmm1 с расширением разрядности
	movsd	xmm0, QWORD PTR .LC0[rip]   # перемещаем в xmm0 с расширением разрядности
	addsd	xmm0, xmm1              # xmm0 += xmm1 (в double)
	movapd	xmm1, xmm2              # xmm1 := xmm2
	call	pow@PLT                 # вызов функции pow
	movq	rax, xmm0				# rax := xmm0
	mov	QWORD PTR -32[rbp], rax		
	pxor	xmm0, xmm0              # XOR xmm0, xmm0
	movsd	QWORD PTR -8[rbp], xmm0 # перемещаем в -8[rbp] с расширением разрядности
	mov	DWORD PTR -12[rbp], 0       # i = 0
	jmp	.L6                         # go to .L6
.L9:
	mov	DWORD PTR -16[rbp], 1       # int coefficient = 1
	mov	eax, DWORD PTR -44[rbp]     # eax := -44[rbp]
	mov	r11d, eax                   # r11d = eax
	jmp	.L7                         # go to .L7
.L8:
	mov	eax, DWORD PTR -16[rbp]     # |
	imul	eax, r11d               # | coefficient *= j
 	mov	DWORD PTR -16[rbp], eax     # |
	sub	r11d, 1                     # j--
.L7:
	mov	eax, DWORD PTR -44[rbp]     # eax := -44[rbp]
	sub	eax, DWORD PTR -12[rbp]     # eax : -12[rbp]
	cmp	r11d, eax                   # сравниванием j >= m - i + 1
	jg	.L8                         # go to .L8
	cvtsi2sd	xmm4, DWORD PTR -16[rbp]    # преобразуем числа в double и записываем его в xmm4
	movsd	QWORD PTR -56[rbp], xmm4        # перемещает в место, указанное вторым операндом    
	cvtsi2sd	xmm0, DWORD PTR -12[rbp]    # преобразуем числа в double и записываем его в xmm0
	mov	rax, QWORD PTR -40[rbp]     # rax := -40[rbp]
	movapd	xmm1, xmm0              # |
	movq	xmm0, rax               # | вызов функции pow
	call	pow@PLT                 # | 
	mulsd	xmm0, QWORD PTR -56[rbp] # xmm0 *= -56[rbp]
	movsd	QWORD PTR -56[rbp], xmm0 # -56[rbp] := xmm0
	mov	eax, DWORD PTR -12[rbp]     # | 
	mov	edi, eax                    # | вызов функции факториал
	call	factorial               # |
	cvtsi2sd	xmm0, rax           # преобразуем числа в double и записываем его в xmm0
	movsd	xmm3, QWORD PTR -56[rbp]    # xmm3 := -56[rbp] перемещает в место, указанное вторым операндом
	divsd	xmm3, xmm0              # xmm3 /= xmm0
	movapd	xmm0, xmm3              # xmm0 := xmm3
	movsd	xmm1, QWORD PTR -8[rbp] # |
	addsd	xmm0, xmm1              # | result += coefficient * pow(x, i) / factorial(i)
	movsd	QWORD PTR -8[rbp], xmm0 # |
	add	DWORD PTR -12[rbp], 1       # ++i
.L6:
	movsd	xmm0, QWORD PTR -32[rbp]    # | xmm0 := -32[rbp] перемещает в место указанное вторым операндом
	subsd	xmm0, QWORD PTR -8[rbp]     # | xmm0 -= -8[rbp]  while (exact - result > 0.001 * exact)
	movsd	xmm2, QWORD PTR -32[rbp]    # | xmm2 := -32[rbp]
	movsd	xmm1, QWORD PTR .LC2[rip]   # |
	mulsd	xmm1, xmm2              # xmm1 := xmm2 умножение чисел с плавающий точкой 
	comisd	xmm0, xmm1              # сравниванием два double числа: (exact - result > 0.001 * exact)
	ja	.L9                         # go to .L9
	mov	rax, QWORD PTR -8[rbp]      # rax := -8[rbp]
	movq	xmm0, rax               # xmm0 := rax
	lea	rdi, .LC3[rip]              # |
	mov	eax, 1                      # |
	call	printf@PLT              # | вызов функции printf("%lf", result);
	nop                             # не выполняет никакой операции, занимает место в потоке команд
	leave                           # / завершение метода 
	ret                             # |
.LC4:
	.string	"%d"
	.globl	main
	.type	main, @function
main:
	push	rbp                     # сохраняем rbp на стек
	mov	rbp, rsp                    # rbp := rsp
	sub	rsp, 16                     # rsp -= 16 (выделяем память для фрейма)
	lea	rsi, -8[rbp]                # rsi := -8[rbp]
	lea	rdi, .LC3[rip]              
	mov	eax, 0                      # возвращение в eax 0
	call	__isoc99_scanf@PLT      # вызов функции scanf("%lf", &x);
	lea	rsi, -12[rbp]               # rsi := -12[rbp]
	lea	rdi, .LC4[rip]              
	mov	eax, 0                      # возвращение в eax 0
	call	__isoc99_scanf@PLT      # вызов функции scanf("%d", &m);
	mov	edx, DWORD PTR -12[rbp]     # edx := -12[rbp]
	mov	rax, QWORD PTR -8[rbp]      # rax := -8[rbp]
	mov	edi, edx                    # edi := edx
	movq	xmm0, rax               # xmm0 := rax
	call	printResult             # вызов функции printResult
	mov	eax, 0                      # возвращение в eax 0
	leave                           # / выход из функции
	ret                             # |
.LC0:
	.long	0
	.long	1072693248
.LC2:
	.long	3539053052
	.long	1062232653
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:


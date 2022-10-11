.data
.intel_syntax noprefix
.text
.global	checkMultOverflow

checkMultOverflow:
	push rbp
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -28[rbp], esi
	mov	DWORD PTR -4[rbp], 2
	jmp	for1
	
condition:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	imul rax, QWORD PTR -24[rbp]
	cmp	QWORD PTR -24[rbp], rax
	jbe	_add
	mov	eax, 1
	jmp	ext1
	
_add:
	add	DWORD PTR -4[rbp], 1

for1:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jle	condition
	mov	eax, 0

ext1:
	pop	rbp
	ret
	.size checkMultOverflow, .-checkMultOverflow

.LC1:
    .text
    .global factorial

factorial:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	DWORD PTR -4[rbp], edi
	cmp	DWORD PTR -4[rbp], 1
	jle	if
	mov	eax, DWORD PTR -4[rbp]
	sub	eax, 1
	mov	edi, eax
	call factorial
	imul eax, DWORD PTR -4[rbp]
	jmp	else

if:
	mov	eax, 1

else:
	leave
	ret
	.size	factorial, .-factorial

.LC0:
	.string	"Result (maximum argument): %d"
	.text
	.global	main

main:
	push rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR -8[rbp], 1
	mov	DWORD PTR -12[rbp], 2

for2:
	mov	edx, DWORD PTR -12[rbp]
	mov	rax, QWORD PTR -8[rbp]
	mov	esi, edx
	mov	rdi, rax
	call checkMultOverflow
	test al, al
	jne	ext2
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	mov	rdx, QWORD PTR -8[rbp]
	imul rax, rdx
	mov	QWORD PTR -8[rbp], rax
	add	DWORD PTR -12[rbp], 1
	jmp	for2

ext2:
	nop
	mov	eax, DWORD PTR -12[rbp]
	sub	eax, 1
	mov	esi, eax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call printf@PLT
	mov	eax, 0
	leave
	ret
	.size main, .-main

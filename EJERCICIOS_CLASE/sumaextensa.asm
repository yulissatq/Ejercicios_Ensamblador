; Yulissa Torres Quezada

section .data
	msj1 dd	10, 'Ingrese el primer numero: '
	len1 equ $ - msj1
 
	msj2 dd	'Ingrese el segundo numero: '
	len2 equ $ - msj2
 
	msj3 db	10, 'La suma es: ', 10
	len3 equ $ - msj3
 
	nlinea db 10, 10, 0
	lnlinea equ $ - nlinea
 
section .bss
	num1: resb 3
	num2: resb 3
	resultado: resb 3
 
section .text
	global _start

_start: 
	mov eax, 4
	mov ebx, 1
	mov ecx, msj1
	mov edx, len1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, num1
	mov edx, 3
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, msj2
	mov edx, len2
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, num2
	mov edx, 3
	int 80h

	jmp sumar

sumar:
	
	mov al, [num1 + 0]
	mov bl, [num2 + 0]
 
	
	sub al, '0'
	sub bl, '0'
	add al, bl
	add al, '0'

	mov [resultado], al
	mov eax, 4
	mov ebx, 1
	mov ecx, msj3
	mov edx, len3
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 2
	int 80h

	mov al, [num1 + 1]
	mov bl, [num2 + 1]
	sub al, '0'
	sub bl, '0'

	add al, bl
	add al, '0'

	mov [resultado], al
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 2
	int 80h
	
	jmp salir
 
salir:
	
	mov eax, 4
	mov ebx, 1
	mov ecx, nlinea
	mov edx, lnlinea
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h

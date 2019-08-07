%macro escribir 2
    mov eax, 4
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80H
%endmacro

section .data

	msj db 'La resta es: ', 10
	len equ $-msj
	num1 db '518'
	num2 db '197'
	resta db '   '

section .text
	global _start

_start:

	mov ecx, 3 ;numero de operaciones de resta
	mov esi, 2 ; posicion del digito en cada num1 y num2
	clc        ; pone la bandera del carry en cero (apagada)

ciclo_resta:
	mov al, [num1 + esi]
	sbb al, [num2 + esi]  ; suma el acarreo a resta en binario

	aas                   ; ajusta la operacion binaria a sistema decimal

	pushf

	or al, 30h

	popf 

	mov [resta + esi], al
	dec esi

	loop ciclo_resta

	escribir msj, len
	escribir resta, 3

	mov eax, 1
	int 80h



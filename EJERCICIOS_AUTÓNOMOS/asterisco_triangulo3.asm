section .data
	asterisco db "*"
	len_ast equ $ -asterisco
	
	salto db 10,""
	leng_salto equ $ -salto

	espacio db " "
	leng_espacio equ $ -espacio

	
section .bss
	
;resultado
;**********
;*********
;********
;*******
;******
;*****
;****
;***
;**
;*


section .text
	global _start

_start:
	;inicializamos la variable para que nos de el numero de columnas
	mov ecx, 20
	mov ebx, 20
	mov eax, 0 
	push ecx

linea1:
	push ebx
	push ecx
	 ;ultimo entra primero en salir
	call imprimir_enter ; como usar el llamado de una funcion en condigo de alto nivel function(){}

	
	pop ecx
	mov ebx, ecx
	push ebx

linea2:
	push ecx
	call imprimir_asterisco
	pop ecx
	loop linea2
	pop ebx
	pop ecx
	dec ebx ;cambiamos para invertirlo 

	loop linea1
	jmp salir

imprimir_espacio:
	mov eax, 4
	mov ebx, 1
	mov ecx, espacio 
	mov edx, leng_espacio
	int 80H	
	ret

imprimir_asterisco:
	mov eax, 4
	mov ebx, 1
	mov ecx, asterisco
	mov edx, len_ast
	int 80H	
	ret

imprimir_enter:
	mov eax, 4
	mov ebx, 1
	mov ecx, salto 
	mov edx, 1
	int 80H	
	ret

salir:
	mov eax, 1
	mov ebx, 0
	int 80H
%macro escribir 2
    mov eax, 4
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80H
%endmacro

section .data
	msj db "Escribir en el archivo", 10
	len equ $-msj

	path db "/home/yuli/Documentos/archivob1.txt", 0


section .bss
	texto resb 30
	idarchivo resd 1

section .text
	global _start

_start: 
	;*******************apertura del archivo*******************
	mov eax, 8      ;servicio para crear y escribir en archivos
	mov ebx, path   ;direccion del archivo
	mov ecx, 2      ;modo de acceso, write = 0
	mov edx, 200h   ;permisos del archivo
	int 80H

	test eax, eax   ; es un and sin modificar sus operandos, solo modifica banderas
	jz salir

	;*******************archivo sin excepciones*****************
	mov dword [idarchivo], eax   ;respaldo el id del archivo

	escribir msj, len

	mov eax, 3
	mov ebx, 2 ; entrada estandar
	mov ecx, texto
	mov edx, 30
	int 80H

	mov eax, 4
	mov ebx, [idarchivo]
	mov ecx, texto
	mov edx, 30
	int 80H

 
	;*******************cerrar del archivo*******************
	mov eax, 6             ;servicio
	mov ebx, [idarchivo]   ;direccion del archivo
	mov ecx, 0             ;modo de acceso, read only = 0
	mov edx, 0             ;permisos del archivo
	int 80H


salir:            
	mov eax, 1
	int 80H
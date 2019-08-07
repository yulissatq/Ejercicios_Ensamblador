%macro escribir 2
    mov eax, 4
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80H
%endmacro

section .data
	msj_archivo1 db 10,'Lectura del archivo 1:', 10
	len1 equ $-msj_archivo1

	msj_archivo2 db 10,'Lectura del archivo 2:', 10
	len2 equ $-msj_archivo2

	msj_resta db 10,  'La resta es: ', 10
	len_resta equ $-msj_resta

	msj_suma db 10, 'La suma es: ', 10
	len_suma equ $-msj_suma

	resta db '   '

	suma db '    '

	salto_linea db " ", 10
	len_salto db $-salto_linea

	path1 db "/home/yuli/Documentos/ENSAMBLADOR/operando1.text", 0
	path2 db "/home/yuli/Documentos/ENSAMBLADOR/operando2.text", 0


section .bss
	texto1 resb 30
	texto2 resb 30
	idarchivo1 resd 1
	idarchivo2 resd 1

section .text
	global _start

_start: 
	;*******************apertura del archivo*******************
	mov eax, 5      ;servicio
	mov ebx, path1   ;direccion del archivo
	mov ecx, 0      ;modo de acceso, read only = 0
	mov edx, 0      ;permisos del archivo
	int 80H

	test eax, eax
	jz salir

	;*******************archivo sin excepciones*****************
	mov dword [idarchivo1], eax   ;respaldo el id del archivo

	escribir msj_archivo1, len1

	mov eax, 3
	mov ebx, [idarchivo1] ; entrada estandar
	mov ecx, texto1
	mov edx, 30
	int 80H

	escribir texto1, 30
 
	;*******************cerrar del archivo*******************
	mov eax, 6             ;servicio
	mov ebx, [idarchivo1]   ;direccion del archivo
	mov ecx, 0             ;modo de acceso, read only = 0
	mov edx, 0             ;permisos del archivo
	int 80H

	;escribir salto_linea, len_salto
	;*******************apertura del archivo*******************
	mov eax, 5      ;servicio
	mov ebx, path2  ;direccion del archivo
	mov ecx, 0      ;modo de acceso, read only = 0
	mov edx, 0      ;permisos del archivo
	int 80H

	test eax, eax
	jz salir

	;*******************archivo sin excepciones*****************
	mov dword [idarchivo2], eax   ;respaldo el id del archivo

	escribir msj_archivo2, len2

	mov eax, 3
	mov ebx, [idarchivo2] ; entrada estandar
	mov ecx, texto2
	mov edx, 30
	int 80H

	escribir texto2, 30
 
	;*******************cerrar del archivo*******************
	mov eax, 6             ;servicio
	mov ebx, [idarchivo2]   ;direccion del archivo
	mov ecx, 0             ;modo de acceso, read only = 0
	mov edx, 0             ;permisos del archivo
	int 80H

numeros_resta:
	mov ecx, 3 ;numero de operaciones de resta
	mov esi, 2 ; posicion del digito en cada num1 y num2
	clc        ; pone la bandera del carry en cero (apagada)

ciclo_resta:
	mov al, [texto1+ esi]
	sbb al, [texto2+ esi]  ; suma el acarreo a resta en binario

	aas                   ; ajusta la operacion binaria a sistema decimal

	pushf

	or al, 30h

	popf 

	mov [resta + esi], al
	dec esi

	loop ciclo_resta

	escribir msj_resta, len_resta
	escribir resta, 3

numeros_suma:
	mov ecx, 3
	mov esi, 2
	clc            ; instruccion, CF = 0

ciclo_suma:
	mov al, [texto1 + esi]
	adc al, [texto2 + esi]
	aaa 
	pushf           ; guarda en pila todos los valores de las banderas 

	or al, 30h		; add 48, or al, 30h, add 48, add '0'

	popf
	mov [suma + esi], al
	dec esi

	loop ciclo_suma

	escribir msj_suma, len_suma
	escribir suma, 3

salir:            
	mov eax, 1
	int 80H
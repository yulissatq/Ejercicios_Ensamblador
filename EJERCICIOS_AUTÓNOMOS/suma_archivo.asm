%macro escribir 2
    mov eax, 4
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80H
%endmacro

section .data
	msj_archivo1 db 10,'Lectura del archivo 1:', 10
	len_msjarchivo1 equ $-msj_archivo1

	msj_archivo2 db 10,'Lectura del archivo 2:', 10
	len_msjarchivo2 equ $-msj_archivo2

	msj_suma db 10,'La suma es: ', 10
	len_msjsuma equ $-msj_suma

	msj_resultado db '  '
	len_resultado equ $-msj_resultado

	salto_linea db " ", 10
	len_salto db $-salto_linea

	path1 db "/home/yuli/Documentos/Archivos/suma.txt", 0
	path2 db "/home/yuli/Documentos/Archivos/result_suma.txt", 0

	cadena db  "      "
    len_cadena equ $-cadena

section .bss
	texto1 resb 30
	texto2 resb 30

	idarchivo1 resd 1
	idarchivo2 resd 1

	aux1 resb 20
	aux2 resb 20

	aux3 resb 1

	suma resb 20
	cont resb 30
	numero resb 20
	ind resb 10

section .text
	global _start

_start: 
	


	mov al, 0
	mov [cont], al
	mov [ind], al
	mov [suma], al

;                  LECTURA DEL ARCHIVO
;~****************apertura del archivo****************
	mov eax, 5   ; servicio para abrir el archivo
	mov ebx, path1  ; direccion del archivo
	mov ecx, 0  ;modo de acceso, read only=0
	mov edx, 0  ; permisos del archivo
	int 80H
	
	;~ test == and --> el test solo modifica el estado de las banderas y define un 0
	test eax, eax
	jz salir
	
	;~ **********archivo sin excepciones************
	mov dword [idarchivo1], eax ; respaldo el id del archivo
	escribir msj_archivo1, len_msjarchivo1
	
	mov eax, 3
	mov ebx, [idarchivo1] ;entrada estandar
	mov ecx, texto1
	mov edx, 10
	int 80H
	
	escribir texto1, 10
	
;~****************cierre del archivo****************
	mov eax, 6  		  ; servicio para abrir el archivo
	mov ebx, [idarchivo1]  ; direccion del archivo
	mov ecx, 0			  ;modo de acceso, read only=0
	mov edx, 0  		  ; permisos del archivo
	int 80H


        
  	mov al, 0

ciclo1:
    mov [aux1], al
    cmp al, 6
    jz salir

    mov bl, [suma]
    mov cl, [texto1 + eax]
    sub cl, '0'

    add bl, cl


finCiclo1:
	mov [suma], bl

    mov al, [aux1]
    inc al
    jmp ciclo1

salir:
	;escribir msj_resultado, len_resultado

	escribir msj_suma, len_msjsuma

	mov dl, [suma]
	add dl, '0'
	mov [suma], dl

	escribir suma, 4

	call escribirTexto
    mov eax, 1
    mov ebx, 0
    int 80H



escribirTexto:
;                 ESCRITURA EN EL ARCHIVO
	mov eax, 8  ; servicio para crear y escribir en archivos
	mov ebx, path2 ; direccion del archivo
	mov ecx, 2  ;modo de acceso, read write=1
	mov edx, 200h  ; permisos del archivo
	int 80H
	
	;~ test == and --> el test solo modifica el estado de las banderas y define un 0
	test eax, eax  
	jz salir
	
	;~ **********archivo sin excepciones************
	mov dword [idarchivo2], eax ; respaldo el id del archivo

	mov eax, 4 
	mov ebx, [idarchivo2]  
	mov ecx, suma
	mov edx, 1	  
	int 80H	
	
;~****************cierre del archivo****************
	mov eax, 6  		  ; servicio para abrir el archivo
	mov ebx, [idarchivo2]  ; direccion del archivo
	mov ecx, 0			  ;modo de acceso, read only=0
	mov edx, 0  		  ; permisos del archivo
	int 80H
	ret
	
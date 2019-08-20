%macro escribir 2
    mov eax, 4
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80H
%endmacro

section .data
	msj_archivo1 db 10,'Lectura del archivo:', 10
	len_msjarchivo1 equ $-msj_archivo1

	msj_numero db "Ingrese un numero: "
    len_msjnumero equ $-msj_numero

	msj_repeticiones db 10,'Las veces que se repite el numero es: ', 10
	len_msjrepeticiones equ $-msj_repeticiones

	msj_resultado db '   '
	len_resultado equ $-msj_resultado

	salto_linea db " ", 10
	len_salto db $-salto_linea

	path1 db "/home/yuli/Documentos/Archivos/numeros.txt", 0
	path2 db "/home/yuli/Documentos/Archivos/result_repeticion.txt", 0

	cadena db  "        "
    len_cadena equ $-cadena

section .bss
	texto1 resb 30
	texto2 resb 30

	idarchivo1 resd 1
	idarchivo2 resd 1

	aux1 resb 20
	aux2 resb 20

	aux3 resb 1

	num_ing resb 2

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

  	mov eax, 4 
    mov ebx, 1
    mov ecx, msj_numero
    mov edx, len_msjnumero
    int 80H
        
    mov eax, 3
    mov ebx, 2
    mov ecx, num_ing
    mov edx, 10
    int 80H


    mov al,[num_ing]
    sub al,'0'
    


mov al, 0

ciclo1:
    mov [aux1], al
    cmp al, 8
    jz salir

    mov bl, [num_ing]
    mov cl, [texto1 + eax]
    ;sub cl, '0'

    cmp bl, cl
    jz contar

finCiclo1:

    mov al, [aux1]
    inc al
    jmp ciclo1

salir:

	;escribir msj_resultado, len_resultado

	escribir msj_repeticiones, len_msjrepeticiones

	mov al,[cont]
	add al, '0'
	mov [cont], al

	escribir cont, 4

	call escribirTexto
    mov eax, 1
    mov ebx, 0
    int 80H

contar:
	mov bl,[cont]
	inc bl
	mov [cont], bl
	jmp finCiclo1

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
	mov ecx, cont  
	mov edx, 2
	int 80H
;~****************cierre del archivo****************
	mov eax, 6  		  ; servicio para abrir el archivo
	mov ebx, [idarchivo2]  ; direccion del archivo
	mov ecx, 0			  ;modo de acceso, read only=0
	mov edx, 0  		  ; permisos del archivo
	int 80H
	ret
	
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

	msj_multiplicaciones db 10,'Multiplicaciones: ', 10
	len_multi equ $-msj_multiplicaciones

	msj_resultado db '0*0=0, 0*0=0, 0*0=0, 0*0=0, 0*0=0'
	len_resultado equ $-msj_resultado

	salto_linea db " ", 10
	len_salto db $-salto_linea

	path1 db "/home/yuli/Documentos/Archivos/operando1.txt", 0
	path2 db "/home/yuli/Documentos/Archivos/operando2.txt", 0
	path3 db "/home/yuli/Documentos/Archivos/resultados.txt", 0

	cadena db  "     "
    len_cadena equ $-cadena

    mov [msj_resultado + ecx], bl

section .bss
	texto1 resb 30
	texto2 resb 30

	idarchivo1 resd 1
	idarchivo2 resd 1
	idarchivo3 resd 1

	aux1 resb 2
	

	numero1 resb 2
	numero2 resb 2

	ind resb 12

section .text
	global _start

_start:

	mov al, 0

	mov [ind], al

;                 LECTURA DEL ARCHIVO
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
	mov edx, 5
	int 80H
	
	escribir texto1, 5
	
;~****************cierre del archivo****************
	mov eax, 6  		  ; servicio para abrir el archivo
	mov ebx, [idarchivo1]  ; direccion del archivo
	mov ecx, 0			  ;modo de acceso, read only=0
	mov edx, 0  		  ; permisos del archivo
	int 80H

;                 LECTURA DEL ARCHIVO
;~****************apertura del archivo****************
	mov eax, 5   ; servicio para abrir el archivo
	mov ebx, path2  ; direccion del archivo
	mov ecx, 0  ;modo de acceso, read only=0
	mov edx, 0  ; permisos del archivo
	int 80H
	
	;~ test == and --> el test solo modifica el estado de las banderas y define un 0
	test eax, eax
	jz salir
	
	;~ **********archivo sin excepciones************
	mov dword [idarchivo2], eax ; respaldo el id del archivo
	escribir msj_archivo2, len_msjarchivo2
	
	mov eax, 3
	mov ebx, [idarchivo2] ;entrada estandar
	mov ecx, texto2
	mov edx, 5
	int 80H
	
	escribir texto2, 5
	
;~****************cierre del archivo****************
	mov eax, 6  		  ; servicio para abrir el archivo
	mov ebx, [idarchivo2]  ; direccion del archivo
	mov ecx, 0			  ;modo de acceso, read only=0
	mov edx, 0  		  ; permisos del archivo
	int 80H      

  	mov al, 0

ciclo1:
    mov [aux1], al
    cmp al, len_cadena
    jz salir
    
    mov bl, [aux1]
    mov al, [texto1 + ebx]
    mov bl, [texto2 + ebx] 

    mov ecx, [ind]
    mov [msj_resultado + ecx], al

    add ecx, 2

    mov [msj_resultado + ecx], bl

    sub al, '0'
    sub bl, '0' ;'0*0=0, 0*0=0, 0*0=0, 0*0=0, 0*0=0'

    mul bl

    add al, '0'
    add ecx, 2

    mov [msj_resultado + ecx], al

    add ecx, 3
    mov [ind], ecx

finCiclo1:

    mov al, [aux1]
    inc al
    jmp ciclo1

salir:
	;escribir msj_resultado, len_resultado
	call escribirTexto
    mov eax, 1
    mov ebx, 0
    int 80H

escribirTexto:
;                 ESCRITURA EN EL ARCHIVO
	mov eax, 8   ; servicio para crear y escribir en archivos
	mov ebx, path3 ; direccion del archivo
	mov ecx, 2  ;modo de acceso, read write=1
	mov edx, 200H  ; permisos del archivo
	int 80H
	
	;~ test == and --> el test solo modifica el estado de las banderas y define un 0
	test eax, eax  
	jz salir
	
	;~ **********archivo sin excepciones************
	mov dword [idarchivo3], eax ; respaldo el id del archivo
	escribir msj_multiplicaciones, len_multi

	escribir msj_resultado, len_resultado
	
	mov eax, 4 
	mov ebx, [idarchivo3]  
	mov ecx, msj_resultado	  
	mov edx, len_resultado	  
	int 80H	
	
;~****************cierre del archivo****************
	mov eax, 6  		  ; servicio para abrir el archivo
	mov ebx, [idarchivo3]  ; direccion del archivo
	mov ecx, 0			  ;modo de acceso, read only=0
	mov edx, 0  		  ; permisos del archivo
	int 80H
	ret
	
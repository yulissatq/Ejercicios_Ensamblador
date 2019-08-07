%macro imprimirData 2
	mov eax, 4
	mov ebx, 1  
	mov ecx, %1 
	mov edx, %2
	int 80H	
%endmacro

%macro leerData 2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1 
    mov edx, %2
    int 80H 
%endmacro


section .data
	msg db 'Serie 2 4 6 8 ',10
	lenMsj equ $-msg

	msg2 db '                                     ',10
	lenMsj2 equ $-msg2

    nueva_linea db " ", 10

    arreglo db 0,0,0,0,0
    lenArreglo equ $-arreglo

section .bss
    resultado resb 2
    aux1 resb 2
 
section .text
    global _start
    
_start:
	mov esi, arreglo ;indice fuente
	mov edi, 0 ; indice destino

	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, lenMsj
	int 80H			

leer:
	mov al, 0 
	
ciclo1:
	mov [aux1], al
	cmp al, lenArreglo
	ja variable

	cmp al, 0
	jz ingresarA

	mov bl, al
	dec bl
	mov cl, [arreglo + ebx]
	inc bl
	add cl, 2
	mov [arreglo + ebx], cl

finCiclo1:
	mov al, [aux1]
	inc al

	jmp ciclo1


salir:
	mov eax, 1
	mov ebx, 0
	int 80H

;solo para imprimir el arreglo

variable:
	imprimirData msg2,lenMsj2
	mov ecx, 0
	jmp imprimir

imprimir:
	push ecx

	mov al, [arreglo + ecx]
	add al, '0'
	mov [resultado], al
	
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 2
	int 80H	

	mov eax, 4
    mov ebx, 1
    mov ecx, nueva_linea
    mov edx, 1
    int 80H

	pop ecx
	
	inc ecx

	cmp ecx, lenArreglo
	jb imprimir
	jmp salir


ingresarA:
	mov bl, 2
	mov [arreglo + eax], bl
	jmp finCiclo1 
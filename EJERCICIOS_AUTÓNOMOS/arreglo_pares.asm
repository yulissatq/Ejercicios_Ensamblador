%macro imprimirData 2
	mov eax,4
	mov ebx,1
	mov ecx,%1 
	mov edx,%2
	int 80H	
%endmacro

%macro leerData 2
    mov eax,3
    mov ebx,0
    mov ecx,%1 
    mov edx,%2
    int 80H 
%endmacro


section .data
	msg db 'Ingrese 5 numeros y presione enter: ',10
	lenMsj equ $-msg

	msg2 db 'Numeros pares dentro del arreglo: ',10
	lenMsj2 equ $-msg2

    nueva_linea db 10, ""
    lenLinea equ $-nueva_linea

    arreglo db 0,0,0,0,0
    lenArreglo equ $-arreglo

section .bss
    resultado resb 2
    aux1 resb 2
 	aux2 resb 2
   
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
	mov eax, 3
	mov ebx, 2
	mov ecx, resultado
	mov edx, 2
	int 80H	

	mov al, [resultado]	
	sub al, '0'
	mov[esi], al
	inc esi
	inc edi

	cmp edi, lenArreglo ;cuando edi es menor
	jb leer

	imprimirData msg2,lenMsj2

	mov eax, 0

	mov al, 0

ciclo1:
	mov [aux1], al

	cmp al, lenArreglo
	jz salir
	
	mov dl, al
	mov bl, 2
	mov al, [arreglo + eax]	
	div bl

	cmp ah, 0
	jz imprimir


finCiclo1:
	mov al, [aux1]
	inc al
	jmp ciclo1


salir:
	mov eax, 1
	mov ebx, 0
	int 80H

imprimir:
	
	mov al, [arreglo + edx]

	div bl
	cmp ah, 0
	jz imprimir2

	jmp finCiclo1

imprimir2:
	mov al, [arreglo+edx]
	add al, '0'
	mov [aux2], al
	imprimirData aux2, 2
	imprimirData nueva_linea,lenLinea
	jmp finCiclo1


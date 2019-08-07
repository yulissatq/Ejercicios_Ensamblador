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
    msg db 'Ingrese 5 numeros y presione enter: ',10
    lenMsj equ $-msg

    msg2 db 'Arreglo ordenado ascendente: ',10
    lenMsj2 equ $-msg2

    nueva_linea db 10, ""

    ;definimos el arreglo

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
    mov edi,0 ; indice destino

    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, lenMsj
    int 80H         

leer:
        
    ;guardamos los datos
    mov eax,3
    mov ebx,2
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

    mov al, 0

ciclo1:
    mov [aux1], al
    cmp al, lenArreglo
    jz variable
    mov bl, 0


ciclo2:
    mov [aux2], bl
    cmp bl, lenArreglo
    jz finCiclo1

    mov cl, [arreglo + eax]
    mov dl, [arreglo + ebx]

    cmp dl, cl
    ja ordenar ; ja para ordenar de menor a mayor y jb de mayor a menor

    
finCiclo2:
    mov bl, [aux2]
    mov al, [aux1]; recuperamos el valor de eax
    inc bl
    jmp ciclo2


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
    add al,'0'
    mov [resultado], al
    
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 2
    int 80H 

    pop ecx
    
    inc ecx

    cmp ecx, lenArreglo
    jb imprimir
    jmp salir

ordenar:
    mov [arreglo + eax], dl
    mov [arreglo + ebx], cl
    jmp finCiclo2


    
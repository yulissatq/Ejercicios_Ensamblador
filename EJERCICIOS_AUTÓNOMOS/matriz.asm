section .data

    num1 db "Ingrese un numero: "
    len1 equ $-num1

    msj db "*"

    nlin db " ", 10

section .bss
    num resb 1
    
section .text
    global _start
    
_start:
    mov eax, 4 
    mov ebx, 1
    mov ecx, num1
    mov edx, len1
    int 80H
    
    mov eax, 3
    mov ebx, 2
    mov ecx, num
    mov edx, 2
    int 80H

    mov al,[num]
    sub al,'0'

    mov ecx,eax
    push ecx

    jmp columna


columna:
    mov eax, 4
    mov ebx, 1
    mov ecx, nlin
    mov edx, 2
    int 80H
    
        
    pop ecx
    cmp ecx, 0
    jz salir
    dec ecx
    push ecx

    mov al, [num]
    sub eax, '0'

    mov ecx, eax
    push ecx
    jmp fila

fila:
    pop ecx
    cmp ecx, 0

    jz columna
    push ecx
    jmp imprimir

imprimir:
    mov eax, 4
    mov ebx, 1
    mov ecx, msj
    mov edx, 1

    int 80H

    pop ecx
    dec ecx
    push ecx
    
    jmp fila

salir:            
    mov eax, 1
    int 80H

   
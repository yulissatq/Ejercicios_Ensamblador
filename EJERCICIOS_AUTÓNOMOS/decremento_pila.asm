section .data

    num1 db "Ingrese un numero: "
    len1 equ $-num1

    nlin db 10, " "

section .bss
    num resb 1
    resultado resb 1
    
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

ciclo:

    push ecx ;5

    mov ebx, ecx
    add ebx, '0'

    
    mov [resultado], ebx

    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 1
    int 80H

    mov eax, 4
    mov ebx, 1
    mov ecx, nlin
    mov edx, 1
    int 80H

    
    pop ecx ;1,2
    
    loop ciclo

salir:            
    mov eax, 1
    int 80H

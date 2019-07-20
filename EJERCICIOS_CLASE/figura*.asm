section .data
    estrellas db '***********',10
    nuevalinea db "",10
section .text
    global _start
    
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, estrellas
    mov edx, 7
    int 80H

    

    mov eax, 4
    mov ebx, 1
    mov ecx, nuevalinea
    mov edx, 1
    int 80H


    
    mov eax, 1
    mov ebx, 0
    int 80H

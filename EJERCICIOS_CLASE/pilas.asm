
section .data
    msj db "Ingrese nombre: "
    len1 equ $-msj
    
    msj1 db "Ingrese nombre: "
    len2 equ $-msj1

    presentar db "Ingrese nombre: "
    lenp equ $-presentar
    
    nuevalinea db "",10
    
    
section .bss
    a resb 10
    b resb 10
    resultado resb 10

    
section .text
    global _start
    
_start:
    mov eax, 4 
    mov ebx, 1
    mov ecx, msj
    mov edx, len1
    int 80H
    
    mov eax, 3
    mov ebx, 2
    mov ecx, a
    mov edx, 10
    int 80H
    
    mov eax, 4 
    mov ebx, 1
    mov ecx, msj1
    mov edx, len2
    int 80H
    
    mov eax, 3
    mov ebx, 2
    mov ecx, b
    mov edx, 10
    int 80H


    mov ax, [a]
    push ax

    mov ax, [b]
    push ax
    
    pop ax
    sub ax, '0'
    add ax, '0'

    mov [resultado], ax

    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 10
    int 80H

    pop ax
    sub ax, '0'
    add ax, '0'

    mov [resultado], ax

    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 10
    int 80H


    jmp salir

    salir:
        mov eax, 4
        mov ebx, 1
        mov ecx, nuevalinea
        mov edx, 1
        int 80H
            
        mov eax, 1
        int 80H

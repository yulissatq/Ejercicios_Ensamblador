section .data
    num1 db "Ingrese el primer numero: "
    len1 equ $-num1
    
    num2 db 10,"Ingrese el segundo numero: "
    len2 equ $-num2
    
    presentar db 10,"La division es:"
    lenp equ $-presentar

    presentarres db 10, "El residuo es: "
    lenpr equ $-presentarres

    nuevalinea db "",10
    
    
section .bss
    a resb 1
    b resb 1
    divi resb 1
    resid resb 1

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
    mov ecx, a
    mov edx, 2
    int 80H
    
    mov eax, 4 
    mov ebx, 1
    mov ecx, num2
    mov edx, len2
    int 80H
    
    mov eax, 3
    mov ebx, 2
    mov ecx, b
    mov edx, 2
    int 80H
    
    mov al, [a]
    mov bl, [b]
    sub al, '0'
    sub bl, '0'
    div bl
    add al, '0'; convierte el numero a cadena
    
    mov [divi], al
    
    add ah, '0'; convierte el numero a cadena
    mov [resid], ah

    mov eax, 4
    mov ebx, 1
    mov ecx, presentar
    mov edx, lenp
    int 80H
    
    mov eax, 4
    mov ebx, 1
    mov ecx, divi
    mov edx, 1
    int 80H
    
    mov eax, 4
    mov ebx, 1
    mov ecx, presentarres
    mov edx, lenpr
    int 80H
    
    mov eax, 4
    mov ebx, 1
    mov ecx, resid
    mov edx, 1
    int 80H

    mov eax, 4
    mov ebx, 1
    mov ecx, nuevalinea
    mov edx, 1
    int 80H
        
    mov eax, 1
    int 80H

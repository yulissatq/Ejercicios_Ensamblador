section .data
    num1 db "Ingrese el primer numero: "
    len1 equ $-num1
    
    num2 db 10,"Ingrese el segundo numero: "
    len2 equ $-num2
    
    presentar db 10,"La multiplicacion es: " 
    lenp equ $-presentar
    
section .bss
    a resb 1
    b resb 1
    multi resb 1

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
    
    mov ax, [a]
    mov bx, [b]
    sub ax, '0'
    sub bx, '0'
    mul bx
    add ax, '0' ; convierte el numero a cadena
    
    mov [multi], ax
    
    mov eax, 4
    mov ebx, 1
    mov ecx, presentar
    mov edx, lenp
    int 80H
    
    mov eax, 4
    mov ebx, 1
    mov ecx, multi
    mov edx, 1
    int 80H
    
        
    mov eax, 1
    int 80H

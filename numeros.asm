; Yulissa Torres Quezada

section .data
    num1 db "Ingrese el primer numero: "
    len1 equ $-num1
    
    num2 db 10,"Ingrese el segundo numero: "
    len2 equ $-num2

    presentarm db 10,"El primero es mayor."
    lenpm equ $-presentarm

    presentarme db 10, "El primero es menor."
    lenpme equ $-presentarme

    presentari db 10,"Los numeros son iguales."
    lenpi equ $-presentari


    nuevalinea db "",10
    
    
section .bss
    a resb 1
    b resb 1
    
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
    mov edx, 1
    int 80H
    
    mov al, [a]
    mov bl, [b]
    sub al, '0'
    sub bl, '0'

    cmp al, bl
        je igual
        ja mayor
        jb menor

    
    igual:
        mov eax, 4
        mov ebx, 1
        mov ecx, presentari
        mov edx, lenpi
        int 80H
        jmp salir
    
    mayor:
        mov eax, 4
        mov ebx, 1
        mov ecx, presentarm
        mov edx, lenpm
        int 80H
        jmp salir
    
    menor:
        mov eax, 4
        mov ebx, 1
        mov ecx, presentarme
        mov edx, lenpme
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

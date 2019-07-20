section .data
;(n+a)-n
    valor_n db "Ingrese un valor para n: "
    len_valorn equ $-valor_n
    
    valor_a db 10,"Ingrese un valor para a: "
    len_valora equ $-valor_a
    
    resultado db 10,"El resultado es:"
    len_resultado equ $-resultado
    
section .bss
    n resb 1
    a resb 1
    operacion resb 1

section .text
    global _start
    
_start:
    mov eax, 4 
    mov ebx, 1
    mov ecx, valor_n
    mov edx, len_valorn
    int 80H
    
    mov eax, 3
    mov ebx, 2
    mov ecx, n
    mov edx, 2
    int 80H
    
    mov eax, 4 
    mov ebx, 1
    mov ecx, valor_a
    mov edx, len_valora
    int 80H
    
    mov eax, 3
    mov ebx, 2
    mov ecx, a
    mov edx, 2
    int 80H
    jmp operacionn

operacionn:
    mov eax, [n]
    mov ebx, [a]
    sub eax, '0'
    sub ebx, '0'

    add eax, ebx
    mov ebx, [n]
    sub ebx, '0' ; convierte el numero a cadena

    sub eax,ebx
    add eax, '0'
    

    mov [operacion], eax
    
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, len_resultado
    int 80H
    
    mov eax, 4
    mov ebx, 1
    mov ecx, operacion
    mov edx, 1
    int 80H
    
salir:            
    mov eax, 1
    int 80H
    
    

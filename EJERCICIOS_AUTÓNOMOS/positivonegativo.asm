section .data
    num1 db "Ingrese un numero: "
    len1 equ $-num1
    
    presentarp db 10, "El numero es positivo"
    lenp equ $-presentarp

    presentarn db 10, "El numero es negativo"
    lenn equ $-presentarn

    presentarc db 10, "El numero es cero"
    lenc equ $-presentarc

    nuevalinea db "",10
    
    
section .bss
    a resb 2
    
    
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
    mov edx, 3
    int 80H 
    
    mov al, [a]
    sub al, '0'

    cmp al, 0
        js negativo
        jg positivo
        je cero
    
    negativo:
        mov eax, 4
        mov ebx, 1
        mov ecx, presentarn
        mov edx, lenn
        int 80H
        jmp salir
    
    positivo:
        mov eax, 4
        mov ebx, 1
        mov ecx, presentarp
        mov edx, lenp
        int 80H
        jmp salir
      
    cero:
        mov eax, 4
        mov ebx, 1
        mov ecx, presentarc
        mov edx, lenc
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

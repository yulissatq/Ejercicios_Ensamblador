section .data
    num1 db "Ingrese el primer numero: "
    len1 equ $-num1
    
    num2 db 10,"Ingrese el segundo numero: "
    len2 equ $-num2
    
    presentari db 10,"Los numeros son iguales."
    lenpi equ $-presentari

    presentarn db 10, "Los numeros no son iguales."
    lenpn equ $-presentarn

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
    mov edx, 2
    int 80H
    
    mov al, [a]
    mov bl, [b]
    sub al, '0'
    sub bl, '0'

    cmp al, bl
        jz igual
        jmp noigual
    
       
   igual:
        mov eax, 4
        mov ebx, 1
        mov ecx, presentari
        mov edx, lenpi
        int 80H
        jmp salir
    

   noigual:
        mov eax, 4
        mov ebx, 1
        mov ecx, presentarn
        mov edx, lenpn
        int 80H
        

    salir:
        mov eax, 4
        mov ebx, 1
        mov ecx, nuevalinea
        mov edx, 1
        int 80H
            
        mov eax, 1
        int 80H

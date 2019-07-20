section .data
    num1 db "Ingrese un numero: "
    len1 equ $-num1
    
    presentarp db 10,"El numero es par."
    lenpp equ $-presentarp

    presentari db 10, "El numero es impar."
    lenpi equ $-presentari

    nuevalinea db "",10
    
section .bss
    a resb 1
    

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
   
    mov ebx, [a]
    sub ebx, '0'  
    and ebx, 1
        jz par
        jmp impar
       
    par:
        mov eax, 4
        mov ebx, 1
        mov ecx, presentarp
        mov edx, lenpp
        int 80H
        jmp salir
    

    impar:
        mov eax, 4
        mov ebx, 1
        mov ecx, presentari
        mov edx, lenpi
        int 80H
        

    salir:
        mov eax, 4
        mov ebx, 1
        mov ecx, nuevalinea
        mov edx, 1
        int 80H
            
        mov eax, 1
        int 80H

section .data
    num1 db "Ingrese el primer numero: "
    len1 equ $-num1
    
    num2 db 10,"Ingrese el segundo numero: "
    len2 equ $-num2

    msj db 10, "El resultado de xxxx:"
    len equ $-msj

    nuevalinea db "",10
    
    
section .bss
    imprimir resb 10
    a resb 1
    b resb 1
    suma resb 1
    resta resb 1
    multi rest 1
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
    jmp division

    sum: 
        mov ax, [a]
        mov bx, [b]
        sub ax, '0'
        sub bx, '0'
        add ax,bx
        add ax, '0' ; convierte el numero a cadena
        
        mov [suma], ax

        mov [msj + 17], dword 'suma'
        
        mov eax, 4
        mov ebx, 1
        mov ecx, msj
        mov edx, len
        int 80H
        
        mov eax, 4
        mov ebx, 1
        mov ecx, suma
        mov edx, 1
        int 80H
        jmp multiplicacion

    res:
        mov ax, [a]
        mov bx, [b]
        sub ax, '0'
        sub bx, '0'
        sub ax,bx
        add ax, '0' ; convierte el numero a cadena
        
        mov [resta], ax

        mov [msj+17], dword 'rest'
        
        mov eax, 4
        mov ebx, 1
        mov ecx, msj
        mov edx, len
        int 80H
        
        mov eax, 4
        mov ebx, 1
        mov ecx, resta
        mov edx, 1
        int 80H
        jmp sum

    multiplicacion:
        mov ax, [a]
        mov bx, [b]
        sub ax, '0'
        sub bx, '0'
        mul bx
        add ax, '0' ; convierte el numero a cadena
        
        mov [multi], ax

        mov [msj+17], dword 'mult'
        
        mov eax, 4
        mov ebx, 1
        mov ecx, msj
        mov edx, len
        int 80H
        
        mov eax, 4
        mov ebx, 1
        mov ecx, multi
        mov edx, 1
        int 80H
        jmp salir

    division:    
        mov al, [a]
        mov bl, [b]
        sub al, '0'
        sub bl, '0'
        div bl
        add al, '0'; convierte el numero a cadena
        
        mov [divi], al
        
        add ah, '0'; convierte el numero a cadena
        mov [resid], ah

        mov [msj+17], dword 'divi'

        mov eax, 4
        mov ebx, 1
        mov ecx, msj
        mov edx, len
        int 80H
        
        mov eax, 4
        mov ebx, 1
        mov ecx, divi
        mov edx, 1
        int 80H
        
        mov [msj+17], dword 'resi'

        mov eax, 4
        mov ebx, 1
        mov ecx, msj
        mov edx, len
        int 80H
        
        mov eax, 4
        mov ebx, 1
        mov ecx, resid
        mov edx, 1
        int 80H
        jmp res
   
    
    salir:    
        mov eax, 4
        mov ebx, 1
        mov ecx, nuevalinea
        mov edx, 1
        int 80H
            
        
        mov eax, 1
        int 80H

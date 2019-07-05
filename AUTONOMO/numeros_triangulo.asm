section .data

    num1 db "Ingrese un numero: "
    len1 equ $-num1

    asterisco db "*"

    nueva_linea db 10, " "
section .bss
    num resb 1
    pres_num resb 1
    
section .text
    global _start
    
;1 
;2 1 
;3 2 1 
;4 3 2 1
;5 4 3 2 1
;6 5 4 3 2 1
;7 6 5 4 3 2 1
;8 7 6 5 4 3 2 1
;9 8 7 6 5 4 3 2 1
;n

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
    mov ecx, pres_num
    mov edx, 10
    int 80H


    mov al,[pres_num]
    sub al,'0'
    
    push eax
    pop ecx


    mov ebx, 1

l1:
    push ecx;9
    push ebx;1,2

    call imprimir_enter

    pop ecx;1,2
    mov ebx, ecx;1,2
    push ebx;1,2


l2:
    push ecx ;1,2

    call imprimir_numero;*,**

    pop ecx ;1
    loop l2    ; ecx != 0
    pop ebx;1
    pop ecx;1
    inc ebx;2
    loop l1
    
    ; se termina el programa
    
    int 80H
    
imprimir_numero:
    mov eax, ecx
    add eax,'0'
    mov [num],eax

    mov eax, 4
    mov ebx, 1
    mov ecx, num
    mov edx, 1
    int 80H
    ret 

imprimir_enter:
    mov eax, 4
    mov ebx, 1
    mov ecx, nueva_linea
    mov edx, 1
    int 80H
    ret        ;se retorna a la ultima linea del llamado




section .data

    asterisco db "*"
    nueva_linea db 10, ""

section .bss

;resultado
;*
;**
;***
;****
;*****
;******
;*******
;********
;*********
;**********    
    
section .text
    global _start
    
_start:
    mov ecx, 20
    mov ebx, 1

l1:
    push ecx
    push ebx
    call imprimir_enter
    pop ecx
    mov ebx, ecx
    push ebx

l2:
    push ecx
    call imprimir_asterisco
    pop ecx
    loop l2    ; ecx != 0
    pop ebx
    pop ecx
    inc ebx
    loop l1
    
    ; se termina el programa
    mov eax, 1
    int 80H

    
imprimir_asterisco:
    mov eax, 4
    mov ebx, 1
    mov ecx, asterisco
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
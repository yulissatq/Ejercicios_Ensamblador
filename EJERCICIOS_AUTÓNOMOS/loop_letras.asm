section .data

    nueva_linea db 10, " "

section .bss
    resultado resb 1
    
section .text
    global _start
    
;a
;b a
;c b a 
;d c b a 
;e d c b a 
;f e d c b a 
;g f e d c b a 
;h g f e d c b a 
;i h g f e d c b a 
;n

section .text
    global _start
    
_start:
    
    mov ecx, 26
    mov ebx, 1
    ;----------- ciclo para imprimir enters ------------
l1:
    push ecx ;9
    push ebx ;1,2

    call imprimir_enter

    pop ecx ;1,2
    push ecx ;1,2

    ;---------- ciclo para imprimir numero por columna filas   -----

l2:  
    push ecx
    add ecx, '0'
    mov [resultado], ecx
    call imprimir_numero;*,**
    pop ecx
    loop l2
    ; --------- fin del ciclo l2 --------
    pop ebx
    inc ebx
    pop ecx
    loop l1

    jmp salir
    
imprimir_numero:
    mov eax, ecx
    add eax,'0'
    mov [resultado],eax

    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
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

salir:            
    mov eax, 1
    int 80H



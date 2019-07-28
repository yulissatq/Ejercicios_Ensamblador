section .data

    msj_inicio db 10, "Inicio ciclos"
    len_inicio equ $-msj_inicio

    msj_fin db 10, "Fin ciclos"
    len_fin equ $-msj_fin

    msj_int db 10, "Realizado por:"
    len_int equ $-msj_int

    msj_nombre db 10, "Yulissa"
    len_nombre equ $-msj_nombre

    nueva_linea db 10, " "

section .bss
    
    
section .text
    global _start
    
    
_start:

    mov eax, 4
    mov ebx, 1
    mov ecx, msj_inicio
    mov edx, len_inicio
    int 80H

    mov eax, 4
    mov ebx, 1
    mov ecx, msj_int
    mov edx, len_int
    int 80H
    
    mov ecx, 5
    ;----------- ciclo para imprimir enters ------------    

ciclo:
    push ecx ;5

    mov eax, 4
    mov ebx, 1
    mov ecx, msj_nombre
    mov edx, len_nombre
    int 80H
    
    pop ecx ;1,2
    
    loop ciclo

    mov eax, 4
    mov ebx, 1
    mov ecx, msj_fin
    mov edx, len_fin
    int 80H

    ;---------- ciclo para imprimir numero por columna filas   -----

salir:            
    mov eax, 1
    int 80H



%macro escribir 2
    mov eax, 4
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80H
%endmacro


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

    escribir msj_inicio, len_inicio


    escribir msj_int, len_int
    
    mov ecx, 5
    ;----------- ciclo para imprimir enters ------------    

ciclo:
    push ecx ;5

    escribir msj_nombre, len_nombre
    
    pop ecx ;1,2
    
    loop ciclo

    escribir msj_fin, len_fin

    ;---------- ciclo para imprimir numero por columna filas   -----

salir:            
    mov eax, 1
    int 80H



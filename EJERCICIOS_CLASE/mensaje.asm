section .data
    materia db 'Lenguaje Ensamblador', 0xa
    ciclo db 'Secto Ciclo B', 0xa
    nombre db 'Yulissa Torres', 0xa

    len EQU $-materia
    len1 EQU $-ciclo
    len2 EQU $-nombre

section .text
    global _start

_start:
    mov eax, 4 ;operacion de escritura
    mov ebx, 1 ;unidad estandar
    mov ecx, materia ; contiene lo que se va a escribir
    mov edx, len     ; define el numero de caracteres implementados
    int 80H          ; interrupcion del software

    mov eax, 1
    mov ebx, 0
    int 80H

    mov eax, 4 
    mov ebx, 1
    mov ecx, ciclo
    mov edx, len1
    int 80H

    mov eax, 1
    mov ebx, 0
    int 80H

    mov eax, 4 
    mov ebx, 1
    mov ecx, nombre
    mov edx, len2
    int 80H

    mov eax, 1
    mov ebx, 0
    int 80H
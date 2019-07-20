
section .data
    saludo db 'Hola ensamblador', 0xa
    len EQU $-saludo
section .text
    global _start

_start:
    mov eax, 4 
    mov ebx, 1
    mov ecx, saludo
    mov edx, len
    int 80H

    mov eax, 1
    mov ebx, 0
    int 80H

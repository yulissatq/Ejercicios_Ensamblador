section .data
    msj db "*"

    nlin db " ", 10

section .bss
    contador resb 1
    aux resb 1
    auxC resb 1
    auxA resb 1
    
section .text
    global _start

;1 2 3 4 5
;0 0 0 0 0
;5 5 5 5 5
;9 9 9 9 9 
;5 4 3 2 1
    
_start:
   
    mov eax, 6
    add eax, '0'
    mov [contador],eax

    sub eax,'0'

    mov ecx,5
    push ecx

    jmp columna

columna:
    
    mov al, 1
    add al, '0'
    mov [aux], al

    mov al, 5
    add al, '0'
    mov [auxA], al

    mov al,[contador]
    add al, '0'
    dec al
    sub al,'0'
    mov [contador],al 
    
    mov eax, 4
    mov ebx, 1
    mov ecx, nlin
    mov edx, 2
    int 80H   
        
    pop ecx

    cmp ecx, 0
    jz salir
    
    dec ecx
    
    push ecx
    
    mov ecx, 5 ;decrementa en uno para triangulo
    push ecx

    jmp fila

fila:

    pop ecx
    cmp ecx, 0
    jz columna
    push ecx
    jmp imprimir

imprimir:

    mov al, [contador]
    sub al,'0'

    cmp eax, 5
    jz impfila1

    cmp eax,4
    jz impfila2

    cmp eax,3
    jz impfila3

    cmp eax,2
    jz impfila4
   
    cmp eax,1
    jz impfila5


    jmp salir
    

impfila1:

    mov eax, 4
    mov ebx, 1
    mov ecx, aux
    mov edx, 1
    int 80H

    pop ecx
    dec ecx
    push ecx

    mov al,[aux]
    sub al,'0'
    inc al
    add al,'0'
    mov [aux],al
    
    jmp fila

impfila2:

    mov al,0
    add al,'0'
    mov [aux],al

    mov eax, 4
    mov ebx, 1
    mov ecx, aux
    mov edx, 1

    int 80H

    pop ecx
    dec ecx
    push ecx

    jmp fila

impfila3:

    mov al,5
    add al,'0'
    mov [aux],al

    mov eax, 4
    mov ebx, 1
    mov ecx, aux
    mov edx, 1

    int 80H

    pop ecx
    dec ecx
    push ecx

    
    jmp fila


impfila4:

    mov al,9
    add al,'0'
    mov [aux],al

    mov eax, 4
    mov ebx, 1
    mov ecx, aux
    mov edx, 1

    int 80H

    pop ecx
    dec ecx
    push ecx

    
    jmp fila

impfila5:
    
    mov al,[auxA]
    sub al,'0'
    add al,'0'
    mov [auxA],al

    mov eax, 4
    mov ebx, 1
    mov ecx, auxA
    mov edx, 1

    int 80H

    pop ecx
    dec ecx
    push ecx


    mov al,[auxA]
    sub al,'0'
    dec al
    add al,'0'
    mov [auxA],al
    
    jmp fila

salir:            
    mov eax, 1
    int 80H

   
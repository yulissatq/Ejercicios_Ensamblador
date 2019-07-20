section .data
    msg db "Ingrese el primer numero: ",10
    len equ $-msg
    
    msg1 db "Ingrese el segundo  numero: ",10
    len1 equ $-msg1
    

    resultado db 10,"Resultado ****",10
    resultsum equ $-resultado

    msjMenu db 'Ingrese operacion a realizar:',10,' 1.Suma',10,' 2.Resta',10,' 3.Multiplicacion',10,' 4.Division',10,' 5.salir',10,'Ingrese una opcion: '
    lenMsjMenu equ $-msjMenu

    msjError db "Error ingrese datos menores a 5",10
    lenMsjError equ $-msjError

section .bss
    datoNum1 resb 10
    datoNum2 resb 10
    datoCrud resb 10 
    resul resb 10
    resulr resb 10

section .text
    global _start
    
_start:
    jmp ingresoDatosOperacion
;mostramos los mensajes del crud y se ingresa la opcion

ingresoDatosMenu:
    ;mensaje crud
    mov eax,4
    mov ebx,1
    mov ecx,msjMenu
    mov edx,lenMsjMenu
    int 80H
    ;guardamos dato crud
    mov eax,3
    mov ebx,2
    mov ecx,datoCrud
    mov edx,10
    int 80H

    mov al,[datoCrud]
    sub al,'0'

    cmp al,05
    jle menu

    mov eax,4
    mov ebx,1
    mov ecx,msjError
    mov edx,lenMsjError
    int 80H

    jmp ingresoDatosMenu

ingresoDatosOperacion:
    ;presentamos el primer mensaje
    mov eax,4
    mov ebx,1
    mov ecx,msg
    mov edx,len
    int 80H
    ;guardamos el valor
    mov eax,3
    mov ebx,2
    mov ecx,datoNum1
    mov edx,10
    int 80H
    ;presentamo el segundo mensaje
    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,len1
    int 80H
    ;guardamos el segundo dato
    mov eax,3
    mov ebx,2
    mov ecx,datoNum2
    mov edx,10
    int 80H

    jmp ingresoDatosMenu

;comparamos el numero ingresado del crud
menu:
    ;precaucion los datos se guardan en el al para realizar operacion de crud
    mov al,[datoCrud]
    sub al,'0'


    cmp al,01
    jz realizarSuma
    cmp al,02
    jz realizarResta
    cmp al,03
    jz realizarMul
    cmp al,04
    jz realizarDiv
    cmp al,05
    jz salir

    
    jmp ingresoDatosMenu

realizarSuma:
    mov[resultado+11],dword 'sum'
    
    mov eax,04 
    mov ebx,01 
    mov ecx,resultado
    mov edx,resultsum
    int 80H 

    mov eax,[datoNum1]
    mov ebx,[datoNum2]
    sub eax,'0'
    sub ebx,'0'

    
    add eax,ebx
    add eax,'0'
    mov [resul],eax 

    mov eax,04 
    mov ebx,01 
    mov ecx,resul     
    mov edx,01
    int 80H 
    jmp salir

realizarResta:
    mov[resultado+11],dword 'res'
    
    mov eax,04 
    mov ebx,01 
    mov ecx,resultado
    mov edx,resultsum
    int 80H 

    mov eax,[datoNum1]
    mov ebx,[datoNum2]
    sub eax,'0'
    sub ebx,'0'

    
    sub eax,ebx
    add eax,'0'
    mov [resul],eax 

    mov eax,04 
    mov ebx,01 
    mov ecx,resul     
    mov edx,01
    int 80H 
    jmp salir

realizarMul:
    mov[resultado+11],dword 'mul'
    
    mov eax,04 
    mov ebx,01 
    mov ecx,resultado
    mov edx,resultsum
    int 80H 

    mov eax,[datoNum1]
    mov ebx,[datoNum2]
    sub eax,'0'
    sub ebx,'0'

    
    mul ebx
    add eax,'0'
    mov [resul],eax 

    mov eax,04 
    mov ebx,01 
    mov ecx,resul     
    mov edx,01
    int 80H 
    jmp salir

realizarDiv:
    mov[resultado+11],dword 'divc'
    
    mov eax,04 
    mov ebx,01 
    mov ecx,resultado
    mov edx,resultsum
    int 80H 

    mov al,[datoNum1]
    mov bl,[datoNum2]
    sub al,'0'
    sub bl,'0'

    
    div bl
    add al,'0'
    add ah,'0'
    mov [resul],al
    mov [resulr],ah

    mov eax,04 
    mov ebx,01 
    mov ecx,resul     
    mov edx,01
    int 80H 

    mov[resultado+11],dword 'divr'

    mov eax,04 
    mov ebx,01 
    mov ecx,resultado
    mov edx,resultsum
    int 80H 

    mov eax,04 
    mov ebx,01 
    mov ecx,resulr     
    mov edx,01
    int 80H 


    jmp salir


salir:
    mov eax,1
    int 80H

    
section .data ;datos
    num db 'Ingrese numero a calcular el factorial:',10
    leng_num equ $ - num

    result db ' es el FACTORIAL',10
    leng_re equ $ - result    ;equ es para constantes

    msg db 10,'0',
    leng_msg equ $ - msg

    nlinea db 10
    leng_nlinea equ $ - nlinea

section .bss
    fact resb 4
    aux resb 4
    resi resd 5
    cont resd 5 

section .text                ;programa
	global _start

_start:
    mov eax, 4                
    mov ebx, 1                 
    mov ecx, num         
    mov edx, leng_num              
    int 80h  						
    ;leer dato de teclado
    mov eax, 3
    mov ebx, 0
    mov ecx, fact
    mov edx, 2
    int 80h
  
    and dword[fact],0FFh
    sub dword[fact],'0'
    mov eax,[fact]
    cmp eax,0
    je cero
    mov ecx,eax
    mov eax,1
     
    
loop_for:
    mul ecx
    loop loop_for
    add eax,'0'
    mov [fact], eax
    

mas_cifra:
	  mov ecx,0
    mov [cont],ecx
    sub dword[fact],'0'
    mov eax,[fact]
	
do:
    mov ecx,10
    mov edx, 0
    cmp eax, 0
    ja secumple ;eax es mayor
    jmp cerrar
            
secumple:
    div ecx
    mov [aux], eax
    add edx,'0'
    mov [resi], edx
    push edx
    mov ecx, [cont]
    inc ecx
    mov [cont],ecx
    mov eax, [aux]

    jmp do

cerrar:
    mov ecx,[cont]
      

for:
    mov [cont],ecx
    pop eax
    mov [aux],eax
    mov eax,4
    mov ebx,1
    mov ecx,aux
    mov edx,1
    int 80h 
    mov ecx,[cont]
    loop for
    jmp imprimir
     

cero:
	  mov dword[fact],1
	  add dword[fact],'0'
    mov eax, 4                
   	mov ebx, 1                  
   	mov ecx, fact         
   	mov edx, 4                 
   	int 80h 

imprimir:
   	mov eax, 4                  
    mov ebx, 1                 
    mov ecx, result             
    mov edx, leng_re               
    int 80h 
   

salir:
    mov eax, 1                 ; exit
    xor ebx, ebx               ; exit code 0
    int 80h
                

 	;zf es cero y cf es el acarreo para el if, si los 2 son cero el primer dato es mayor, si el segundo es 1 el primer dato es menor

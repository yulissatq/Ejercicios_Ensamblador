
;mov eax, 5



;add eax, '0'      ; en el codigo ascii 48

;add eax, 48 
 
;escribir eax, 1   ; operaciones de suma son simples 0-9



;mov eax, 1
;mov abx, 4
;add eax, ebx



;'518'
;'197'
;'715'

%macro escribir 2
    mov eax, 4
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80H
%endmacro

section .data
	msg db 'La suma es: ',10
	len equ $ - msg
	num1 db '518'
	num2 db '197'
	suma db '   '

section .text
	global _start

_start:
	mov ecx, 3
	mov esi, 2
	clc            ; instruccion, CF = 0

ciclo_suma:
	mov al, [num1 + esi]
	adc al, [num2 + esi]
	aaa 
	pushf           ; guarda en pila todos los valores de las banderas 

	or al, 30h		; add 48, or al, 30h, add 48, add '0'

	popf
	mov [suma + esi], al
	dec esi

	loop ciclo_suma

	escribir msg, len
	escribir suma, 3

	mov eax, 1
	int 80h
model small  ; define el tipo de memoria que se utilizara
.stack 64    ; es para darle el grandor a la pila
.data
 
msn1 db, 13,10,"por favor ingrese un numero: ", '$'         ; el 13,10 es para dar salto de linea
msn2 db, 13,10, "el numero ingresado es Par: ", '$' ; se determina el letrero que va a salir
msn3 db, 13,10, "el numero ingresado es Impar: ", '$'; en cuando salga el resultado.
msn4 db, 13,10, "el numero ingresado es cero: ", '$'
 
var1 db, 0; definimos variables
 
.code
 
inicio proc far ; iniciamos procedimiento
 
mov ax, @data ; direccionamiento de segmentos
mov ds, ax
 
; limpiar pantalla
 
mov ah, 00
mov al, 03h
int 10h
 
mov ah, 09h
lea dx, msn1
int 21h
 
;leer y convertir el numero  para verlo en pantalla
 
mov ah,01h
int 21h
sub al, 30h; para convertir en ascii y visualizarlo
 
mov var1, al
int 21h
sub al, 30h
mov ah, var1
 
mov bl, var1
 
cmp bl,1
 
 
JP PAR ; que salte si es par
JNP IMPAR; que salte si es impar
Jz CERO ; que salte si en cero
 
;cuando es positivo que muestre en el msn2
PAR:
mov ah,09h
lea dx, msn2
int 21h
jmp salir
 
;cuando es negativo mostrar el msn3
IMPAR:
mov ah,09h
lea dx, msn3
int 21h
jmp salir
;cuando es cero mostrar el msn4
CERO:
mov ah,09h
lea dx, msn4
int 21h
jmp salir
 
; salir del programa
salir:
mov ax, 4c00h
int 21h
inicio endp
end inicio
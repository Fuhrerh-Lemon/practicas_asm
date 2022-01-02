.Model small
.Stack
.Data

x dw 75
y dw 75
contador db 0
mensaje1 db "Size del triangulo de 1 a 9 $"


.Code
main:
mov ax,@data
mov ds,ax

;modo grafico
mov ah,00h
mov al,13h
int 10h

;**limpia reg
xor bx,bx

;MSG
mov dx,offset mensaje1
mov ah,9
int 21h

;DATO
;xor ax,ax
mov ah,1
int 21h
mov bl,al
sub bl,30h

;color**
mov ah,0ch
mov al,15h

;++++++ principal +++++++
ciclo1:
call pixel
call cont
cmp contador,bl
je slinea
jmp ciclo1



;----procedimientos ----
pixel:
mov cx,x
mov dx,y
int 10h
ret

cont:
inc x
inc contador
ret

slinea:
inc y
sub x,bx
add x,1
;-------;
cmp bl,2;
je fin ;
cmp bl,1;
je fin ;
;-------;
sub bx,2
mov contador,0
jmp ciclo1

fin:
mov ah,00h
mov al,02h
int 10h
;-----------------
mov ah,04ch
int 21h
end
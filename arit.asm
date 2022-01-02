.model small
.stack
.data
   n1 db 0
   n2 db 0
   r db 0
   msg1 db 10,13,7,"Suma:","$"
   msg2 db 10,13,7,"Resta:","$"
   msg3 db 10,13,7,"Mult:","$"
   msg4 db 10,13,7,"Div:","$"
   msg0 db 10,13,7,"Ingrese un numero:","$"
   
.code
.startup
    mov ax, seg @data
    mov ds, ax
 
    mov ah, 09h
    lea dx, msg0
    int 21h
    
    mov ah, 01h
    int 21h
    sub al, 30h
    mov n1,al
    
    mov ah, 09h
    lea dx, msg0
    int 21h
    
    mov ah, 01h
    int 21h
    sub al, 30h
    mov n2,al
    
    ;suma
    mov al,n1
    add al,n2
    mov r,al
    
    mov ah, 09h
    lea dx, msg1
    int 21h
    
    mov al,r
    AAM
    mov bx,ax
    mov ah,02h
    mov dl,bh
    add dl,30h
    int 21h
    
    mov ah,02h
    mov dl,bl
    add dl,30h
    int 21h
    
    ; Resta
   
    mov al,n1
    sub al, n2
    mov r, al
    
    mov ah, 09h
    lea dx, msg2
    int 21h
    
    mov al,r
    AAM
    mov bx,ax
    mov ah,02h
    mov dl,bh
    add dl,30h
    int 21h
    
    mov ah,02h
    mov dl,bl
    add dl,30h
    int 21h 
    
    ; Multiplicacion
    
    mov al, n1
    mov bl, n2
    mul bl
    mov r, al
    
    mov ah, 09h
    lea dx, msg3
    int 21h
    
    mov al,r
    AAM
    mov bx,ax
    mov ah,02h
    mov dl,bh
    add dl,30h
    int 21h
    
    mov ah,02h
    mov dl,bl
    add dl,30h
    int 21h 
    
    ; Dividir
    
    xor ax,ax
    mov bl,n2
    mov al,n1
    div bl
    mov r,al
    
    mov ah, 09h
    lea dx, msg4
    int 21h
    
    mov al,r
    AAM
    mov bx,ax
    mov ah,02h
    mov dl,bh
    add dl,30h
    int 21h
    
    mov ah,02h
    mov dl,bl
    add dl,30h
    int 21h 
    
  .exit
end
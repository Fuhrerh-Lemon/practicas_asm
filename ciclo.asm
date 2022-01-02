.model small
.stack
.data
   cont db 0
   msg db 10,13,7,'??Hola que tal.???','$'
.code
.startup
    mov ax, seg @data
    mov ds, ax
 
    ciclo:
       cmp cont,10
       je salir
    
       mov ah, 9h
       lea dx, msg
       int 21h
    
       inc cont
    jmp ciclo
    
    salir:
        .exit
end
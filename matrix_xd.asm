;===========Matrix chafa=================================
.model tiny
    .data
column      db 0        ; Columna a 0
row         db 0        ; Filas a 0
delayCount dw ?
    .code
    org 0100h           ; creando archivo .com
main:
                        ; modo 80x25
    mov ah, 00h         ; modo video
    mov al, 03h
    int 10h
    
rain:
    mov ah, 02h         ; cursor       
    mov bh, 00h         ; bh para pagina
    mov dh, row         ; dh para fila
    mov dl, column      ; dl para columna
    int 10h
    
    push ax             ; Random
    mov ah, 00h
    int 1Ah
    shr dl, 2           ; Para ir mas despacio
    pop ax
    
    mov ax, dx
    xor dx, dx
    mov cx, 94
    div cx
    add dl, '!'        ; ascii 0 a 9
        
    mov ah, 09h
    mov al, dl
    mov bh, 00h
    mov bl, 0Ah
    mov cx, 1
    int 10h
    
    mov delayCount, 50000   ; delay
    mov cx, delayCount
delay:
    nop
    dec delayCount
    cmp delayCount, 0
    jne delay
        
    mov ah, 09h         ; removemos los caracteres
    mov al, ' '
    mov bh, 00h
    mov bl, 04h
    mov cx, 01h
    int 10h
    
    inc row
    
    cmp row, 24
    jg doExit
    jmp rain

doExit:    
    
    ret
    end main
IDEAL
MODEL small
STACK 100h
DATASEG
lenseries1 equ 10
lenseries2 equ 10
series1 db lenseries1 dup(?)
series2 db lenseries2 dup(?)
sorted db lenseries1+lenseries2 dup(?)
insertCon dw 4
endmsg db 'end$'
sortCondition db 0
array1msg db 'Ingresar numeros del primer arreglo:$'
array2msg db 'Ingresar numeros del segundo arreglo:$'
sortedarrmsg db 'Metodo Sort:$'
CODESEG 
proc Merge
    push bp
    mov bp,sp
    ; stack:
    ; bp | ip | sorted | series2 | series1
    ;bp+0|bp+2| bp+4   | bp+6    | bp+8
    ;
    mov cx,lenseries1
    mov [insertCon],bx
    mov bx,[bp+8] ;mover la localizacion de series1 a bx
    mergeloop1:
    mov al,[bx]
    add al,30h
    push bx
    mov bx,[insertCon]
    inc [insertCon]
    mov [bx],al
    pop bx
    inc bx
    loop mergeloop1
    
    mov cx,lenseries2
    mov bx,[bp+6]
    mergeloop2: ; primero loop
    mov al,[bx]
    add al,30h
    push bx
    mov bx,[insertCon]
    inc [insertCon]
    mov [bx],al
    pop bx
    inc bx
    loop mergeloop2
    pop bp
    ret 4
endp Merge
proc sortArr
    push bp
    mov bp,sp
    
    ; bp | ip |sorted
    ;bp+0|bp+2|bp+4
conditionloop:
    mov bx,[bp+4] ; bx=sorted position 
    mov [sortCondition],1 ; El arreglo no esta ordenado
    mov cx,lenseries1+lenseries2-1
sortloop:
    mov al,[bx]
    mov ah,[bx+1]
    cmp ah,al ; Comparando el arreglo en bx and bx+1
    jae issort ; if bx<bx+1 correcto
    mov [bx+1],al ; Si no esta, intercambiamos bx,bx+1
    mov [bx],ah
    mov [sortCondition],0; Arreglo(matriz) no ordenado
issort:
    inc bx
loop sortloop
    cmp [sortCondition],0
    je conditionloop ; if sortCondition=0 por lo que la matriz no está ordenada y se debe verificar nuevamente
ending:
    pop bp
    ret 2
endp sortArr
proc linedrop
    push bp
    mov bp,sp
    mov dl,0dh ; retornamos el punto de inicio
    mov ah,2
    int 21h
    mov dl,0ah ; Siguiente linea
    mov ah,2
    int 21h
    pop bp
    ret 
endp linedrop   
start:
    mov ax, @data
    mov ds, ax
    ;code here
    mov ah,9
    mov dx,offset array1msg ; Imprimiendo el mensaje  
    int 21h
    call linedrop
    mov cx,lenseries1
    mov bx, offset series1
arrayLoop:
    mov ah,1
    int 21h
    sub al,30h ; sub en 30h porque el código ascii del número es num +30h y queremos guardar solo el número
    mov [bx],al
    inc bx
loop arrayLoop
    call linedrop
    mov ah,9
    mov dx,offset array2msg
    int 21h
    call linedrop
    mov cx,lenseries2
    mov bx, offset series2
arrayLoop2:
    mov ah,1
    int 21h
    sub al,30h
    mov [bx],al
    inc bx
loop arrayLoop2
    push offset series1 ; Agregar los parametros a la pila
    push offset series2
    push offset sorted
    call Merge 
    push offset sorted
    call sortArr
    call linedrop
    mov ah,9
    mov dx,offset sortedarrmsg
    int 21h
    call linedrop
    mov cx,lenseries1+lenseries2
    mov bx,offset sorted
    printArray:
    mov dl,[bx] ; mov a dl con el arreglo para imprimir
    mov ah,2
    int 21h
    inc bx
    loop printArray
exit: 
    mov ax, 4c00h
    int 21h
END start 
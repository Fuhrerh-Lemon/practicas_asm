PANTALLA  equ  0b800h
;===========Definicion del segmento de codigo=================================
codigo segment
     pedirvariable DB '                                          11:34:00$'
     pos_x db 1 dup(1)  ;posicion  virtual en X
     assume CS:codigo
     org  100h           ;Dejar las 100h primeras posiciones

main:
     mov  ax,PANTALLA
     mov  es,ax
     mov  di,79
     mov  ax,es:[di]     ;Guardamos en AX lo que hay en la esquina
     inc  al             ;Pasamos al siguiente caracter
     mov  es:[di],ax     ;Lo mostramos por pantalla
     jmp instalar_reloj        ;Bifurcar a la rutina de instalacion

reloj proc far
     push ax es di cx bx      ;Guardamos los registros en la pila
     mov  al,0Ch         ;
     out  70h,al         ;
     in   al,71h         ;Leer el RTC
    
;pintar
     mov  ax,PANTALLA
     mov  es,ax
     mov  di,72*2
     ;Hour Part
    HOUR:
    MOV AH,2CH    ; Obtener tiempo en el sistema
    INT 21H
    MOV AL,CH     ; Hhoras HC
    AAM
    MOV BX,AX
    mov ah,7                ; reinicio en cero
     mov al, bh
     add al,30H     ; ASCII ajustes
     mov  es:[di],ax     ;Lo mostramos por pantalla
     add di,2
     mov al, bl
     add al,30H     ; ASCII ajustes
     mov  es:[di],ax     ;Lo mostramos por pantalla
     mov al,':'
     add di,2
     mov  es:[di],ax     ;Lo mostramos por pantalla
     add di,2
     MINUTES:
    MOV AH,2CH    ; Obtener sistema del computador
    INT 21H
    MOV AL,CL     ; Minutos en Cl
    AAM
    MOV BX,AX
    mov ah,7                ; reinicio en cero
     mov al, bh
     add al,30H     ; ASCII Adjustment
     mov  es:[di],ax     ;Lo mostramos por pantalla
     add di,2
     mov al, bl
     add al,30H     ; ASCII Adjustment
     mov  es:[di],ax     ;Lo mostramos por pantalla
     mov al,':'
     add di,2
     mov  es:[di],ax     ;Lo mostramos por pantalla
     add di,2
   
    ;Seconds Part
    Seconds:
    MOV AH,2CH    ; Obtener del sistema
    INT 21H
    MOV AL,DH     ; Segundos a DH
    AAM
    MOV BX,AX
    mov ah,7                ; reinicio en cero
    mov al, bh
     add al,30H     ; ASCII Ajustes
     mov  es:[di],ax     ;Lo mostramos por pantalla
     add di,2
     mov al, bl
     add al,30H     ; ASCII Ajustes
     mov  es:[di],ax     ;Lo mostramos por pantalla
; termino de pintar
     cli                 ;Inhabilitar las interrupciones
     mov  al,20h
     out  20h,al
     out  0A0h,al
     sti                 ;Habilitar las interrupciones
     pop bx cx di es ax             ;Recuperar los registros
     iret
reloj endp

instalar_reloj proc far

     cli                             ;Inhabilitar las interrupciones
     xor  ax,ax                      ;
     mov  es,ax                      ;Poner a 0 ES
     mov es:[70h*4],offset reloj     ;Guardar el offset
     mov es:[70h*4+2],cs             ;y el segmento de la rutina

     in   al,0A1h        ;Leer el PIC esclavo
     and  al,11111110b   ;
     out  0A1h,al        ;Activamos IR0

     in   al,21h         ;Leer el PIC maestro
     and  al,11111011b   ;
     out  21h,al         ;Activado

     mov  al,0Ah         ;Vamos a escribir en el registro A del RTC
     out  70h,al         ;
     mov  al,2Fh         ;Los simbolos se intercambian cada medio segundo
     out  71h,al         ;Lo indicamos en el registro A del RTC

     mov  al,0Bh         ;Vamos a escribir en el registro B del RTC
     out  70h,al
     in   al,71h
     or   al,01000000b   ;
     out  71h,al         ;Activamos las interrupciones periodicas
     sti                 ;Habilitar las interrupciones
     lea dx,instalar_reloj
     int  27h
instalar_reloj endp
codigo ends
     end main
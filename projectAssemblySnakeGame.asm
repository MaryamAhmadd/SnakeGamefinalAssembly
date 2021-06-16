org 100h
jmp start
oldisr: dd 0
dead: dw 0
s: dw 1200,6449,4000,2200
delayl: dw 45
tickcount1: dw 0
GameOver:db 'Game Over !'
hh: dw 3
lifes: db 3,0x33
lifeDisplay: db 'lifes:  /3'
locB:  times 240 dw 0
loch:  dw 0
fruit: db '*'
fruitL: times 50 dw 3256,1878,2000,2840,1056,3700,1510,3760,696,1620
nfruit: db '#'
nfruitL: times 30 dw 1452,2016,520,2556,2110,850,1002,3100,890,1700	
nfruitf: dw 1, 0
fruitf: dw 1 , 0                 ; 1 for eat 0 for not  ;index
snake_size: dw 20
sb: db '+'
SnakeBody: db '++++++++++++++++++++'
SnakeHead: db '@'
up_down_flag: dw 0
movemet: dw 1                   ;1->right...2->left...3->up...4->down
score: dw 0
Score: db 'Score:'
DFruit: db 'x'
DFruitf: dw 1, 0                  ; 1 for eat 0 for not  ;index
DFruitL: times 30 dw 1526, 3780,504,3620, 1050 , 2820 , 2004 , 1888 , 3240
Plevel: db 'Level:'
Nlavel: db 0x31
START: db 'Press Enter To START !'
stf: dw 0
TIME: db 'TIME::'
tickcount: dw 0
Seconds: dw 0
Minutes: dw 0
x: db '0'
Y: db 0xC,9,0
dollar: db '$'
ddlc: dw 0
dlc: dw 1670,2500
levelc: dw 1
lc1: dw 0
lc2: dw 0
lc3: dw 0
lc4: dw 0
lc5: dw 0
mode: dw 0
modes: db 'Press 1 for "Simple" Mode' ;25
	   db 'Press 2 for "LEVELS" Mode' ;25
	   
inst1: dw 0
inst2: dw 0
NoLife: db 'No Life' ;7
instructions:  db 'Instructions:' ;10
			   db 'You Have 4 minutes to earn score after that game will end' ;32+25
			   db 'There are 3 different fruits' ;28
			   db '* will give you 5 scores' ;24
               db 'x will deduct 5 scores' ;22
			   db '# will reduce size of snake' ;27
			   db '$ will give you 100 marks but will only appear for 30 seconds' ;61
			   db 'If snakes touches itself you lose 1 life' ;40
			   db 'If snakes touches border or any other hurdle you will loose one life' ;68
			   
instructions1: db 'You have total 3 lives' ;22
			   db 'Good Luck !' ;11
               db 'Press Enter to continue' ;23			
			   
instructions2: db 'You have no lives' ;17
			   db 'There are total 4 stages(levels)' ;32 
			   db 'You have to score 10 to reach level 2' ;37
			   db 'You have to score 20 to reach level 3' ;37
			   db 'You have to score 35 to reach level 4' ;37
			   db 'You have to score 70 to reach level 5' ;37
			   db 'You have to score 105 to reach level 6' ;38
			   db 'Good Luck !' ;11
               db 'Press Enter to continue' ;23
YS: db 'Your Score:'			   
;----------------------------------------------------Your Score---------------------------------------------------------

Yscore:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es		
	
	mov ax,0xb800
	mov es,ax
	mov di,1180
	mov si,YS
	mov cx,11
	mov ah,3
ysm:
	lodsb
	stosw
	loop ysm
	mov ax,3
	push ax	
	push word[score]
	mov ax,di
	push di
	call printnum
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret			   
			   
;---------------------------------------------------No Life-----------------------------------------------------

noLife:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es		
	
	mov ax,0xb800
	mov es,ax
	mov di,162
	mov si,NoLife
	mov cx,7
	mov ah,3
usm:
	lodsb
	stosw
	loop usm	

	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret	
;-----------------------------------------------------SOUND------------------------------------------------------

SOUND:
	push bp
	mov bp,sp
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
        mov     al, 182         ; Prepare the speaker for the
        out     43h, al         ;  note.
        mov     ax, [bp+4] ;1612       ;6449        ; Frequency number (in decimal)
                                ;  for middle C.
        out     42h, al         ; Output low byte.
        mov     al, ah          ; Output high byte.
        out     42h, al 
        in      al, 61h         ; Turn on note (get value from
                                ;  port 61h).
        or      al, 00000011b   ; Set bits 1 and 0.
        out     61h, al         ; Send new value.
        mov     bx, 1          ; Pause for duration of note.
pause1:
        mov     cx, 65535
pause2:
        dec     cx
        jne     pause2
        dec     bx
        jne     pause1
        in      al, 61h         ; Turn off note (get value from
                                ;  port 61h).
        and     al, 11111100b   ; Reset bits 1 and 0.
        out     61h, al         ; Send new value.
	
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret 2			   

;-----------------------------------------------------Display instruction-----------------------------------------

DINS:
	 push es
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	 
	 mov ax,0xb800
	 mov es,ax
	 mov di,810
	 mov ah,4
	 mov si,instructions
	 mov cx,13
DI1:
	 lodsb
	 stosw
     loop DI1
     mov cx,57
	 mov di,970
DI2:
	 lodsb
	 stosw
     loop DI2
	  mov cx,28
	 mov di,1130
DI3:
	 lodsb
	 stosw
     loop DI3
	  mov cx,24
	 mov di,1290
DI4:
	 lodsb
	 stosw
     loop DI4
	  mov cx,22
	 mov di,1450
DI5:
	 lodsb
	 stosw
     loop DI5
	  mov cx,27
	 mov di,1610
DI6:
	 lodsb
	 stosw
     loop DI6
	 mov cx,61
	 mov di,1770
DI7:
	 lodsb
	 stosw
     loop DI7
	 mov cx,40
	 mov di,1930
DI8:
	 lodsb
	 stosw
     loop DI8
	 mov cx,68
	 mov di,2090
DI9:
	 lodsb
	 stosw
     loop DI9
	 cmp word[inst2],0
	 jne SDI2
	 mov si,instructions1
	 mov cx,22
	 mov di,2250
LDI2:
	 lodsb
	 stosw
     loop LDI2
	 mov cx,11
	 mov di,2410
LLDI2:
	 lodsb
	 stosw
     loop LLDI2
	  mov cx,23
	 mov di,2570
	 mov ah,10000100b
LLDI23:
	 lodsb
	 stosw
     loop LLDI23
	 jmp LB
SDI2:
	  mov si,instructions2
	 mov cx,17
	 mov di,2250
SSDI2:
	 lodsb
	 stosw
     loop SSDI2
	 mov cx,32
	 mov di,2410
SSDI3:
	 lodsb
	 stosw
     loop SSDI3
	 mov cx,37
	 mov di,2570
SSDI4:
	 lodsb
	 stosw
     loop SSDI4	 
	 mov cx,37
	 mov di,2730
SSDI5:
	 lodsb
	 stosw
     loop SSDI5
	 mov cx,37
	 mov di,2890
SSDI6:
	 lodsb
	 stosw
     loop SSDI6
	 mov cx,37
	 mov di,3050
SSDI44:
	 lodsb
	 stosw
     loop SSDI44	 
	 mov cx,38
	 mov di,3210
SSDI55:
	 lodsb
	 stosw
     loop SSDI55
	 mov cx,11
	 mov di,3370
SSDI7:
	 lodsb
	 stosw
     loop SSDI7
	 mov cx,23
	 mov di,3530
	 mov ah,10000100b
SSDI77:
	 lodsb
	 stosw
     loop SSDI77
LB:
	 call Border
	 
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 pop es
	 ret			   
			   
;-----------------------------------------------------Print dollar-------------------------------------------------

Pdollar:
	
	 push bp
	 mov bp,sp
	 push es
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	
	 mov ax,0xb800
	 mov es,ax
	 cmp word[bp+4],0
	 je spc
	 jne spc1
spc:
	 mov ax,0x720
	 mov bx,[ddlc]
	 mov di,[dlc+bx]
     mov word[es:di],ax
     jmp pde
spc1:	 
	 mov ah,0x8c;10001100b
	 mov al,[dollar]
	 mov bx,[ddlc]
	 mov di,[dlc+bx]
pd3:	
	mov di,[dlc+bx]
	mov dx,[es:di]
	cmp dx,0x720
	jne pd2
	je pd1
pd1:
	mov word[es:di],ax
	jmp pde
pd2:
	add bx,2
	add word[ddlc],2
	jmp pd3
pde:	
	 ;92
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 pop es
	 pop bp 
	 ret 2

;-----------------------------------------------------Print Time----------------------------------------------------

Print_Time:
	 push es
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	
	 mov ax,0xb800
	 mov es,ax
	 mov ah,0xC
	 mov si,TIME
	 mov di,274
	 mov cx,5
P_T:	 
	 lodsb
	 stosw
	 loop P_T
	 lodsb
	 mov ah,10001100b
	 mov di,288
	 mov word[es:di],ax
	 ;92
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 pop es
	 ret

;-----------------------------------------------------PRINT START---------------------------------------------------

Print_Start:
	 push es
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	
	 mov ax,0xb800
	 mov es,ax
	 mov ah,10001100b
	 mov si,START
	 mov di,1820
	 mov cx,22
P_S:	 
	 lodsb
	 stosw
	 loop P_S
	 
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 pop es
	 ret

;-----------------------------------------------------Print level---------------------------------------------------
Print_Level:
	 push es
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	
	 mov ax,0xb800
	 mov es,ax
	 mov ah,6
	 mov si,Plevel
	 mov di,184
	 mov cx,6
P_L:	 
	 lodsb
	 stosw
	 loop P_L
	 mov al,[Nlavel]
	 mov word[es:di],ax
	 
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 pop es
	 ret
;-----------------------------------------------------Level 2--------------------------------------------------------

level2:
	 push es
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	 
	 mov ax,0xb800
	 mov es,ax
	 mov ah,5
	 mov al,'/'
	 mov di,1060
	 mov cx,20
l_v2:	 
	 mov word[es:di],ax
	 add di,2
	 loop l_v2
     mov di,1700
     mov cx,20	
l_v3:	 
	 mov word[es:di],ax
	 add di,2
	 loop l_v3
     mov di,2260
     mov cx,20
l_v4:	 
	 mov word[es:di],ax
	 add di,2
	 loop l_v4	
     mov di,2900
     mov cx,20
l_v5:	 
	 mov word[es:di],ax
	 add di,2
	 loop l_v5
	 
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 pop es
	 ret

;------------------------------------------------------level3--------------------------------------------------------

level3:
	 push es
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	
	 mov ax,0xb800
	 mov es,ax
	 mov ah,5
	 mov al,'/'
	 mov di,520
	 mov cx,40
l_v22:	 
	 mov word[es:di],ax
	 add di,2
	 loop l_v22
     
     mov cx,5	
l_v32:	 
	 mov word[es:di],ax
	 add di,160
	 loop l_v32
	 add di,1120
     mov cx,5	
l_v42:	 
	 mov word[es:di],ax
	 add di,160
	 loop l_v42
	 
	 mov cx,40
	 
l_v52:	 
	 mov word[es:di],ax
	 sub di,2
	 loop l_v52
     mov cx,6
l_v62:	 
	 mov word[es:di],ax
	 sub di,160
	 loop l_v62	
	 mov di,520
	 mov cx,6
l_v72:	 
	 mov word[es:di],ax
	 add di,160
	 loop l_v72
	 mov si,4
     mov di,656
lv88:
	 mov dx,di
     mov bx,3
	 mov ah,10001110b
	 mov al,'+'
	 mov cx,5
l_v88:
	 mov word[es:di],ax
	 add di,2
	 loop l_v88
	 sub bx,1
	 add dx,160
	 mov di,dx
     mov cx,5
     cmp bx,0
     jne l_v88	
	 sub si,1
	 cmp si,3
	 je sql2
	 cmp si,2
	 je sql3
	 cmp si,1
	 je sql4
	 jmp sql5
sql2:
     mov di,2576
	 jmp lv88
sql3:
     mov di,2696
	 jmp lv88
sql4:
	 mov di,776
	 jmp lv88
sql5:	 
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 pop es
	 ret
	 
	 
;------------------------------------------------------level4--------------------------------------------------------

level4:
	 push es
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	
	 mov ax,0xb800
	 mov es,ax
	 mov ah,14
	 mov al,'+'
	 mov si,10
     mov di,656
lv889:
	 mov dx,di
     mov bx,3
	 mov cx,5
l_v889:
	 mov word[es:di],ax
	 add di,2
	 loop l_v889
	 sub bx,1
	 add dx,160
	 mov di,dx
     mov cx,5
     cmp bx,0
     jne l_v889	
	 sub si,1
	 cmp si,3
	 je sql22
	 cmp si,2
	 je sql33
	 cmp si,1
	 je sql44
	 cmp si,4
	 je sql55
	 cmp si,5
	 je sql6
	 cmp si,6
	 je sql7
	 cmp si,7
	 je sql8
	 cmp si,8
	 je sql9
	 cmp si,9
	 je sql10
	 jmp sql11
sql22:
     mov di,2896
	 mov ah,14
	 jmp lv889
sql33:
     mov di,3016
	 mov ah,14
	 jmp lv889
sql44:
	 mov di,776
	 mov ah,14
	 jmp lv889
sql55:
     mov di,2936
	 mov ah,12
	 jmp lv889
sql6:
     mov di,2976
	 mov ah,12
	 jmp lv889
sql7:
     mov di,696
	 mov ah,12
	 jmp lv889
sql8:
     mov di,736
	 mov ah,12
	 jmp lv889
sql9:
     mov di,1616
	 mov ah,10001101b
	 jmp lv889
sql10:
     mov di,1736
	 mov ah,10001101b
	 jmp lv889	 	 
sql11:	 
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 pop es
	 ret

;------------------------------------------------------level5-------------------------------------------------------

level5:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	mov ax,0xb800
	mov es,ax
	mov ah,00000010b
	mov al,'='
	mov di,680
	mov si,2
	mov dx,di
	mov bx,5
	mov cx,40
kk:
	mov word[es:di],ax
	add di,2
	loop kk
	add dx,160
	mov di,dx
	sub bx,1
	add ah,1
	mov cx,40
	cmp bx,0
	jne kk
	add dx,1120
	mov di,dx
	mov bx,5
	mov cx,40
	mov ah,00000010b
	sub si,1
	cmp si,0
	jne kk
	mov di,980
	mov ah,10000010b
	mov cx,13
kk1:
	mov word[es:di],ax
	add di,160
	add ah,1
    loop kk1	
	mov di,1100
	mov ah,10000010b
	mov cx,13
kk2:
	mov word[es:di],ax
	add di,160
	add ah,1
    loop kk2	
	
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret	 

;-----------------------------------------------------level 6-------------------------------------------------------

level6:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	mov ax,0xb800
	mov es,ax
	mov ah,00000010b
	mov al,'='
	mov di,670
	mov cx,50
gg1:
	mov word[es:di],ax
    add di,2
	loop gg1
	mov di,670
	mov ah,3
	mov al,'='
	mov cx,9
gg2:
	mov word[es:di],ax
    add di,160
	loop gg2
	mov al,'='
	mov ah,4
	mov cx,50
gg3:
	mov word[es:di],ax
    add di,2
	loop gg3	

	mov ah,5
	mov cx,7
gg5:
	mov word[es:di],ax
    add di,160
	loop gg5
	
	mov ah,6
	mov cx,50
gg4:
	mov word[es:di],ax
    sub di,2
	loop gg4		
	
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
	
;------------------------------------------------------Score---------------------------------------------------------

Display_Score:
	 push es
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	
	 mov ax,0xb800
	 mov es,ax
	 mov ah,9
	 mov si,Score
	 mov di,296
	 mov cx,6
D_S:	 
	 lodsb
	 stosw
	 loop D_S
	 push word[Y+1]
	 push word[score]
	 mov ax,308
	 push ax
	 call printnum
	 
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 pop es
	 ret
	 
;------------------------------------------------------PRINT_NUMBER----------------------------------------------------

printnum:
	 push bp
	 mov bp, sp
	 push es
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	 
	 mov ax, 0xb800
	 mov es, ax ; point es to video base
	 mov ax, [bp+6] ; load number in ax
	 mov bx, 10 ; use base 10 for division
	 mov cx, 0 ; initialize count of digits
	 mov si,0
nextdigit: 
	 mov dx, 0 ; zero upper half of dividend
	 div bx ; divide by 10
	 add dl, 0x30 ; convert digit into ascii value
	 push dx ; save ascii value on stack
	 inc cx ; increment count of values
	 add si,1 
	 cmp ax, 0 ; is the quotient zero
	 jnz nextdigit ; if no divide it again
	 cmp si,1
	 je p2
	 jne p3
p2:
	mov ah,[bp+8]
	mov al,[x]
	mov di,[bp+4]
	mov word[es:di],ax
	add di,2
	jmp nextpos	
p3:
	 mov di, [bp+4] ; point di to top left column 
	 
nextpos:
	 pop dx ; remove a digit from the stack
	 mov dh, [bp+8] ; use normal attribute
	 mov [es:di], dx ; print char on screen
	 add di, 2 ; move to next screen location
	 loop nextpos ; repeat for all digits on stack
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 pop es
	 pop bp
	 ret 6

;-------------------------------------------------------------DRaw Snake---------------------------------------------------------

Draw_Snake:

	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	
	mov ax,0xb800
	mov es,ax
	mov bx,0
	mov ah,4
	mov al,[sb]
	mov cx,[snake_size]
DS1:
	mov di,[locB+bx]
	mov word[es:di],ax
	add bx,2
	loop DS1	

	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
	
;---------------------------------------------------------display modes-------------------------------------------------------

DMODE:
	 push es
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	 
	 mov ax,0xb800
	 mov es,ax
	 mov di,1650
	 mov ah,4
	 mov si,modes
	 mov cx,25
DM1:
	 lodsb
	 stosw
     loop DM1
     mov cx,25
	 mov di,2130
DM2:
	 lodsb
	 stosw
     loop DM2
	 mov di,1320
	 mov cx,35
	 mov ah,2
	 mov al,'X'
	 rep stosw
	 mov cx,10
DM3:
	 mov word[es:di],ax
	 add di,160
     loop DM3
     mov cx,35
DM4:
	 mov word[es:di],ax
	 sub di,2
     loop DM4
     mov cx,10
DM5:
	 mov word[es:di],ax
	 sub di,160
     loop DM5	 
	 
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 pop es
	 ret 	
	
;---------------------------------------------------------Make Dangerous Fruit--------------------------------------------------

Generate_DFruit:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	
	mov ax,0xb800	
	mov es,ax
	mov ax,0
	mov ah,2
	mov al,[DFruit]
	mov bx,[DFruitf+2]

gdf3:	
	mov di,[DFruitL+bx]
	mov dx,[es:di]
	cmp dx,0x720
	jne gdf2
	je gdf1
gdf1:
	mov word[es:di],ax
	add word[DFruitf+2],2
	jmp gdfe
gdf2:
	add bx,2
	mov word[DFruitf+2],bx
	jmp gdf3
gdfe:	
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
 	
;-------------------------------------------------------------Make fruit---------------------------------------------------------

Generate_Fruit:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	
	mov ax,0xb800	
	mov es,ax
	mov ax,0
	mov ah,0xC
	mov al,[fruit]
	mov bx,[fruitf+2]

gf3:	
	mov di,[fruitL+bx]
	mov dx,[es:di]
	cmp dx,0x720
	jne gf2
	je gf1
gf1:
	mov word[es:di],ax
	add word[fruitf+2],2
	jmp gfe
gf2:
	add bx,2
	mov word[fruitf+2],bx
	jmp gf3
gfe:	
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
	
;-------------------------------------------------------------Make Nfruit---------------------------------------------------------

Generate_NFruit:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	
	mov ax,0xb800	
	mov es,ax
	mov ax,0
	mov ah,3
	mov al,[nfruit]
	mov bx,[nfruitf+2]

nf3:	
	mov di,[nfruitL+bx]
	mov dx,[es:di]
	cmp dx,0x720
	jne nf2
	je nf1
nf1:
	mov word[es:di],ax
	add word[nfruitf+2],2
	jmp nfe
nf2:
	add bx,2
	mov word[nfruitf+2],bx
	jmp nf3
nfe:	
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
	
;------------------------------------------------------------Keyboard interupts -------------------------------------------------

kbisr:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	mov ah,0xE0
	in al,0x60
	cmp al,0x48
	je Up
	jne next1
next1:

	cmp al,0x4B
	je left
	jne next2
next2:
	cmp al,0x50
	je down
	jne next3
next3:
	cmp al,0x4D
	je right
	jne next4
next4:
	cmp al,0x1C
	je strt
	jne next5	
next5:
	cmp al,0x02
	je onee
	jne next6
next6:
	cmp al,0x03
	je two
	jne KBE1	
strt:
	mov word[stf],1
	mov word[inst1],1
	jmp KBE1	
Up:	
	cmp word[movemet],4
	je KBE1
	mov ax,3
	mov word[movemet],ax
	jmp KBE1
left:
	cmp word[movemet],1
	je KBE
	mov ax,2
	mov word[movemet],ax
	jmp KBE
KBE1:
	jmp KBE	
down:	
	cmp word[movemet],3
	je KBE
	mov ax,4
	mov word[movemet],ax
	jmp KBE
right:
	cmp word[movemet],2
	je KBE
	mov ax,1
	mov word[movemet],ax
	jmp KBE	
onee:
	mov word[mode],1
	mov word[inst2],0
	mov word[inst1],1
    jmp KBE
two:
	mov word[mode],0
	mov word[inst2],1
	mov word[inst1],1
    jmp KBE
KBE:
	mov al,0x20
	out 0x20,al
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	iret
	
;---------------------------------------------------------delay inc------------------------------------------------------------

delayinc:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
     
	cmp word[cs:tickcount1],360      ;0:20
	je di1
	cmp word[cs:tickcount1],720      ;0:40
	je di1 
	cmp word[cs:tickcount1],1080      ;0:60
	je di1
	cmp word[cs:tickcount1],1440     ;1:20 -> 80
	je di1 
	cmp word[cs:tickcount1],1800      ;1:40 -> 100
	je di1
	cmp word[cs:tickcount1],2160      ;2:00 ->120
	je di1
	jne di2
di1:
	sub word[cs:delayl],4                 ;delay
	jmp die
di2:	
	cmp word[cs:tickcount1], 2520     ;2:20 ->140
	je di1
	cmp word[cs:tickcount1],2880      ;2:40 ->160
	je di1
	cmp word[cs:tickcount1],3240      ;3:00 ->180
	je di1
	cmp word[cs:tickcount1],3600      ;3:20 ->200
	je di1 
	cmp word[cs:tickcount1],3960      ;3:40 ->220
	je di1
die:	
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret	
	
;---------------------------------------------------------Timmer Interupt-------------------------------------------------------

timer:
	 push ax
	 push bx
	 push di
	 push dx
	 push cx
	 
	 inc word[cs:tickcount1]
	 inc word [cs:tickcount]; increment tick count
	 mov dx,0
	 cmp byte[cs:lifes],dl
	 je eet1
	 call delayinc
	 cmp word [cs:tickcount1],3240
	 je lll
	 cmp word [cs:tickcount1],3600
	 je lll2
	 jmp lll3
lll:
	 mov cx,1
	 push cx
	 call Pdollar
	 jmp lll3
lll2:
	 mov cx,0
	 push cx
	 call Pdollar
	 jmp lll3	
lll3:	 
	 cmp word [cs:tickcount],18
	 je Timel                                     ;8c
	 jne Time2
eet1:
	 jmp ETT	
Timel:
	 mov bx,0
	 mov word [cs:tickcount],bx
	 add word [cs:Seconds],1
	 cmp word[cs:Seconds],60
	 je addmin
	 jne Time2
addmin:
	 mov word[cs:Seconds],0
	 add word[cs:Minutes],1
	 cmp word[cs:Minutes],4
	 je endg
	 jne Time2
endg:
	 mov byte[cs:lifes],0
	 jmp ETT
Time2:
	 push word[cs:Y+0]
	 push word [cs:Minutes]
	 mov di,284
	 push di
	 call printnum ; print tick count
	 push word[cs:Y+0]
	 push word [cs:Seconds]
	 mov di,290
	 push di
	 call printnum ; print tick count
	 jmp ET
ETT:
	 push word[cs:Y+2]
	 push word [cs:Minutes]
	 mov di,284
	 push di
	 call printnum ; print tick count
	 push word[cs:Y+2]
	 push word [cs:Seconds]
	 mov di,290
	 push di
	 call printnum ; print tick count
	 jmp ET	
ET:
	 mov al, 0x20
	 out 0x20, al ; end of interrupt
	 
	 pop cx
	 pop dx
	 pop di
	 pop bx
	 pop ax
	 iret ; return from interrupt 	
	
;------------------------------------------------------------GameOver-----------------------------------------------------------

Game_Over:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	
	call ClrScr
	mov ax,0xb800
	mov es,ax
	mov cx,11
	mov si,GameOver
	mov di,1500
	mov ah,10001100b
GO1:	
	lodsb
	mov word[es:di],ax
	add di,2
	loop GO1
	
	call Yscore
	
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret

;---------------------------------------------------------------life------------------------------------------------------------
Life:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	
	mov ax,0xb800
	mov es,ax
	mov cx,10
	mov si,lifeDisplay
	mov di,162
	mov bx,0
	mov ah,3
lif1:	
	lodsb
	mov word[es:di],ax
	add di,2
	loop lif1
	mov di, 174
	mov al,[lifes+1]
	mov word[es:di],ax
	
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret

;-----------------------------------------------------------------Make snake----------------------------------------------------

MakeSnake:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	push ds
	mov ax,[snake_size]
	mov word[snake_size],ax
	mov ax,0xb800
	mov es,ax
	mov di,1520
	mov si,SnakeBody
	mov cx,240
	mov ah,4
	mov bx,0
	cld 
MR2:
	mov word[locB+bx],di
	sub di,2
	add bx,2
	loop MR2
	mov di,1522
	mov word[loch],di
	mov cx,20
	mov di,1520
MS1:
;	call Delay
	lodsb
	mov word[es:di],ax
	sub di,2
	loop MS1
	mov di,[loch]
	mov si,SnakeHead
	mov ah,6
	lodsb
	stosw
	mov ax,0
	pop ds
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
;------------------------------------------------------delay--------------------------------------------------------------------

Delay:
	push cx
	push dx
	mov dx,[delayl]
	mov cx,10000
D1:	
	loop D1
	mov cx,10000
	sub dx,1
	cmp dx,0
	jne D1
	mov dx,10000

	pop dx
	pop cx
	ret
	
;---------------------------------------------------------NEW---------------------------------------------------------------------

NEW:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	push ds
	cmp word[levelc],2
	je n2
	cmp word[levelc],3
	je n3
	cmp word[levelc],4
	je n4
	cmp word[levelc],5
	je n5
	cmp word[levelc],6
	je n6
	jmp n1
n2:
	call level2
	jmp n1
n3:
	call level3
	jmp n1
n4:
	call level4
	jmp n1	
n5:
	call level5
	jmp n1
n6:
	call level6
	jmp n1		
n1:	
	call Print_Time
	call MakeSnake
	call Display_Score
	call Border
    cmp word[mode],1
	je pl11
	jne pl22
pl11:
	call Life
	call Generate_NFruit
	call Generate_DFruit
	jmp pl33
pl22:
	call noLife
	call Print_Level
pl33:
	call Generate_Fruit
	
	pop ds
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
	
;--------------------------------------------------------deprint---------------------------------------------------------------

Dprint:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	push ds
	
	mov ax,0xb800
	mov es,ax
	mov bx,[snake_size]
	add bx,bx
	mov ax,0x720
	mov cx,4
DP:	
	mov di,[locB+bx]
	mov word[es:di],ax
	add bx,2
	loop DP	
	
	pop ds
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret	
	
;-------------------------------------------------------levels------------------------------------------------------------------

levels:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	push ds
	
	cmp word[levelc],2
	je ls2
	cmp word[levelc],3
	je ls3
	cmp word[levelc],4
	je ls4
	cmp word[levelc],5
	je ls3
	cmp word[levelc],6
	je ls4
	jmp lse
ls2:
	mov word[lc1],1
	call ClrScr
	add byte[Nlavel],0x01
	mov word[snake_size],20              ; optional if size is to be revived after one death
	mov word[movemet],1
	call NEW
;	call level2
	jmp lse
ls3:
	mov word[lc2],1
	call ClrScr
	add byte[Nlavel],0x01
	mov word[snake_size],20              ; optional if size is to be revived after one death
	mov word[movemet],1
	call NEW
;	call level3
	jmp lse
ls4:
	mov word[lc3],1
	call ClrScr
	add byte[Nlavel],0x01
	mov word[snake_size],20              ; optional if size is to be revived after one death
	mov word[movemet],1
	call NEW
	jmp lse
;	call level4	
ls5:
	mov word[lc4],1
	call ClrScr
	add byte[Nlavel],0x01
	mov word[snake_size],20              ; optional if size is to be revived after one death
	mov word[movemet],1
	call NEW
;	call level3
	jmp lse
ls6:
	mov word[lc5],1
	call ClrScr
	add byte[Nlavel],0x01
	mov word[snake_size],20              ; optional if size is to be revived after one death
	mov word[movemet],1
	call NEW

lse:	
	pop ds
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret	

;-------------------------------------------------------dead---------------------------------------------------------------------

DEAD:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	push ds
	
	cmp word[mode],1
	je mm 
	jne DEND1
;	mov al,[lifes+0]
;	sub al,1
mm:
	mov word[dead],0
	sub byte[lifes+0],1
	sub word[hh],1
;	mov al,[lifes+1]
;	sub al,0x01
	sub byte[lifes+1],0x01
	mov ax,0
	mov word[movemet],1
	push word[s+4]
	call SOUND
	push word[s+4]
	call SOUND
	push word[s+4]
	call SOUND
;	mov word[fruitf+2],0
;	mov word[DFruitf+2],0
	call ClrScr
	mov word[snake_size],20              ; optional if size is to be revived after one death
	call NEW
	jmp DEND
DEND1:
	mov byte[lifes],0
	; cmp word[hh],1
	; je dend2
	; jne DEND
; dend2:	
	; call Game_Over
; D:	
	; jmp D
DEND:
	
	pop ds
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
;-----------------------------------------------------move generic----------------------------------------------------------------

MoveR:                                  ;(takes one parameter location and other adding location)
	push bp
	mov bp,sp
	
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	push ds
	jmp mrrr
	
de1:
	mov word[dead],1
	call DEAD
	jmp MRE3
mmm:
	mov byte[lifes],0
	call Game_Over
	jmp MRE3	
mrrr:	
	cmp byte[lifes],0
	je  mmm
	cmp word[snake_size],244
	je mmm
	cmp word[snake_size],0
	je mmm
	mov ax,0xb800
	mov es,ax
	mov bx,[snake_size]
	add bx,bx
;	sub bx,2
; condition for touching itself	
	mov ax,[locB+bx]
	mov si,ax
	mov ax,[loch]
	mov di,ax
	mov dx,ax
	mov ax,[es:di]
	cmp word[bp+4],0
	je MRD
	jmp MRU	
MRD:
	add di,[bp+6]
	jmp MR3
MRU:
	sub di,[bp+6]
	jmp MR3
MRE3:
	jmp MRE2
MR3:
	mov bx,[es:di]
	cmp bx,0xC2A
	je fm
	cmp bx,0x278
	je dmm
	cmp bx,1000110000100100b
	je lmm
	cmp bx,0x0323
	je MSS2
	cmp bx,0x720
	je fccc
	jne de1	
fm:
	mov cx,[snake_size]
	add cx,4
	mov word[snake_size],cx
	push word[s+2]
	call SOUND
	;add word[fruitf+2],2
	add word[score],5
dc:	
	cmp word[mode],1
	je feee
	cmp word[score],10
	je lev2
	cmp word[score],20
	je lev3
	cmp word[score],35
	je lev4
	cmp word[score],75
	je lev5
	cmp word[score],105
	je lev6
	jmp fee
dmm:
	jmp dm	
lmm:
	jmp lm
MSS2:
	jmp MS2
fccc:
	jmp fcc	
feee:
	jmp fee	
lev5:
	mov word[levelc],5
	cmp word[lc4],0
	je levl1
	jmp fee
lev6:
	mov word[levelc],6
    cmp word[lc5],0
	je levl1
	jmp fee	
lev2: 
	mov word[levelc],2
	cmp word[lc1],0
	je levl1
	jmp fee
fcc:
	jmp fe
lev3:
	mov word[levelc],3
	cmp word[lc2],0
	je levl1
	jmp fee
lev4:
	mov word[levelc],4
    cmp word[lc3],0
	je levl1
	jmp fee
levl1:
	call levels
	jmp MRE2
fee:
	call Display_Score
	call Generate_Fruit
	jmp fe
lm: 
	push word[s+2]
	call SOUND
	add word[score],100
	call Display_Score
	jmp fe	
dm:
	push word[s+2]
	call SOUND
	cmp word[score],0
	je MS22
	sub word[score],5
MS22:
	call Display_Score
	call Generate_DFruit
	jmp fe	
fe:	
	mov word[es:di],ax
	mov ax,di
	mov word[loch],ax
	mov cx,240
	mov bx,0
	jmp MR1
MS2:
	push word[s+2]
	call SOUND
	mov cx,[snake_size]
	sub cx,4
	mov word[snake_size],cx
	call Dprint
	call Generate_NFruit
	jmp fe	
MR1:	
	 mov ax,[locB+bx]
	 mov di,ax	
	 mov di,dx
	 mov ax,dx
	 mov ax,[locB+bx]
	 mov dx,ax
	 mov ax,di
	 mov word[locB+bx],ax
	 add bx,2	
	 loop MR1
	 call Draw_Snake
	 	
MR4: 
	 mov di,si
	 mov ax,0x720
	 mov word[es:di],ax
	 mov ax,0
	 jmp MRE2
		
MRE2:
	
	pop ds
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret 4
		
;------------------------------------------------------ClrScr--------------------------------------------------------------------

ClrScr:
	push es
	push ax
	push cx
	push di
	
	mov ax,0xb800
	mov es,ax
	mov di,0
	mov ax,0x720
	mov cx,2000
	cld
	rep stosw
	
	pop di
	pop cx
	pop ax
	pop es
	ret

;------------------------------------------------------------Border--------------------------------------------------------------	
	
Border:
	push ax
	push cx
	push di
	push es
	mov ax,0xb800
	mov es,ax
	mov di,0
	mov cx,80	
	mov al,'/'
	mov ah,5
	rep stosw
	mov cx,80
	mov di,3840
	rep stosw
	mov cx,80
	mov di,160
b1:
	mov word[es:di],ax
	add di,160
	loop b1
	mov cx,80
	mov di,318
b2:
	mov word[es:di],ax
	add di,160
	loop b2
	
	pop es
	pop di
	pop cx
	pop ax	
	ret

kbis:

	push ax
	push bx
	push cx
	push dx
	push si
	push di
	push es
	push ds
	
	in al,0x60
	cmp al,0x1c
	je kb1
	jne kbe

kb1:
	call ClrScr	
	mov word[stf],1
kbe:
	mov al,0x20
	out 0x20,al
	
	pop ds
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	iret
	
;------------------------------------------------------------start----------------------------------------------------------------	
	
start:
	call ClrScr
	call Print_Start
	
	
	xor ax,ax
	mov es,ax
	cli 
	mov word[es:9*4],kbisr
	mov [es:9*4+2],cs
	sti
	call ClrScr
	call DMODE
SSD:
	cmp word[inst1],1
    jne SSD	
	mov word[inst1],0
	call ClrScr
	call DINS
SSD1:
    cmp word[inst1],1
    jne SSD1
	mov word[stf],0	
	call ClrScr
	call Print_Start	
SSR:
	cmp word[stf],1
	je SRR
	jne SSR
SRR:

	 xor ax, ax
	 mov es, ax ; point es to IVT base
	 mov ax,[es:8*4]; store offset at n*4
	 mov [oldisr],ax
	 mov ax,[es:8*4+2]
     mov [oldisr+2],ax	 ; store segment at n*4+2
	 cli ; disable interrupts
	 mov word [es:8*4], timer; store offset at n*4
	 mov [es:8*4+2], cs ; store segment at n*4+2
	 sti ; enable interrupts
	 
	call ClrScr
	call Border
	call MakeSnake
	call Print_Time
	cmp word[mode],1
	je pl1
	jne pl2
pl1:	
	call Life
	call Generate_DFruit
	call Generate_NFruit
	jmp pl3
pl2:
    call noLife
	call Print_Level
pl3:	
	call Display_Score
	call Generate_Fruit
	mov cx,30         ; right
SR1:	
	mov ax,2
	push ax
	mov ax,0
	push ax
	call MoveR
	push word[s]
	call SOUND
	push word[s+6]
	call SOUND
	call Delay
	cmp byte[lifes],0
;	cmp word[hh],0
	je go1
	cmp word[movemet],2
	je SL1
	cmp word[movemet],3
	je SU1
	cmp word[movemet],4
	je SD1
	jmp SR1
SU1:	
	mov ax,160
	push ax
	mov ax,1
	push ax
	call MoveR
	push word[s]
	call SOUND
	push word[s+6]
	call SOUND
	call Delay
	cmp byte[lifes],0
;	cmp word[hh],0
	je go1
	cmp word[movemet],2
	je SL1
	cmp word[movemet],1
	je SR1
	jmp SU1
go1:
	jmp geo	
SL1:	
	mov ax,2
	push ax
	mov ax,1
	push ax
	call MoveR
	push word[s]
	call SOUND
	push word[s+6]
	call SOUND
	call Delay
	cmp byte[lifes],0
;	cmp word[hh],0
	je geo
	cmp word[movemet],3
	je SU1
	cmp word[movemet],4
	je SD1
	jmp SL1
SD1:
	mov ax,160
	push ax
	mov ax,0
	push ax
	call MoveR
	push word[s]
	call SOUND
	push word[s+6]
	call SOUND
	call Delay
	cmp byte[lifes],0
	je geo
	cmp word[movemet],2
	je SL1
	cmp word[movemet],1
	je SR1
	jmp SD1	
geo:
	mov ax,[oldisr]
	mov bx,[oldisr+2]
	cli
	mov [es:8*4],ax
	mov [es:8*4+2],bx
	sti
	call Game_Over
	mov cx,10
jj:
		push word[s+2]
	call SOUND
		push word[s+4]
	call SOUND
		push word[s+2]
	call SOUND
		push word[s+4]
	call SOUND
		push word[s+2]
	call SOUND
		push word[s+4]
	call SOUND
	loop jj
	jmp infinite
infinite:
	jmp infinite
	
mov ax,4ch
int 21h
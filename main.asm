[org 0x0100]
jmp start

top_left:        db 218  ; '┌'
top_right:       db 191  ; '┐'
bottom_left:     db 192  ; '└'
bottom_right:    db 217  ; '┘'
horizontal:      db 196  ; '─'
vertical:        db 179  ; '│'
scr_print: dw 1
tickcount:    dw   0 
minute:       dw   0
store: db 0
col_temp: db 10
row_temp: db 8
col_counter: db 10
row_counter: db 10
box_counter: db 36
sbuffer: times 80*25 dw 0
dbuffer: times 80*25 dw 0



message:      db    'Welcome to sudoku game', 0  
message2:     db    'Enjoy!!', 0     
message3:     db    'Timer: ', 0
message4:     db    'Score: ', 0
message5:     db    'Mistakes 0/3', 0
message6:     db    'Press (u) for', 0
message61:    db     'undo',0
message7:     db    'Press (e) for', 0
message71:    db     'erase',0
message8:     db    'Press (n) to ', 0
message81:    db    'enable notes &',0
message82:    db     '(m) to disable ',0
message9:     db     'Notes:',0

return_message db 'Successfully returned from print loop!$'

row_mess: db "Enter row: $"
col_mess: db "Enter col: $"
in_mess: db "Enter input: $"
notes_mess: db "NOTES INPUT $"
index_mess: db "Enter notes index : $"

col_input_user: db 0
row_input_user: db 0
num_input_user: db 0

notes_col_input_user: db 0
notes_row_input_user: db 0
notes_num_input_user: db 0

d11: db 32,32,32
d12: db 32,32,124
d13: db 32,32,124

d21: db 32,95,32
d22: db 32,95,124
d23: db 124,95,32

d31: db 32,95,32
d32: db 32,95,124
d33: db 32,95,124

d41: db 32,32,32
d42: db 124,95,124
d43: db 32,32,124

d51: db 32,95,32
d52: db 124,95,32
d53: db 32,95,124

d61: db 32,95,32
d62: db 124,95,32
d63: db 124,95,124

d71: db 32,95,32
d72: db 32,32,124
d73: db 32,32,124

d81: db 32,95,32
d82: db 124,95,124
d83: db 124,95,124

d91: db 32,95,32
d92: db 124,95,124
d93: db 32,95,124

;consecutive zeros

board:
    db 5, 0, 4,  3, 2, 9,  8, 0, 1,  ; Row 1
    db 1, 0, 8,  5, 0, 7,  0, 9, 3,  ; Row 2
    db 9, 7, 0,  6, 1, 0,  5, 0, 4,  ; Row 3
    db 6, 0, 7,  4, 0, 2,  9, 3, 8,  ; Row 4
    db 4, 5, 9,  8, 7, 3,  2, 0, 6,  ; Row 5
    db 8, 0, 2,  9, 6, 1,  4, 5, 7,  ; Row 6
    db 3, 0, 5,  7, 0, 4,  1, 0, 2,   ; Row 7
    db 2, 0, 6,  0, 3, 5,  0, 4, 9,  ; Row 8
    db 7, 4, 1,  2, 0, 6,  3, 0, 5 ; Row 9

 notes1:
    times 9*9 dw 0
notes2:
    times 9*9 dw 0
notes3:
    times 9*9 dw 0
notes4:
    times 9*9 dw 0
    notes5:
    times 9*9 dw 0
notes6:
    times 9*9 dw 0
   

notes8:
    times 9*9 dw 0
    notes7:
    times 9*9 dw 0
     notes9: times 9*9 dw 0

  notes_box_count: db 0

     
     
  row_input: dw 0
  col_input : dw 0
  value_input : dw 0
  mistake_counter: dw 0
  seconds: dw 0


medium_board:
    db 0, 0, 4,  0, 2, 0,  8, 0, 1,  ; Row 1
    db 1, 0, 8,  0, 4, 7,  0, 9, 0,  ; Row 2
    db 9, 7, 0,  6, 0, 8,  0, 2, 4,  ; Row 3
    db 6, 0, 7,  0, 5, 2,  9, 0, 8,  ; Row 4
    db 4, 0, 9,  8, 0, 3,  2, 0, 6,  ; Row 5
    db 0, 3, 2,  0, 6, 1,  0, 5, 7,  ; Row 6
    db 3, 0, 5,  0, 8, 4,  0, 6, 2,   ; Row 7
    db 0, 8, 0,  1, 0, 5,  0, 4, 9,  ; Row 8
    db 7, 0, 1,  0, 9, 0,  3, 0, 5 ; Row 9

hard_board:
     db 0, 6, 4,  0, 2, 0,  8, 0, 1,  ; Row 1
    db 1, 0, 8,  0, 4, 7,  0, 9, 0,  ; Row 2
    db 9, 7, 0,  6, 0, 8,  0, 2, 4,  ; Row 3
    db 6, 0, 7,  0, 5, 2,  9, 0, 8,  ; Row 4
    db 4, 0, 9,  8, 0, 3,  2, 0, 6,  ; Row 5
    db 0, 3, 2,  0, 6, 1,  0, 5, 7,  ; Row 6
    db 3, 0, 5,  0, 8, 4,  0, 6, 2,   ; Row 7
    db 0, 8, 0,  1, 0, 5,  0, 4, 9,  ; Row 8
    db 7, 0, 1,  0, 9, 0,  3, 0, 5 ; Row 9

  
result_board:
    db 5, 6, 4,  3, 2, 9,  8, 7, 1,  ; Row 1
    db 1, 2, 8,  5, 4, 7,  6, 9, 3,  ; Row 2
    db 9, 7, 3,  6, 1, 8,  5, 2, 4,  ; Row 3
    db 6, 1, 7,  4, 5, 2,  9, 3, 8,  ; Row 4
    db 4, 5, 9,  8, 7, 3,  2, 1, 6,  ; Row 5
    db 8, 3, 2,  9, 6, 1,  4, 5, 7,  ; Row 6
    db 3, 9, 5,  7, 8, 4,  1, 6, 2,   ; Row 7
    db 2, 8, 6,  1, 3, 5,  7, 4, 9,  ; Row 8
    db 7, 4, 1,  2, 9, 6,  3, 8, 5   ; Row 9


message1_s:      db   'Final Project', 0  
message_s:      db    'Welcome to sudoku game', 0  
message2_s:     db    'Your game will start in few seconds!', 0     
no_timer: dw 0
type_game: db "Enter the level: ",0
numbering_e: db " Easy ",0
numbering_m: db " Medium ",0
numbering_h: db " Hard" ,0
game_mode: db 0
message1_e:      db   'Game ended', 0  
message_e:      db    'Thank you for playing the game', 0  
message3_e: db 'Your score is ',0
score_count: dw 0
undo_num: dw 0xFFFF
undo_debug_message db 'Undo performed!$'
music_length: dw 15644
music_data: incbin "getthem.imf"
notes_card:times 9 dw 0	
if_won:dw 0
typewriter_msg:  dw   0   ; Pointer to current message
typewriter_x:    db   0   ; Current x position
typewriter_y:    db   0   ; Current y position
typewriter_col:  db   0x3E ; Color attribute
typewriter_delay: dw   0xFFFF ; Delay count


;-----------------------

clrscr:
    push es
    push ax
    push di
    mov  ax, 0xb800    
    mov  es, ax         
    mov  di, 0         
    mov  ah, 0x7E     

nextloc:  
    mov  [es:di], ax   
    add  di, 2         
    cmp  di, 4000     
    jne  nextloc   


    pop  di 
    pop  ax 
    pop  es 
    
    ret
;-----------------------



printnum:     push bp 
              mov  bp, sp 
              push es 
              push ax 
              push bx 
              push cx 
              push dx 
            
              mov  ax, 0xb800 
              mov  es, ax             ; point es to video base 
              mov  ax, [bp+4]         ; load number in ax 
              mov  bx, 10             ; use base 10 for division 
              mov  cx, 0              ; initialize count of digits 
 
nextdigit:    mov  dx, 0              ; zero upper half of dividend 
              div  bx                 ; divide by 10 
              add  dl, 0x30           ; convert digit into ASCII 
              push dx                 ; save ASCII value on stack 
              inc  cx                 ; increment count of values  
              cmp  ax, 0              ; is the quotient zero 
              jnz  nextdigit          ; if no divide it again 
 
nextpos:      pop  dx                 ; remove a digit from the stack 
              mov  dh, 0x3E           ; use normal attribute 
              mov  [es:di], dx        ; print char on screen 
              add  di, 2              ; move to next screen location 
              loop nextpos            ; repeat for all digits on stack 
 
            ;   pop  di 
              pop  dx 
              pop  cx 
              pop  bx 
              pop  ax 
              pop  es 
              pop  bp 
              ret  2
 

timer:        
              push ax
              push ds

              mov ax, cs
              mov ds, ax

              inc word [tickcount]
           
              cmp word [tickcount], 18   
              jb end_timer              
              mov word [tickcount], 0 

              inc word [seconds]
              cmp word [seconds], 60
              jb display_time

              mov word [seconds], 0
              inc word [minute]

display_time:
            
              mov ax, [minute]
              push ax
              cmp word[no_timer],1
              je end_timer
             cmp word[scr_print],1
              je scr1_pos
             
              

scr2_pos:
             mov di,140
             call printnum

              mov word [es:di], 0x3A   
              add di, 2
 
              mov ax, [seconds]
              push ax
              mov di, 144              ; Screen position for seconds
              call printnum
              jmp end_timer

scr1_pos:
           mov di,840
           call printnum

              mov word [es:di], 0x3A   
              add di, 2
 
              mov ax, [seconds]
              push ax
              mov di, 844              ; Screen position for seconds
              call printnum



end_timer:    
            
              mov al, 0x20 
              out 0x20, al              

              pop ds
              pop ax
              
              iret 
;----------------------
fill_rows_vertical:
    push ax
    push cx
    push dx
    push bx
    push es
   
    mov ax, 0xB800        
    mov es, ax

    xor bx, bx            
  
    mov di, 59 
    shl di,1     
    mov cx, 80 
    sub cx,59   

column_loopv:
    mov si, di           

row_loopv:
    mov [es:si], ax      
    add si, 160          
    inc dl                
    cmp dl, dh            
    jbe row_loopv          

    mov dl, 9             
    add di, 2            
    loop column_loopv     

    pop es
    pop bx
    pop dx
    pop cx
    pop ax
    ret

fill_rows:
    push ax
    push cx
    push dx
    push bx
    push es
   
    mov ax, 0xB800      
    mov es, ax

    xor bx, bx        

row_loop:
    mov di, bx           
    mov cx, 80         

column_loop:
    mov [es:di], ax     
    add di, 2           
    loop column_loop    

    add bx, 160         
    inc dl             
    cmp dl, dh          
    jbe row_loop  

    pop es
    pop bx
    pop dx
    pop cx
    pop ax
    ret
;--------------------

get_length:   mov  si, bp              
              xor  cx, cx             

next_char:    cmp  byte [si], 0       
              je   done_length     
                
              inc  si                
              inc  cx              
              jmp  next_char         

done_length:  ret 

print_message:
              call get_length          
              
              mov  ah, 0x13       ;print string       
              mov  al, 1    ;update cursor          
              mov  bh, 0      ;page 0        
              push cs 
              pop  es             ;segment of string     
              int  0x10              ;bios service
              ret


printing_texts:
              mov  bl, 0x3E          
              mov  bp, message         
              mov  dx, 0x0119       
              call print_message      

              ;print second message 
              mov  bl, 0x3E           
              mov  bp, message2         
              mov  dx, 0x0321         
              call print_message     

               mov  bl, 0x3E           
              mov  bp, message3        
              mov  dx, 0x050C        
              call print_message     

              ;print fourth message 
              mov  bl, 0x3E       
              mov  bp, message4       
              mov  dx, 0x0521       
              call print_message      

              ;print fifth message 
              mov  bl, 0x3E        
              mov  bp, message5       
              mov  dx, 0x0535         
              call print_message 
             
           
              mov  di, (5 * 80 + 62) * 2 
              push word[mistake_counter]
              call printnum
              ret 

           

;---------------
;SCROLLING 
;----------------
scrollup:
    push bp
    mov  bp,sp
    ; call cbuffer 
    push ax
    push cx
    push si
    push di
    push es
    push ds

    mov  ax, 80             
    mul  byte [bp+4]       
    mov  si, ax            
    push si               
    shl  si, 1              
    mov  cx, 2000          
    sub  cx, ax            
    mov  ax, 0xb800
    mov  es, ax            
    mov  ds, ax            
    xor  di, di            
    cld                     
    rep  movsw              
    mov  ax, 0x0720         
    pop  cx                
    rep  stosw              

    pop  ds
    pop  es
    pop  di
    pop  si
    pop  cx
    pop  ax
    pop  bp
    ret  2


scrolldown:
      push bp
    mov  bp,sp
    ; call cbuffer 
    push ax
    push cx
    push si
    push di
    push es
    push ds

    mov  ax, 80             
    mul  byte [bp+4]   
    push ax            
    shl  ax, 1 
    mov si,3998
    sub si,ax             
    mov  cx, 2000          
    sub  cx, ax            
    mov  ax, 0xb800
    mov  es, ax            
    mov  ds, ax            
    xor  di, 3998            
    std                    
    rep  movsw              
    mov  ax, 0x0720         
    pop  cx                
    rep  stosw              

    pop  ds
    pop  es
    pop  di
    pop  si
    pop  cx
    pop  ax
    pop  bp
    ret  2
;--------------------------------


print_notes_up:
    ; 1 row in notes is 1 box 
    ; so 81 rows in total 81 boxes
    push bp
    mov bp,sp
    pusha

    ; 1 row of sudoko grid
    mov ax,0
    mov cx,9
    mov bx,0
    mov dx,0x090B
    notes_row_1_grid:
        push ax
        push bx
        push dx
        push notes1
        call print_notes_1
        add ax,1
        add bx,20
        add dx,0x05
        loop notes_row_1_grid

    mov cx,9
    mov bx,0
    mov dx,0x0D0B
    notes_row_2_grid:
        push ax
        push bx
        push dx
        push notes2
        call print_notes_1
        add ax,1
        add bx,20
        add dx,0x05
        loop notes_row_2_grid

    mov cx,9
    mov bx,0
    mov dx,0x110B
    notes_row_3_grid:
        push ax
        push bx
        push dx
        push notes3
        call print_notes_1
        add ax,1
        add bx,20
        add dx,0x05
        loop notes_row_3_grid

    
mov cx,9
    mov bx,0
    mov dx,0x150B
    notes_row_4_grid:
        push ax
        push bx
        push dx
        push notes4
        call print_notes_1
        add ax,1
        add bx,20
        add dx,0x05
        loop notes_row_4_grid


    
    popa
    pop bp
    ret
;--------------------------------------
;--------------------------------------PRINT NOTES 1 BOX
;--------------------------------------
print_notes_1: ; push starting index, push starting location of box and push the notes you wanna print
   push bp
    mov bp,sp
    push bx
    push dx
    push cx
    push ax
    push di
    ; start row 1 col 1 = 0x060D
    ; row 1 col 2 = 0x0613
    ; row 2 col 1 = 0x0A19
    mov di,[bp+10]
    mov cx,0
    mov dx,[bp+6]
    mov si,[bp+8] ; start
    mov bx,[bp+4] ; the notes i wanna print
   ;mov bp,board

    get_value_before_notes:
        ;cmp word[board+di],0
        ;jne nu_1end
    nu_1:
        mov ax,[bx+si]
        cmp ax,0
        jmp print_nu1

    nu_2:
        add dx,0x01
        add si,2
        add cx,1

        cmp cx,3
        je nu_11
        cmp cx,6
        je nu_11
        cmp cx,9
        jl nu_1
        
        jmp nu_1end

    nu_11: 
        sub dx,0x03
        add dx,0x0100
        jmp nu_1


    print_nu1 :
    mov ax,0
    mov al,dh
    push word[bx+si]
    push word 0x7E
    push ax
    mov al,dl
    push ax
    call printscore

    jmp nu_2

    
   nu_1end: 
    pop di
    pop ax
    pop cx
    pop dx
    pop bx
    pop bp
    ret 8 ; push starting location of the box and then the notes you want to print and the starting number of array
;--------------------------------------
;--------------------------------------PRINT NOTES DOWN
;--------------------------------------
print_notes_down:
    ; 1 row in notes is 1 box 
    ; so 81 rows in total 81 boxes
    push bp
    mov bp,sp
    pusha
    ; 1 row of sudoko grid
    mov ax,36
    mov cx,9
    mov bx,0
    mov dx,0x010B
    notes_row_5_grid:
        push ax
        push bx
        push dx
        push  notes5
        call print_notes_1
        add ax,1
        add bx,20
        add dx,0x05
        loop notes_row_5_grid

    mov cx,9
    mov bx,0
    mov dx,0x050B
    notes_row_6_grid:
         push ax
        push bx
        push dx
        push  notes6
        call print_notes_1
        add ax,1
        add bx,20
        add dx,0x05
        loop notes_row_6_grid

    mov cx,9
    mov bx,0
    mov dx,0x090B
    notes_row_7_grid:
         push ax
        push bx
        push dx
        push  notes7
        call print_notes_1
        add ax,1
        add bx,20
        add dx,0x05
        loop notes_row_7_grid

    
mov cx,9
    mov bx,0
    mov dx,0x0D0B
    notes_row_8_grid:
         push ax
        push bx
        push dx
        push  notes8
        call print_notes_1
        add ax,1
        add bx,20
        add dx,0x05
        loop notes_row_8_grid

    mov cx,8
    mov bx,0
    mov dx,0x110B
    notes_row_9_grid:
         push ax
        push bx
        push dx
        push  notes9
        call print_notes_1
        add ax,1
        add bx,20
        add dx,0x05
        loop notes_row_9_grid

    
    popa
    pop bp
    ret
    printscore:
        push bp
        mov bp,sp
        push es
        push ax
        push bx
        push cx
        push dx
        push di

        mov ax,0xb800
        mov es,ax
        mov ax,[bp+10]
        mov bx,10
        mov cx,0

        nextdigit1:
                    mov dx, 0 
                    div bx 
                    add dl, 0x30 
                    push dx 
                    inc cx 
                    cmp ax, 0 
                    jnz nextdigit1

                    mov ax,0
                    mov al,80
                    mul byte[bp+6]
                    add ax,[bp+4]
                    shl ax,1
                    mov di,ax
        nextpos1: 
                pop dx 
                mov dh,[bp+8]
                mov [es:di], dx 
                add di, 2 
                loop nextpos1
                pop di
                pop dx
                pop cx
                pop bx
                pop ax
                pop es
                pop bp
 

         ret 8

;---------------------------------
new_printing_up:
     
    mov byte[store],1
    mov byte[col_counter],10
    mov byte[row_counter],11
    mov byte[box_counter],45
    mov byte[row_temp],0
    mov byte[col_temp],10
    call clrscr
    mov ah, 0x1F          
    mov dh, 35         
    mov dl, 9             
    call fill_rows_vertical 
    call print_board2
    call block_printing_at_second
    call print_notes_down
    call print_loop
    ret

new_printing_down:

mov byte[store],0
mov byte[col_counter],10
mov byte[row_counter],11
mov byte[box_counter],36
mov byte[row_temp],8
mov byte[col_temp],10
call clrscr
mov ah, 0x1F          
mov dh, 35         
mov dl, 9             
call fill_rows_vertical 
mov ah, 0x1F        
mov dh, 7            
mov dl, 1           
call fill_rows
call printing_texts
call notes_print
call print_notes_up
call print_board
call print_loop
ret
;------------------------------
typewriter_effect:
    push bp
    
    ; Get message address
    mov si, [typewriter_msg]
    xor cx, cx  ; Clear character counter

typewriter_char_loop:
    ; Get current character
    mov al, [si]
    
    ; Check if end of message
    cmp al, 0
    je typewriter_done
    
    ; Set cursor position
    mov ah, 0x02
    mov bh, 0
    mov dl, [typewriter_x]
    add dl, cl  ; Adjust x based on character position
    mov dh, [typewriter_y]
    int 0x10
    
    ; Print current character
    mov ah, 0x0E  ; BIOS teletype output
    mov bl, [typewriter_col] ; Color
    int 0x10
    
    ; Configurable delay
    push cx
    mov cx, [typewriter_delay] ; Load delay value
typewriter_delay_loop:
    loop typewriter_delay_loop
    pop cx
    
    ; Move to next character
    inc si
    inc cx
    jmp typewriter_char_loop

typewriter_done:
    pop bp
    ret
;---------------------------

printing_texts_startscr:
              
            
           
    push es
    push ax
    push di
    mov  ax, 0xb800    
    mov  es, ax         
    mov  di, 0         
    mov  ax, 0x7E2D     

           

nextloc2:  
    mov  [es:di], ax   
    add  di, 2         
    cmp  di, 4000     
    jne  nextloc2   
    call delay

 mov word[typewriter_msg], message1_s
    mov byte[typewriter_x], 20
    mov byte[typewriter_y], 5
    call typewriter_effect

    ; Welcome message
    mov word[typewriter_msg], message_s
    mov byte[typewriter_x], 25
    mov byte[typewriter_y], 7
    call typewriter_effect

    ; Second message
    mov word[typewriter_msg], message2_s
    mov byte[typewriter_x], 23
    mov byte[typewriter_y], 9
    call typewriter_effect

  
               mov  bl, 0x3E           
              mov  bp, type_game      
              mov  dx, 0x0B14      
              call print_message  

                 mov  bl, 0x3E           
              mov  bp, numbering_e      
              mov  dx, 0x0D14      
              call print_message  

                 mov  bl, 0x3E           
              mov  bp, numbering_m       
              mov  dx, 0x0E14      
              call print_message     

            ;   print third message
              mov  bl, 0x3E         
              mov  bp, numbering_h      
              mov  dx, 0x0F14        
              call print_message  


             mov ah, 0x00          
             int 0x16  
             mov byte[game_mode],al 

              pop  di 
              pop  ax 
              pop  es    
              ret 


;-----------------------
delay:
push cx
mov cx,0x3
dl1:
	push cx
	
	mov cx,0xFFFF
l2:
	sub cx,1
	jnz	l2
	pop cx
	sub cx,1
	jnz	dl1

pop cx	
ret		

printing_texts_end:
    call delay
    push es
    push ax
    push di
    mov  ax, 0xb800    
    mov  es, ax         
    mov  di, 0         
    mov  ax, 0x7E2D     

nextloc_e:  
    mov  [es:di], ax   
    add  di, 2         
    cmp  di, 4000     
    jne  nextloc_e   
             
             cmp word[if_won],1
            je ini
            jne uwuh
ini: 
   endBoundary:
	push bp
		mov bp,sp
		push es
		push ax
		push di
		
		mov ax,0xb800
		mov es,ax
		mov di,3860
	eb04:	
		mov word[es:di],0x0E5F
		add di,2
		cmp di,3934
		jne eb04
		
		pop di
		pop ax
		pop es
		mov sp,bp
		pop bp
     mov ah, 0x09
    mov dx, win_message
    int 0x21 
          uwuh:    mov  bl, 0x3E          
              mov  bp, message1_e       
              mov  dx, 0x0520      
              call print_message    

              mov  bl, 0x3E          
              mov  bp, message_e         
              mov  dx, 0x0819      
              call print_message   


              mov  bl, 0x3E          
              mov  bp, message3_e         
              mov  dx, 0x0A19      
              call print_message   
               
             mov di,(10 * 80 + 40) * 2 
             push word[score_count]
             call printnum
               pop  di 
               pop  ax 
               pop  es 
              jmp end

;-----------------------------
take_input:
   
      mov ah, 0x00          
     int 0x16 
    cmp al,'u'
    je undo_called
    cmp al,'n'
     je take_input_in_notes
jmp take_input_in_grid

take_input_in_notes:
 cmp word[scr_print], 0
    je bottom_screen_pos_notes
    

    
top_screen_pos_notes:
    mov dh, 2      ; Row for top screen
    mov dl, 1      ; Column for top screen
    push dx
    jmp set_cursor_notes


bottom_screen_pos_notes:
    mov dh, 21    ; Row for bottom screen
    mov dl, 9      ; Column for bottom screen
    push dx


set_cursor_notes:
mov ah, 0x02
    mov bh, 0          
    int 0x10

    ; Print row message
    mov ah, 0x09       
    mov dx, notes_mess
    int 0x21   

pop dx
add dh,1
push dx
 mov ah, 0x02
    mov bh, 0          
    int 0x10

    ; Print row message
    mov ah, 0x09       
    mov dx, row_mess
    int 0x21   

    mov ah,0x00
    int 0x16
    sub al,48
    mov byte[notes_row_input_user],al
pop dx
add dh,1
push dx
mov ah, 0x02
    mov bh, 0          
    int 0x10

    ; Print row message
    mov ah, 0x09       
    mov dx, col_mess
    int 0x21  

     mov ah,0x00
    int 0x16
    sub al,'0'
    mov byte[notes_col_input_user],al

pop dx
    add dh,1
    push dx
mov ah, 0x02
    mov bh, 0          
    int 0x10

    ; Print row message
    mov ah, 0x09       
    mov dx, in_mess
    int 0x21  
    mov ah,0x00
    int 0x16
    sub al,48
    mov byte[notes_num_input_user],al

pop dx
sub dh,2
add dl,20
mov ah, 0x02
    mov bh, 0          
    int 0x10

    ; Print row message
    mov ah, 0x09       
    mov dx, index_mess
    int 0x21  
    mov ah,0x00
    int 0x16
    sub al,48
    mov byte[notes_box_count],al


    cmp byte[notes_row_input_user],1
    jne notes_2_bx
    mov bx,notes1
 
    jmp add_in_notes
notes_2_bx:
    cmp byte[notes_row_input_user],2
    jne notes_3_bx
    mov bx,notes2
  
    jmp add_in_notes
notes_3_bx:
    cmp byte[notes_row_input_user],3
    jne notes_4_bx
    mov bx,notes3
 
    jmp add_in_notes
notes_4_bx:
    cmp byte[notes_row_input_user],4
    jne notes_5_bx
    mov bx,notes4
  
    jmp add_in_notes
notes_5_bx:
    cmp byte[notes_row_input_user],5
    jne notes_6_bx
    mov bx,notes5
   
    jmp add_in_notes
notes_6_bx:
    cmp byte[notes_row_input_user],6
    jne notes_7_bx
    mov bx,notes6
  
    jmp add_in_notes
notes_7_bx:
    cmp byte[notes_row_input_user],7
    jne notes_8_bx
    mov bx,notes7
  
    jmp add_in_notes
notes_8_bx:
    cmp byte[notes_row_input_user],8
    jne notes_9_bx
    mov bx,notes8
    
    jmp add_in_notes

notes_9_bx:
    cmp byte[notes_row_input_user],9
    mov bx,notes9
    jmp add_in_notes
    
    add_in_notes:
        xor cx,cx
        mov ax,20
        mov cl,byte[notes_col_input_user]
        dec cx
        mul cl
        sub ax,2
        shl byte[notes_box_count],1
        add al,[notes_box_count]
        xor ah,ah
        mov si,ax
        rest_notes_add:
            mov al,[notes_num_input_user]
            xor ah,ah
            mov [bx+si],ax

   
ret
take_input_in_grid:
    cmp word[scr_print], 0
    je bottom_screen_pos
    
top_screen_pos:
    mov dh, 2      ; Row for top screen
    mov dl, 9      ; Column for top screen
    jmp set_cursor

bottom_screen_pos:
    mov dh, 22     ; Row for bottom screen
    mov dl, 9      ; Column for bottom screen

set_cursor:
    mov ah, 0x02
    mov bh, 0          
    int 0x10

    ; Print row message
    mov ah, 0x09       
    mov dx, row_mess
    int 0x21        

    ; Get row input
    mov ah, 0x00      
    int 0x16          
  
    sub al, '0'       
    mov [row_input_user], al 

    cmp word[scr_print], 0
    je bottom_screen_col_pos
    
top_screen_col_pos:
    mov dh, 2
    mov dl, 9
    jmp set_col_cursor

bottom_screen_col_pos:
    mov dh, 22
    mov dl, 9

set_col_cursor:
    mov ah, 0x02
    mov bh, 0          
    int 0x10

    ; Print column message
    mov ah, 0x09       
    mov dx, col_mess   
    int 0x21     

    ; Get column input
    mov ah, 0x00      
    int 0x16           

    sub al, '0'
    mov [col_input_user], al 

   
    cmp word[scr_print], 0
    je bottom_screen_num_pos
    
top_screen_num_pos:
    mov dh, 2
    mov dl, 9
    jmp set_num_cursor

bottom_screen_num_pos:
    mov dh, 22
    mov dl, 9

set_num_cursor:
    mov ah, 0x02
    mov bh, 0          
    int 0x10

    ; Print number input message
    mov ah, 0x09       
    mov dx, in_mess 
    int 0x21     

    ; Get number input
    mov ah, 0x00      
    int 0x16           

    sub al, '0'
    mov [num_input_user], al 


mov al, [row_input_user]
dec al                
mov bl, 9            
mul bl                 
mov si, ax            

mov al, [col_input_user]
dec al                
add si, ax            

;----------------------------------------
mov al, [num_input_user] 
mov bl, [result_board + si]
cmp al, bl              
je correct_input         


inc word[mistake_counter]        
cmp word[mistake_counter], 3 
je game_over             


jmp end_check

correct_input:
    
    mov al, [num_input_user]
    mov word[undo_num],si
    mov [board + si], al 
    add word[score_count], 10
    call display_score

    mov ax, si
    mov bl, 9
    div bl
    mul bl  
    mov cx, ax 
    
  
    push si  ; Save original index
    mov si, cx
    mov dl, 0  ; Counter 
    mov cx, 9  ; 9 columns

check_row_loop:
    call check_win_condition
    cmp byte[board + si], 0
    je row_not_complete  
  cmp dl,9
  je row_comp

    inc dl  
    inc si 
    loop check_row_loop

  
    cmp dl, 9
    jne row_not_complete
 
    add word[score_count], 100
    call display_score
    call music
row_not_complete:
    ; call music
    pop si  
; call check_win_condition
;  row_complete:
;     call music  
row_comp:
    call music
    ret
end_check:
    cmp word[mistake_counter],3
    je game_over
    ret

 game_over:
    mov word[no_timer],1
    call clrscr
    call printing_texts_end
    
    ret
;-----------------------------------

check_win_condition:
   
    mov cx, 81     
    mov si, 0      
    mov dl, 0     

check_board_loop:
  
    cmp byte[board + si], 0
    je board_not_complete  
    
 
    inc si
    loop check_board_loop

    call win_game
    ret

board_not_complete:
    ret


win_game:
    call clrscr
    mov ah, 0x00
    mov al, 0x03  
    int 0x10

    mov ah, 0x09
    mov dx, win_message
    int 0x21
    mov word[if_won],1
    call game_over
    ret

win_message db 'Congratulations! You won the game!$'
;-----------------------------------

display_score:
   
    mov ah, 0x02
    mov bh, 0x05
    mov dx, 0x21 
    int 0x10
  
   mov di,(5 * 80 + 40) * 2 
   push word[score_count]
   call printnum
;  call music
  conie:  ret
;----------------------------------
undo_called:
    cmp word[scr_print],0
    je top_undo
bottom_undo:
        mov bx,70
       jmp un
 
top_undo: mov bx,36


  un: cmp word[undo_num], 0xFFFF  
    je no_undo

    ; mov ah, 0x09     
    ; mov dx, return_message
    ; int 0x21          
  
    mov si, [undo_num]
    
    cmp si,bx  
    jae no_undo

    mov byte[board+si], 0 
    mov word[undo_num], 0xFFFF

no_undo:
    ret

;--------------------------
; Check for keyboard input
;--------------------------

check_keypress:
  
   cmp word[scr_print],0
   je l1
   call print_board
   jmp rest_key
   l1: call print_board2
 

    rest_key:
     mov ah, 0x00          
    int 0x16               
    cmp al, 0x1B          
    je end
    cmp al,'i'
    jne c
    call take_input
    jmp check_keypress

  c:
      
    cmp al, 's'           
    je scroll_up_screen
   
    cmp al, 'd'
    je scroll_down_screen
    ret
 
;------------------------------------
print_notes_card:
    mov cx, 9           ; 9 elements in the array
    mov si, 0           ; index into notes_card array

print_loopss:
    push word [notes_card + si]  ; push current array element
    call printnum

    add si, 2           ; move to next word in the array
    loop print_loopss

    ret

count_notes_card:

    mov di, 0               ; Reset index to 0
    mov cx, 9               ; 9 words to clear

mov cx, 81
mov si, 0

count_loop:
    mov al, [board + si]    ; Load board element
    cmp al, 0               ; Check if element is zero
    je skip_increment       ; Skip if zero

    dec al                  ; Subtract 1 (0-based indexing)
    movzx bx, al            ; Zero-extend to 16-bit
    shl bx, 1               ; Multiply by 2 for word addressing
    inc word [notes_card + bx]  ; Increment corresponding notes_card entry

skip_increment:
    inc si                  ; Move to next board element
    loop count_loop         ; Continue until all elements processed

    call print_notes_card        ; Call print function

    ret    
;-----------------------

print_board:
    ;  call display_score
    ; call count_notes_card
    mov cx, 4    ; num of rows
    mov si, 0   
    mov word[row_input],9
    mov word[col_input],11


    cmp byte[game_mode], '1'
    je set_easy_board
    cmp byte[game_mode], '2'
    je set_medium_board
    cmp byte[game_mode], '3'
    je set_hard_board

set_easy_board:
   
    mov bx, board
    jmp start_loop

set_medium_board:
    mov bx, medium_board
    jmp start_loop

set_hard_board:
    mov bx, hard_board

start_loop:
    mov bp,bx
rows_loop:
    push cx      
    mov cx, 9    ; cols per row
  
 col_loop: 
    
    mov al, [bp+ si]  
    cmp al,0
    je pr_continue
    push word [row_input]
    push word[col_input]
    
    cmp al,6
    je pr6 
    cmp al,7
    jz pr7
    cmp al,8
    jz pr8 
    cmp al,9
    jz pr9
    cmp al,1
    jz pr1
    cmp al,2
    jz pr2 
    cmp al,3
    jz pr3 
    cmp al,4
    jz pr4 
    cmp al,5
    jz pr5


pr_continue:
    inc si   
    cmp si,36
    je go_back
 
    add word[col_input],5
    cmp word[col_input],51
    
    jng continue_loop
    call next_col

continue_loop:  
 
loop col_loop
jmp go_back

next_col: 
 
add word[row_input],4
mov word[col_input],11
ret

go_back: 
pop ax
ret

;--------------------------------------------------

print_board2:   
    ;   call count_notes_card
    mov cx, 5    ; num of rows
    mov si, 36    ; board position
    mov word[row_input],1
    mov word[col_input],11

    cmp byte[game_mode], '1'
    je set_easy_board2
    cmp byte[game_mode], '2'
    je set_medium_board2
    cmp byte[game_mode], '3'
    je set_hard_board2

set_easy_board2:
   
    mov bx, board
    jmp start_loop

set_medium_board2:
    mov bx, medium_board
    jmp start_loop

set_hard_board2:
    mov bx, hard_board

start_loop2:
    mov bp,bx


rows_loop2:
    push cx      
    mov cx, 9   ; cols per row
  

 col_loop2: 
    mov al, [bp + si]  
    cmp al,0

    je pr_continue2
    push word [row_input]
    push word[col_input]
  
    cmp al,6
    je pr6 
    cmp al,7
    jz pr7
    cmp al,8
    jz pr8 
    cmp al,9
    jz pr9
    cmp al,1
    jz pr1
    cmp al,2
    jz pr2 
    cmp al,3
    jz pr3 
    cmp al,4
    jz pr4 
    cmp al,5
    jz pr5


pr_continue2:
    
    inc si 

    cmp si,81
    je go_back2
    
    add word[col_input],5
    cmp word[col_input],51
    jng continue_loop2
    call next_col2
  

continue_loop2:  
 
    loop col_loop2
   jmp go_back2

next_col2: 
 
add word[row_input],4
mov word[col_input],11 
ret

go_back2: 
pop ax
ret



pr1: call print1 
    jmp pr_continue
pr2: call print2
    jmp pr_continue
pr3: call print3
    jmp pr_continue
pr4: call print4
    jmp pr_continue
pr5: call print5
    jmp pr_continue
pr6: call print6
    jmp pr_continue
pr7: call print7
    jmp pr_continue
pr8: call print8
    jmp pr_continue
pr9: call print9
    jmp pr_continue


scroll_up_screen:
    mov word[scr_print],0
    mov ax, 25             
    push ax
    call scrollup       
    call new_printing_up  
    ret  

scroll_down_screen:
    mov word[scr_print],1
    mov ax, 25             
    push ax
    call scrolldown   
   
    call new_printing_down 
    ; call display_score
    ret  


set_cursor_position:
    mov ah, 02h          ; bios service setting cursor position
    int 0x10             ;  bios interrupt
    ret

print_char:
 
    push ax               
    push bx               
    push dx               
    
    mov ah, 0x0E           ;bios service for char print
    mov bh, 0x00           ; page number 
    mov bl, 0x07           ; text attribute 
    int 0x10               
    
    pop dx                 
    pop bx                
    pop ax                
    ret                   

;-------------------------------
; PRINT HORIZONTAL LINE
;-------------------------------
print_horizontal_line:
    mov cx, 4            

print_horizontal:
    mov al, [horizontal]  
    call print_char      
    loop print_horizontal  
    ret

;-------------------------------
; PRINT VERTICAL LINE
;-------------------------------
print_vertical_line:
    mov cx, 3            

print_vertical:
    mov al, [vertical]    
    call print_char       

    inc dh               
    call set_cursor_position  
    loop print_vertical  
    ret

;-------------------------------
; PRINT NEW LINE
;-------------------------------
print_newline:
    mov ah, 0x0E
    mov al, 0x0D         ; start of line
    int 0x10            
    mov al, 0x0A         ; new line
    int 0x10           
    ret

;-------------------------------
; PRINT CELL CONTENT
;-------------------------------
print_cell_content:
    push bp
    mov bp, sp
    mov cx, 3          
    mov si, [bp+4]      

print_content:
    add si, '0'         
    mov ax, si        
    call print_char     

    sub si, '0'        
    inc si              

    loop print_content   
    pop bp
    ret 
;------------------------
print_loop:
    
    cmp byte [box_counter], 0
    jne print_loop_1

    call keypress
    ret

    print_loop_1:         

    mov dl, [col_temp]     
    mov dh, [row_temp]   
    push dx                

    sub byte [col_counter], 1
    jz next_column
    jnz code 

code:
    pop dx                
    call set_cursor_position

    mov al, [top_left]
    call print_char

    ; Print horizontal line
    call print_horizontal_line

    mov al, [top_right]
    call print_char

    call print_newline
  


continue_code:
    mov dl, [col_temp]     
    mov dh, [row_temp]           
    add dh,1
    push dx                

    call set_cursor_position

    ;print vertical line left
    call print_vertical_line
 
    pop dx                
    add dl, 5            
    call set_cursor_position

   ;print vertical line right
    call print_vertical_line

    mov dl, [col_temp]    
    mov dh, [row_temp]           
    add dh,4
    push dx               
    call set_cursor_position
    pop dx

    mov al, [bottom_left]
    call print_char

   ;print bottom line
    call print_horizontal_line

    mov al, [bottom_right]
    call print_char

    dec byte [box_counter]
    add byte [col_temp], 5
    jmp print_loop



next_column:
    mov byte [col_temp], 10    
    add byte [row_temp], 4     
    mov byte [col_counter], 10 
    sub byte[row_counter],1
    cmp byte [row_counter], 0 
 
    jnz print_loop   
    ret

keypress:
    ;  call waitForMouseClick
   call check_keypress
   ret

print_string:

    mov ah, 0x13       
    mov al, 1       
    mov bh, 0        
    mov bl, 0x70        
    int 0x10          
    ret
;---------------------------------
; Block printing functions
;--------------------------------
print1:
      push bp
      mov bp,sp
      mov dl,[bp+4]
      mov dh,[bp+6]
    
      mov bp, d11       
      mov cx, 3         
      call print_string
 
      inc dh
       mov bp, d12        
       mov cx, 3         
       call print_string

  
    inc dh     
    mov bp, d13       
    mov cx, 3         
    call print_string
    pop bp
    ret 4

print2:
      push bp
      mov bp,sp
      mov dl,[bp+4]
      mov dh,[bp+6]
    
      mov bp, d21       
      mov cx, 3         
      call print_string
 
      inc dh
       mov bp, d22        
       mov cx, 3         
       call print_string

  
    inc dh     
    mov bp, d23       
    mov cx, 3         
    call print_string
    pop bp
    ret 4


print3:
      push bp
      mov bp,sp
      mov dl,[bp+4]
      mov dh,[bp+6]
    
      mov bp, d31       
      mov cx, 3         
      call print_string
 
      inc dh
       mov bp, d32        
       mov cx, 3         
       call print_string

  
    inc dh     
    mov bp, d33       
    mov cx, 3         
    call print_string
    pop bp
    ret 4

print4:
       push bp
      mov bp,sp
      mov dl,[bp+4]
      mov dh,[bp+6]
    
      mov bp, d41       
      mov cx, 3         
      call print_string
 
      inc dh
       mov bp, d42        
       mov cx, 3         
       call print_string

  
    inc dh     
    mov bp, d43       
    mov cx, 3         
    call print_string
    pop bp
    ret 4

print5:
       push bp
      mov bp,sp
      mov dl,[bp+4]
      mov dh,[bp+6]
    
      mov bp, d51       
      mov cx, 3         
      call print_string
 
      inc dh
       mov bp, d52        
       mov cx, 3         
       call print_string

  
    inc dh     
    mov bp, d53       
    mov cx, 3         
    call print_string
    pop bp
    ret 4

print6:
       push bp
      mov bp,sp
      mov dl,[bp+4]
      mov dh,[bp+6]
    
      mov bp, d61       
      mov cx, 3         
      call print_string
 
      inc dh
       mov bp, d62        
       mov cx, 3         
       call print_string

  
    inc dh     
    mov bp, d63       
    mov cx, 3         
    call print_string
    pop bp
    ret 4


print7:
       push bp
      mov bp,sp
      mov dl,[bp+4]
      mov dh,[bp+6]
    
      mov bp, d71       
      mov cx, 3         
      call print_string
 
      inc dh
       mov bp, d72        
       mov cx, 3         
       call print_string

  
    inc dh     
    mov bp, d73       
    mov cx, 3         
    call print_string
    pop bp
    ret 4

print8:
       push bp
      mov bp,sp
      mov dl,[bp+4]
      mov dh,[bp+6]
    
      mov bp, d81       
      mov cx, 3         
      call print_string
 
      inc dh
       mov bp, d82        
       mov cx, 3         
       call print_string

  
    inc dh     
    mov bp, d83       
    mov cx, 3         
    call print_string
    pop bp
    ret 4

print9:
       push bp
      mov bp,sp
      mov dl,[bp+4]
      mov dh,[bp+6]
    
      mov bp, d91       
      mov cx, 3         
      call print_string
 
      inc dh
       mov bp, d92        
       mov cx, 3         
       call print_string

  
    inc dh     
    mov bp, d93       
    mov cx, 3         
    call print_string
    pop bp
    ret 4

;--------------------------------
print_instructions:

              mov  bl, 0x3E          
              mov  bp, message6        
              mov  dx, 0x0F40   
              call print_message 

                mov  bl, 0x3E          
              mov  bp, message61       
              mov  dx, 0x1040   
              call print_message 


              mov  bl, 0x3E          
              mov  bp, message7        
              mov  dx, 0x1240  
              call print_message 

              mov  bl, 0x3E          
              mov  bp, message71        
              mov  dx, 0x1340  
              call print_message 

             mov  bl, 0x3E          
              mov  bp, message8        
              mov  dx, 0x1540  
              call print_message 

              mov  bl, 0x3E          
              mov  bp, message81        
              mov  dx, 0x1640  
              call print_message 

              mov  bl, 0x3E          
              mov  bp, message82        
              mov  dx, 0x1740  
              call print_message 


              ret


notes_text:
            mov  bl, 0x3E          
              mov  bp, message9        
              mov  dx, 0x0840   
              call print_message
              ret


  
block_printing_at_first:
 
    push 9
    push 21

    call print6
;-----------------------


;-----------------------
call notes_text
notes_print:
    push 9
    push 64
    call print1

    push 9
    push 68
    call print2

    push 9
    push 72
    call print3

     push 13
    push 64
    call print4

    push 13
    push 68
    call print5

    push 13
    push 72
    call print6

    push 17
    push 64
    call print7
  
    push 17
    push 68
    call print8
  
    push 17
    push 72
    call print9
    ret
  
;----------------------
continued:
    push 9
    push 26
    call print7

    push 9 
    push 31
    call print1

    push 9
    push 36
    call print5

    push 9
    push 46
    call print3

    push 9
    push 51
    call print2
 
    push 13
    push 16
    call print2

       
    push 13
    push 21
    call print8

       
    push 13
    push 26
    call print6

       
    push 13
    push 36
    call print9
  
    push 13
    push 41
    call print7

    push 13
    push 51
    call print5

    push 17
    push 16
    call print7

       
    push 17
    push 21
    call print3

       
    push 17
    push 26
    call print4

    push 17
    push 46
    call print9

    push 21
    push 11
    call print7

    push 21
    push 46
    call print6

    ret

block_printing_at_second:
;-----------------------
  
    push 2
    push 64
    call print1

    push 2
    push 68
    call print2

    push 2
    push 72
    call print3


     push 6
    push 64
    call print4

    push 6
    push 68
    call print5

    push 6
    push 72
    call print6

    push 10
    push 64
    call print7

    push 10
    push 68
    call print8
  
    push 10
    push 72
    call print9
  
    call print_instructions
    ret


music:
    push si
    push dx
    push ax
    push bx
    push cx
    push di

    mov si, 0                      ; Start at the beginning of music data
    mov di, 10                     ; Set the timer duration to 10 seconds
    mov cx, 18                     ; 18 timer ticks per second (default DOS timer frequency)
    mul di                         ; CX = 18 * 10 = 180 total ticks
    mov di, ax                     ; Store the total tick count in DI

.next_note:
    ; Send the current note data to the sound chip
    mov dx, 388h
    mov al, [si + music_data + 0]
    out dx, al
    mov dx, 389h
    mov al, [si + music_data + 1]
    out dx, al

    ; Set the delay (duration of this note)
    mov bx, [si + music_data + 2]
    add si, 4                      ; Move to the next note data

    ; Wait for the note to play
.repeat_delay:
    mov cx, 610                    ; Delay loop for smooth timing
.delay:
    mov ah, 1                      ; Check for keypress
    int 16h
    jnz .stop                      ; Stop music if a key is pressed
    loop .delay
    dec bx                         ; Decrease note duration counter
    jg .repeat_delay               ; Continue until BX = 0

    ; Check if time is up
    dec di                         ; Decrease remaining ticks
    jz .stop                       ; Stop if all ticks have elapsed

    ; Continue playing the next note if within music length
    cmp si, [music_length]
    jb .next_note

.stop:
    ; Stop the sound by sending reset commands to the chip
    mov dx, 388h
    mov al, 0xff
    out dx, al
    mov dx, 389h
    mov al, 0xff
    out dx, al

    ; Restore registers and return
    pop di
    pop cx
    pop bx
    pop ax
    pop dx
    pop si
    ret


start:
   
    call printing_texts_startscr
    call clrscr     
    xor ax, ax 
    mov es, ax                 ; point es to IVT base 
    cli                         ; disable interrupts 
    mov word [es:8*4], timer    ; store offset at n*4 
    mov [es:8*4+2], cs          ; store segment at n*4+2       
    sti   

    mov ah, 0x1F          
    mov dh, 35         
    mov dl, 9             
   
   
    call fill_rows_vertical 
    mov ah, 0x1F        
    mov dh, 7            
    mov dl, 1           
    call fill_rows

    call printing_texts
    call notes_print
    call print_notes_up
    call print_loop   
    
 
end:
    mov ax,0x4c00
    int 21h



notes dw 3405, 3033, 2551, 2273, 2025, 1911 ; E4, F4, G4, A4, B4, C5
durations dw 500, 500, 500, 500, 500, 500   ; Durations in milliseconds

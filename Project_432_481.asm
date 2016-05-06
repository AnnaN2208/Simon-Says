TITLE MYPROGRAM 

DEDOMENA SEGMENT
    
    askforroundsmsg db "How many rounds do you want to play <01-40)? ",10,13,"$"
    askforcolorsmsg db 10,13,"Type the right colors: ","$" 
    failmsg db 10,13,"Failed at Round: ","$"
    entermsg db 10,13,"Ok, Entering Round ","$"    
    winmsg db 10,13,"Congratulations!You win!","$" 
    msgforrounds db 10,13,"Round: ","$"  
    seira db " ",10,13,"$"      
    dekada db 0
    monada db 0
    gyroi dw 0  
    command db 0
    xromata dw 0     
    rounds db 2 dup<0> 
    pinakas db 60 dup<0> 
                                   
DEDOMENA ENDS


KODIKAS SEGMENT
ARXH: MOV AX,DEDOMENA
      MOV DS,AX 
      
      CALL inputrounds               ;klhsh synarthshs gia thn eisagvgh tvn gyrvn
      
      CALL round                     ;klhsh synarthshs gia thn metatroph tvn dyo 
                                     ;ari8mvn poy eishgage o xrhsrhs se ena
                                     
      MOV gyroi,CX                   ;apo8hkeysh ton synolikvn gyron sto "gyroi"
      
      CALL random_command            ;klhsh synarthseis gia thn dhmioyrgia pinaka
                                     ;tyxaivn dipsifion diadikon ari8mon
      LEA DX,seira
      MOV AH,09
      INT 21H 
      
      MOV DL,5BH                     ;ektypvsh olvn ton piuanon xromaton  
      MOV AH,02
      INT 21H 
      
      MOV DL,71H                      
      MOV AH,02
      INT 21H 
      
      MOV DL,7CH                      
      MOV AH,02
      INT 21H
      
      MOV DL,77H                      
      MOV AH,02
      INT 21H 
      
      MOV DL,7CH                      
      MOV AH,02
      INT 21H 
      
      MOV DL,65H                      
      MOV AH,02
      INT 21H
      
      MOV DL,7CH                      
      MOV AH,02
      INT 21H 
      
      MOV DL,72H                      
      MOV AH,02
      INT 21H
       
      MOV DL,5DH                      
      MOV AH,02
      INT 21H 
                                      
      MOV BX,0                         ;mhdenismos BX gia to loop "again1"
      
      AGAIN1:                          ;arxh ka8e gyrou paixnidioy     
      
      INC BX                           ;metrhths gyrvn
      
      LEA DX,msgforrounds              ;ektypvsh mnm poy plhroforei to xrhsth      
      MOV AH,09                        ;gia to gyro poy paizei
      INT 21H 
      
      MOV AX,BX                        ;metafora tou trexon gyrou ston ax gia ektypvsh
      
      CALL showrounds                  ;synarthsh gia ektypwsh gyrvn
      
      MOV DX,0                         ;mhdenismos DX gia to loop "again2"
             
      AGAIN2:                          ;ekinhsh loop gia ektyposh xromaton
      
      MOV xromata,DX                   ;xrhsh etiketas "xromata" gia na thn 
                                       ;metaferoume sth synarthsh appealcolor 
                                       
      CALL appear_color                ;klhsh synarthshs gia emfanish xromatos
      
      INC DX
      CMP DX,BX                        ;elenxos ektyposhs ton apaitoumenon xromaton 
      JB AGAIN2                        ;tou gyrou
      
      CALL CLEAR 
      
      LEA DX,askforcolorsmsg           ;ektyposh mnm gia zhthsh eisagoghs xromatos          
      MOV AH,09
      INT 21H
    
      MOV DX,0                         ;mhdenismos DX gia to loop "again3"
             
      AGAIN3:                          ;ekkinhsh loop gia eisagogh xromaton
      
      MOV xromata,DX                   ;xrhsh etiketas "xromata" gia na thn  
                                       ;metaferoume sth synarthsh input 
      CALL input
      
      mov AL,command                   ;an o paixths exei kanei la8os command=1 
      CMP AL,1 
      JE  lathos1
      
      INC DX                           ;elenxos eisagoghs ton apaitoumenon xromaton 
      CMP DX,BX                        ;tou gyrou
      JB AGAIN3                        
         
         
      CMP BX,gyroi
      JNE enter                        ;elenxos oloklhroshs ton guron pou eishgage o 
                                       ;xrhsths gia ektyposh sostoy mnm
      JMP telos4
      
      enter:
      LEA DX,entermsg                  ;ektuposh mnm se periptosh pou den exoun    
      MOV AH,09                        ;teleiosei oi guroi
      INT 21H 
      
      MOV AX,BX                        ;metafora tou epomenou gurou ston AX gia ektuposh
      INC AX
     
      CALL showrounds 
      
      CALL CLEAR
      
      DEC CX                           ;elenxos oloklhroshs ton guron pou eishgage o 
      CMP CX,0                         ;xrhsths
      JA AGAIN1
            
      lathos1:                         ;etiketa se periptosh la8ous epalh8eushs
                                       
      MOV AX,BX                        ;metafora tou gurou pou egine to la8os ston 
                                       ;AX gia ektuposh
      CALL showrounds 
      
      JMP telos5
      
      telos4:
      
      LEA DX,winmsg                    ;ektuposh mnm se periptosh nikhs   
      MOV AH,09
      INT 21H 
      
      telos5:
      
      MOV AH,4CH
      INT 21H  

;---------------------------------
inputrounds PROC  
      
      PUSH DX
      PUSH AX
      
      AGAIN: 

      LEA DX,askforroundsmsg           ;ektuposh mnm gia eisagogh guron
      MOV AH,09
      INT 21H
      
      MOV AH,01H                       ;eisagogh dekadas
      INT 21H
                                       
      MOV rounds[0],AL                 ;apo8hkeysh sth 1h 8esh tou pinaka rounds
      
      MOV AH,01H                       ;eisagogh monadas
      INT 21H    
      
      MOV rounds[1],AL                 ;apo8hkeysh sth 2h 8esh tou pinaka rounds
      
      SUB rounds[1],30H                ;metatroph se ka8aro ari8mo
      SUB rounds[0],30H
      
      CMP rounds[0],0                  ;elenxos dekadas apo 0 ws 4
      JB AGAIN                         ;kai monadas apo 0 ws 9
      
      CMP rounds[0],4
      JA AGAIN
      
      CMP rounds[1],0
      JB AGAIN  
      
      CMP rounds[1],9
      JA AGAIN     
      
      CMP rounds[0],0                  ;apofugh periptoshs guron=00
      JE STEP2
      
      JMP CONTINUE2
      
      STEP2:
      CMP rounds[1],0
      JE AGAIN 
      
      CONTINUE2:
      
      CMP rounds[0],4                  ;apofugh periptoshs guron>40
      JE STEP1
      
      JMP CONTINUE
      
      STEP1:
      CMP rounds[1],0
      JNE AGAIN 
      
      CONTINUE:   
      
      POP AX
      POP DX

      RET      
inputrounds ENDP  
;---------------------------------
round PROC 
    
       PUSH BX
       PUSH AX
                                       ;h synarthsh auth pollaplasiazei th dekada 
       MOV BL,rounds[1]                ;me 10 kai pros8etei th monada
       MOV BH,rounds[0]
        
       MOV AL,10
       
       MUL BH 
       
       MOV BH,0
       
       ADD AX,BX
       
       MOV CX,AX                       ;kai oi sunolikoi guroi apo8hkeuontai sto CX
                                       ;ston opoio den kaname push kai pop gia na 
       POP AX                          ;ton xrhsimopoihsoume sto kurio kodika
       POP BX
    
       RET 
round ENDP
;---------------------------------   
random_command PROC 
       
       PUSH BX
       PUSH AX
       PUSH DX
       PUSH CX
       PUSH DI
       PUSH SI 
                                       ;arxikopoihsh tou BX me tous gyrous gia th 
       MOV BX,gyroi                    ;dhmiourgia BX plh8ous ari8mon   
       
       again5:
       
       again_random:
       MOV AH,0                        ;Read ticks.
       INT 1AH                         ;Time of day interrupt.
                                       ;To DX low word
                                       ;To CX high word
       AND DX,11B  		               ;mask the bits, We want only 00,01,10,11
       CMP DL,0                        ;discard 0,fetch a new number
       JE again_random
       CMP DL,1                        ;discard 1,fetch a new number
       JE again_random 
       
       CMP BX,gyroi                    ;elenxos se periptosh 1ou stoixeiou
       JE save                         ;ean einai to 1o apo8hkeuetai apeu8eias
                                       
                                       ;arxh kodika gia apofugh diplon xromaton 
                                       
       MOV SI,DI                       ;edw o DI exei times apo 1 kai pano
       DEC SI                          ;meionoume ton SI gia na broume to prohgoumeno 
       MOV CL,pinakas[SI]              ;xroma sto pinaka kai to sigrinoume me to 
       CMP DL,CL                       ;neo. Ean den einai idia apo8hkeuoume sto pinaka
       JE step
       JMP save
       
       step:                           ;Ean einai idia kai to neo xroma einai to e h r tote
       CMP DL,11B                      ;allazei se q kai w antistoixa
       JE alla                         ;Ayto ginetai giati dhmiourgountai suxna dipla e kai r 
       
       MOV DL,01B 
       jmp save
       
       alla:
       MOV DL,00B
       
       save:
       MOV pinakas[DI],DL              ;apo8hkeush tou tyxaiou ari8mou sto n pinaka
       
       INC DI                          ;au3hsh kataxorhth dieu8insiodothshs
       DEC BX
       CMP BX,0
       JA again5                       ;elenxos se periptosh oloklhroshs dhmioyrgias tvn
                                       ;apaitoumenon xromaton
       POP SI                          
       POP DI
       POP CX
       POP DX
       POP AX
       POP BX 
       
       RET 
random_command ENDP
;---------------------------------   
appear_color PROC  
    
      PUSH DX
      PUSH AX
      PUSH SI
      
      MOV SI,xromata                   ;metafora ths etiketas xromata gia dieu8insiodothshs
      MOV AL,pinakas[SI]
     
      CMP AL,00B                       ;elenxos tou periexomenou ths 8eshs tou pinaka me 
      JE APPEAR_W                      ;tous 4 dunatous dipsifious diadikous ari8mous
      
      CMP AL,01B
      JE APPEAR_Q
      
      CMP AL,10B
      JE APPEAR_E   
      
      CMP AL,11B
      JE APPEAR_R  
                                       ;ektyposh xromaton analoga me to diadiko ari8mo
      APPEAR_Q: 
      
      LEA DX,seira
      MOV AH,09
      INT 21H                       ;ektyposh Q
      
      MOV DL,5BH                      
      MOV AH,02
      INT 21H 
      
      MOV DL,71H                      
      MOV AH,02
      INT 21H
      
      MOV DL,7CH                      
      MOV AH,02
      INT 21H
      
      MOV DL,20H                      
      MOV AH,02
      INT 21H 
      
      MOV DL,7CH                      
      MOV AH,02
      INT 21H 
      
      MOV DL,20H                      
      MOV AH,02
      INT 21H 
      
      MOV DL,7CH                      
      MOV AH,02
      INT 21H 
      
      MOV DL,20H                      
      MOV AH,02
      INT 21H 
      
      MOV DL,5DH                      
      MOV AH,02
      INT 21H
     
      JMP CONTINUE3
      
      APPEAR_W:                         ;ektyposh W
      
      LEA DX,seira
      MOV AH,09
      INT 21H
      
      MOV DL,5BH                      
      MOV AH,02
      INT 21H
      
      MOV DL,20H                      
      MOV AH,02
      INT 21H  
      
      MOV DL,7CH                      
      MOV AH,02
      INT 21H 
      
      MOV DL,77H                      
      MOV AH,02
      INT 21H 
      
      MOV DL,7CH                      
      MOV AH,02
      INT 21H 
      
      MOV DL,20H                      
      MOV AH,02
      INT 21H
        
      MOV DL,7CH                      
      MOV AH,02
      INT 21H
      
      MOV DL,20H                      
      MOV AH,02
      INT 21H  
      
      MOV DL,5DH                      
      MOV AH,02
      INT 21H 
      
      JMP CONTINUE3
      
      APPEAR_E:
      
      LEA DX,seira
      MOV AH,09
      INT 21H                         ;ektyposh E
      
      MOV DL,5BH                      
      MOV AH,02
      INT 21H 
      
      MOV DL,20H                      
      MOV AH,02
      INT 21H 
      
      MOV DL,7CH                      
      MOV AH,02
      INT 21H 
      
      MOV DL,20H                      
      MOV AH,02
      INT 21H  
      
      MOV DL,7CH                      
      MOV AH,02
      INT 21H 
      
      MOV DL,65H                      
      MOV AH,02
      INT 21H
      
      MOV DL,7CH                      
      MOV AH,02
      INT 21H
      
      MOV DL,20H                      
      MOV AH,02
      INT 21H 
      
      MOV DL,5DH                      
      MOV AH,02
      INT 21H
      
      JMP CONTINUE3
                                        ;ektyposh R
      APPEAR_R:
      
      LEA DX,seira
      MOV AH,09
      INT 21H
      
      MOV DL,5BH                      
      MOV AH,02
      INT 21H 
      
      MOV DL,20H                      
      MOV AH,02
      INT 21H  
      
      MOV DL,7CH                      
      MOV AH,02
      INT 21H
      
      MOV DL,20H                      
      MOV AH,02
      INT 21H  
      
      MOV DL,7CH                      
      MOV AH,02
      INT 21H
      
      MOV DL,20H                      
      MOV AH,02
      INT 21H  
      
      MOV DL,7CH                      
      MOV AH,02
      INT 21H
      
      MOV DL,72H                      
      MOV AH,02
      INT 21H
      
      MOV DL,5DH                      
      MOV AH,02
      INT 21H
     
      JMP CONTINUE3
      
      CONTINUE3:
      
      POP SI
      POP AX
      POP DX
      
      RET
appear_color ENDP
;--------------------------------- 
showrounds PROC 
      
      PUSH CX
      PUSH DX
      
      MOV CL,10
      DIV CL
      
      MOV dekada,AL                     ;metakinhsh tou apotelesmatos twn dekadwn ston al
      MOV monada,AH                     ;metakinhsh tou apotelesmatos twn monadwn ston ah

      ADD dekada,30H                    ;metatroph tou katharou arithmou twn dekadwn se ascii 
      MOV DL,dekada                     ;kai ektupwsh tou apotelesmatos
      MOV AH,02
      INT 21H

      ADD monada,30H                    ;metatroph tou katharou arithmou twn monadwn se ascii 
      MOV DL,monada                     ;kai ektupwsh tou apotelesmatos
      MOV AH,02
      INT 21H               
 
      POP DX
      POP CX
    
      RET
showrounds ENDP     
;---------------------------------    
CLEAR PROC
        
      PUSH AX
      PUSH BX
      PUSH DX
      PUSH CX
         
                                        ; clear the screen
      MOV AH,6	                        ; Use function 6 - clear screen
      MOV AL,0	                        ; clear whole screen
      MOV BH,7	                        ; use black spaces for clearing
      MOV CX,0	                        ; set upper corner value
      MOV DL,79	                        ; coord of right of screen
      MOV DH,24                        	; coord of bottom of screen
      INT 10H	                        
        
                                        ; move the cursor to the top of the screen
      MOV AH,2                      	; use function 2 - go to x,y
      MOV BH,0	                        ; display page 0
      MOV DH,0	                        ; y coordinate to move cursor to
      MOV DL,0	                        ; x coordinate to move cursor to
      INT 10H	                        

      POP CX
      POP DX
      POP BX
      POP AX
        
      RET
CLEAR ENDP
;---------------------------------     
input PROC
        
      PUSH DX 
      PUSH AX
      PUSH DI
      PUSH BX
      
      MOV AH,01H                        ;Eisagogh xromatos apo ton xrhsth
      INT 21H
                                        ;apokodikopoihsh tou ascii 16adikou 
                                        
      CMP AL,65H                        
      JE changeE
      
      CMP AL,71H
      JE changeQ
        
      CMP AL,72H
      JE changeR
        
      CMP AL,77H
      JE changeW
      
      MOV DL,07H                        ;anaparagogh 2 beep
      MOV AH,02
      INT 21H 
              
      MOV DL,07H                      
      MOV AH,02
      INT 21H 
              
      LEA DX,failmsg                    ;ektuposh mnm gia la8os eisagogh xromatos 
      MOV AH,09
      INT 21H 
      
      JMP lathos                        ;etiketa se periptosh la8ous 
        
                                        ;allagh ton ascii 16adikon se dipsifious
      changeE:                          ;diadikous ari8mous gia na ginei h sigrhsh
      MOV AL,10B                        ;me toua ari8mous pou uparxoun ston pinaka
      JMP telos2
        
      changeW:
      MOV AL,00B
      JMP telos2
        
      changeR:
      MOV AL,11B
      JMP telos2
        
      changeQ:
      MOV AL,01B
      JMP telos2
        
      telos2:
      
      MOV DI,xromata                    ;metafora ths etiketas xromata gia dieu8insiodothshs
      MOV BL,pinakas[DI]                
      CMP AL,BL                         ;sigrish tou eisagomenou xromatos me ayton pou uparxei
      JE sosto                          ;ston pinaka
      
      MOV DL,07H                      
      MOV AH,02                         ;anaparagogh 2 beep
      INT 21H
      
      MOV DL,07H                      
      MOV AH,02
      INT 21H  
      
      LEA DX,failmsg                    ;ektuposh mnm gia la8os eisagogh xromatos  
      MOV AH,09
      INT 21H 
      
      lathos:
      MOV command,1                     ;se periptosh la8ous sto command eisagetai to 1
                                        ;gia na gnorizoume sto kurio kodika ean o paixths 
                                        ;exei plhktologhsei la8os xroma.
      sosto:
      
      POP BX
      POP DI
      POP AX
      POP DX
     
      RET
input ENDP
;------------------------------- 


KODIKAS ENDS
SOROS SEGMENT STACK
db 256 dup(0)
SOROS ENDS
END ARXH
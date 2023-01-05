			; ==============================            
			; Initialisation des vecteurs            
			; ==============================
			
             org     $0
vector_000   dc.l    $ffb500
vector_001   dc.l    Main

            ; ==============================            
            ; Programme principal            
            ; ==============================
            
            org     $500
            
Main        movea.l #String1,a0
			jsr 	RemoveSpace           
			jsr     Convert
            
            illegal
            
            ; ==============================            
            ; Sous-programmes            
            ; ==============================
            
RemoveSpace movem.l d0/a0/a1,-(a7)     ; Sauvegarde les registres dans la pile.
			movea.l	a0,a1

\loop		move.b	(a0)+,d0
			cmpi.b	#' ',d0
			beq		\loop
			move.b	d0,(a1)+
			bne	\loop
            
\quit       movem.l (a7)+,a0/a1/d0   ; Restaure les registres.            
			rts

IsCharError	; Sauvegarde les registres dans la pile.
			movem.l  d0/a0,-(a7)
			
\loop       move.b   (a0)+,d0                
			beq      \false               
            cmpi.b  #'0',d0                
            blo     \true               
            cmpi.b  #'9',d0                
            bls     \loop
            
\true       ori.b   #%00000100,ccr                
            bra     \quit
            
\false      andi.b  #%11111011,ccr
			
\quit       movem.l (a7)+,d0/a0                
			rts
			
StrLen      move.l a0,-(a7)
			clr.l   d0
\loop       tst.b   (a0)+
            beq     \quit
            addq.l  #1,d0            
            bra     \loop
\quit       move.l (a7)+,a0
			rts
			
IsMaxError 	movem.l d0/a0,-(a7)
			jsr		StrLen
			cmpi.l	#5,d0
			bhi		\true
			blo		\false
			cmpi.b	#'3',(a0)+
			bhi		\true
			blo		\false
			cmpi.b	#'2',(a0)+
			bhi		\true
			blo		\false
			cmpi.b	#'7',(a0)+
			bhi		\true
			blo		\false
			cmpi.b	#'6',(a0)+
			bhi		\true
			blo		\false
			cmpi.b	#'7',(a0)+
			bhi		\true
			blo		\false
			
\false      andi.b  #%11111011,ccr
            bra     \quit	

\true       ori.b   #%00000100,ccr

\quit       movem.l (a7)+,d0/a0                
			rts
			
Convert     tst.b   (a0)                
			beq     \false
            jsr     IsCharError                
            beq     \false               
            jsr     IsMaxError                
            beq     \false               
            jsr     Atoui         
			ori.b   #%00000100,ccr                
			rts
			
\false      andi.b  #%11111011,ccr                
			rts
			
Atoui       movem.l d1/a0,-(a7)
            clr.l   d0
            clr.l   d1
            
\loop       move.b  (a0)+,d1
            beq     \quit
            subi.b  #'0',d1
            mulu.w  #10,d0            
            add.l   d1,d0
            bra     \loop
            
\quit       movem.l (a7)+,d1/a0            
			rts
			
Print       movem.l d0/d1/a0,-(a7)

\loop       move.b  (a0)+,d0                
			beq     \quit
			
            jsr     PrintChar
            
            addq.b  #1,d1                
            bra     \loop
            
\quit       movem.l (a7)+,d0/d1/a0                
			rts
			
NextOp      tst.b   (a0)                
			beq     \quit
			
            cmpi.b  #'+',(a0)                
            beq     \quit
            
            cmpi.b  #'-',(a0)                
            beq     \quit
            
            cmpi.b  #'*',(a0)                
            beq     \quit
            
            cmpi.b  #'/',(a0)                
            beq     \quit
            
            addq.l  #1,a0                
            bra     NextOp
            
\quit       rts

GetNum      movem.l d1/a1-a2,-(a7)

            movea.l a0,a1
            
            jsr     NextOp                
            movea.l a0,a2
            
            move.b  (a2),d1
            
            clr.b   (a2)
            
            movea.l a1,a0                
            jsr     Convert
            beq     \true
            
\false      move.b  d1,(a2)

            andi.b  #%11111011,ccr                
            bra     \quit
            
\true       move.b  d1,(a2)
            movea.l a2,a0
            ori.b   #%00000100,ccr
            
\quit       movem.l (a7)+,d1/a1-a2                
			rts
            ; ==============================            
            ; Données            
            ; ==============================
            
String1     dc.b    " 2 657",0

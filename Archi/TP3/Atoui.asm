 ; ==============================            
            ; Initialisation des vecteurs            
            ; ==============================
            
            org     $4
            
vector_001  dc.l    Main

            ; ==============================            
            ; Programme principal            
            ; ==============================
            
            org     $500
            
Main        movea.l #String1,a0            
			jsr     Atoui

            movea.l #String2,a0            
            jsr     Atoui
            
            illegal
            
            ; ==============================            
            ; Sous-programmes            
            ; ==============================
            
Atoui		movem.l d1/a0,-(a7)
			clr.l	d0
			clr.l	d1			
			

\loop		move.b  (a0)+,d1            
			beq     quit
			
			mulu.w	#10,d0
			sub.l   #'0',d1            
			add.l 	d1,d0
			          
			bra     \loop
			
			
quit        movem.l	(a7)+,d1/a0
			rts
			
			
            ; ==============================            
            ; Données            
            ; ==============================
            
String1     dc.b    "12354",0
String2     dc.b    "95",0

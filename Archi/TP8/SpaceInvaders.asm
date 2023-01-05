                    ; ==============================                    
                    ; Définition des constantes                    
                    ; ==============================
                    
                    ; Mémoire vidéo                    
                    ; ------------------------------
                    
VIDEO_START         equ     $ffb500                         ; Adresse de départ
VIDEO_WIDTH         equ     480                             ; Largeur en pixels        
VIDEO_HEIGHT		equ     320                             ; Hauteur en pixels          
VIDEO_SIZE  		equ     (VIDEO_WIDTH*VIDEO_HEIGHT/8)    ; Taille en octets       
BYTE_PER_LINE		equ     (VIDEO_WIDTH/8)                 ; Nombre d'octets par ligne
					
                    ; ==============================                    
                    ; Initialisation des vecteurs                    
                    ; ==============================
                    
                    org     $0
vector_000          dc.l    VIDEO_START                     ; Valeur initiale de A7
vector_001          dc.l    Main                            ; Valeur initiale du PC

                    ; ==============================                    
                    ; Programme principal                    
                    ; ==============================
                    
                    org     $500
                    
Main                ; Test 1                    
					;move.l  #$f0f0f0f0,d0                    
					;jsr     FillScreen    
					                
                    ; Test 2                    
                    ;move.l  #$f0f0f0f0,d0                    
                    ;jsr     FillScreen
                    
                    ; Test 3                    
                    ;move.l  #$fff0fff0,d0                    
                    ;jsr     FillScreen
                    
                    ; Test 4                    
                    ;moveq.l #$0,d0                    
                    ;jsr     FillScreen
                    
                    jsr		WhiteSquare128
                    illegal
                    
                    ; ==============================                    
                    ; Sous-programmes       va t elle trouver ce message ?             
                    ; ==============================
                    
FillScreen			movem.l	d1/a0,-(a7)
					move.l	#VIDEO_START,a0
					move.l	#(VIDEO_SIZE/4),d1
					
\loop				move.l	d0,(a0)+
					subq.l	#1,d1
					bne		\loop
					movem.l (a7)+,d1/a0
					rts		
					
Hlines				movem.l	d0/d1/d2/d3/a0,-(a7)
					move.l	#$ffffffff,d0
					move.l	#VIDEO_START,a0
					move.l	#(VIDEO_SIZE/4),d1
					move.l	#0,d2
					move.l	#(BYTE_PER_LINE/4),d3
					
\loop				cmpi.l	#0,d3
					beq.b	\EndLine
					move.l 	d0,(a0)+
					subq.l	#1,d1
					subq.b	#1,d3
					bra		\loop	
					
\EndLine			move.l	#(BYTE_PER_LINE/4),d3
					addq.b	#1,d2	
					cmpi.l	#8,d2
					bhs.b	\EndStrip
					bra		\loop

\EndStrip			cmpi.l	#0,d1
					beq		\quit
					move.l	#0,d2
					cmpi.l	#0,d0
					beq		\White
					move.l	#$00000000,d0
					bra 	\loop

\White				move.l	#$ffffffff,d0
					bra		\loop	

\quit				movem.l (a7)+,d0/d1/d2/d3/a0
					rts	
                    
WhiteSquare32		movem.l	a0/d1/d0/d2,-(a7)
					move.l 	#144,d0
					mulu.w	#60,d0
					add.l	#VIDEO_START,d0
					move.l	d0,a0
					move.l	#32,d1
					move.l	#14,d2
					
\drawSquare			cmpi.l	#0,d1
					beq		\quit
					move.l	#15,d2
					dbra	d1,\drawLine
					
\drawLine			cmpi.l	#0,d2
					beq		\drawSquare
					cmpi.l	#8,d2
					beq		\drawWhite
					move.l	#$0,(a0)+
					dbra	d2,\drawLine
					
\drawWhite			move.l 	#$ffffffff,(a0)+
					dbra	d2,\drawLine
\quit				movem.l	(a7)+,a0/d0-d2
					rts
					
WhiteSquare128		movem.l	a0/d1/d0/d2/d3,-(a7)
					move.l 	#96,d0
					mulu.w	#60,d0
					add.l	#VIDEO_START,d0
					move.l	d0,a0
					move.l	#128,d1
					
\drawSquare			cmpi.l	#0,d1
					beq		\quit
					move.l	#30,d2
					dbra	d1,\drawLine
					
\drawLine			cmpi.l	#0,d2
					beq		\drawSquare
					move.l	#7,d3
					cmpi.l	#19,d2
					beq		\drawWhite
					move.w	#$0,(a0)+
					dbra	d2,\drawLine
					
\drawWhite			move.w 	#$ffff,(a0)+
					subq.l	#1,d2
					dbra	d3,\drawWhite
					addq.l	#1,d2
					dbra	d2,\drawLine
					
\quit				movem.l	(a7)+,a0/d0-d3
					rts
                    ; ==============================                    
                    ; Données                    
                    ; ==============================
                    
                    ; ...                   
                    ; ...                    
                    ; ...


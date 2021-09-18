(defun c:kpente_texte_situation ( )
;; Bonjour, cette commande autocad cr�e, en selectionnant deux points, un texte avec la pente en % et une fl�che.
;; Pour l'utiliser: 1) copiez l'entier de ce texte dans la barre de commande de votre fichier sur autocad.
;;					2) taper "kpente_texte_situation" (sans les guillemets) pour lancer la fonction 


	(setq a_fp 0.44810)
	(setq l_fp 0.41533)
	
	(setq a_fm 0.88564)
	(setq l_fm 0.23239)
	
	(setq a_ff 2.69349)
	(setq l_ff 0.41533)
	
	(setq a_t 1.57000)
	(setq l_t 0.31263)
	
	(setq hauteurtexte 0.25)
	(setq style (getvar "textstyle"))
	(if (= facteur nil)
		(setq facteur 1.0)
		)
	(while
		(/= nil (progn
			(initget 1 "Facteur")
			(setq p1 (getpoint "\nSp�cifiez le premier point ou [Facteur]: "))
			))
		(if (= p1 "Facteur")
			(progn
				(setq textechoix (strcat "\nD�finissez le facteur d'agrandissement ou ENTER[" (rtos facteur 2 1) "]:")) 
				(setq choix (getreal textechoix))
				(if (/= choix nil)
					(setq facteur choix)
					)
				)
			(if (= p1 nil)
				(quit)
				(progn
					(setq p2 (getpoint p1 "\nSp�cifiez le deuxi�me point: "))

					;; socker les variables systeme et les mettre � 0
					(setq 
						os (getvar "osmode")
						dim (getvar "dimzin")
						)
					(setvar "osmode" 0)
					(setvar "dimzin" 0)

					;;Faire ne sorte que le point le plus Haut (z) soit en p1
					(if (< (caddr p1) (caddr p2))
						(and
							(setq p p1)
							(setq p1 p2)
							(setq p2 p)
							) ;; and
						) ;; if
						
					;; calcul des distances (sur x, sur y et sur z)
					(setq dx (- (car p2) (car p1)))
					(setq dy (- (cadr p2) (cadr p1)))
					(setq dz (- (caddr p2) (caddr p1)))
					
					;; variable pour savoir la direction de la fl�che (si "+" = fl�che vers la droite, si "-" fl�che vers la gauche)
					(setq direction 
						(if (> (car p1) (car p2))
							"-"
							"+"
							)
						)
						
					;; determiner la pente entre les deux points
					(setq pente (abs (* (/ dz (sqrt (+ (* dx dx) (* dy dy)))) 100)))

					;; d�termine l'angle du texte et de la fl�che dans le SCU utilisateur
					(setq angle
						(if (> dx 0)
							(atan dy dx)
							(atan (* -1.0 dy) (* -1 dx))
							)
						)
						
					;; d�termine le point de d�part pour l'insertion du texte et de la fl�che
					(setq pointmilieu
						(list
							(/ (+ (car p1) (car p2)) 2.00)
							(/ (+ (cadr p1) (cadr p2)) 2.00)
							0.00
							)
						)
						
					;; cr�e la chaine de texte � afficher comme pente
					(setq texte (strcat (rtos pente 2 1) "%"))
					
					;; transformation des points de coordonn�es utilisateurs � coordonn�es g�n�rales
					(setq 
						p1_final (trans p1 1 0)
						p2_final (trans p2 1 0)
						pointmilieu_final (trans pointmilieu 1 0)
						)
						
					(setq dx_final (- (car p2_final) (car p1_final)))
					(setq dy_final (- (cadr p2_final) (cadr p1_final)))
					(setq difference_angle (- (atan dy dx) (atan dy_final dx_final)))
					(setq angle_final (- angle difference_angle))
					
					(entmakex
						(list
							(cons 0 "LWPOLYLINE")
							(cons 100 "AcDbEntity")
							;;(cons 8 calque)
							(cons 100 "AcDbPolyline")
							(cons 90 3)					
							(cons 70 0)
							(cons 10 (if (= direction "+")
								(polar pointmilieu_final (+ a_fp angle_final) (* facteur l_fp))
								(polar pointmilieu_final (+ (- PI a_fp) angle_final) (* facteur l_fp))
								)) ;; if cons
							(cons 40 0)
							(cons 41 (* facteur 0.1))
							(cons 10 (if (= direction "+")
								(polar pointmilieu_final (+ a_fm angle_final) (* facteur l_fm))
								(polar pointmilieu_final (+ (- PI a_fm) angle_final) (* facteur l_fm))
								)) ;; if cons
							(cons 40 0)
							(cons 41 0)
							(cons 10 (if (= direction "+")
								(polar pointmilieu_final (+ a_ff angle_final) (* facteur l_ff))
								(polar pointmilieu_final (+ (- PI a_ff) angle_final) (* facteur l_ff))
								)) ;; if cons
							) ;; entmakex
						)
					(entmakex 
						(list 
							(cons 0 "MTEXT")
							;;(cons 8 calque)
							(cons 100 "AcDbEntity")
							(cons 100 "AcDbMText")
							(cons 10 (polar pointmilieu_final (+ a_t angle_final) (* facteur l_t)))	;;point d'insertion
							(cons 40 (* facteur hauteurtexte))
							(cons 41 2.0)
							(cons 71 8)
							(cons 1 texte)
							(cons 7 style)
							(cons 50 angle)
							)
						)
					;; retablissement des variables syst�me
					(setvar "osmode" os)
					(setvar "dimzin" dim)
					)
				)
			)
		)
	
;; Futures modifications:
;; Ajouter Choix d'�chelle
;; Ajouter pr�fixe/suffixe
	)
(defun c:kpente_texte_PL ( )
;; Bonjour, cette commande autocad crée, en selectionnant deux points, un texte avec la pente en % et une flèche.
;; Pour l'utiliser: 1) copiez l'entier de ce texte dans la barre de commande de votre fichier sur autocad.
;;					2) taper "kpentetxt" (sans les guillemets) pour lancer la fonction 


	(setq a_fp 0.44810)
	(setq l_fp 0.41533)
	
	(setq a_fm 0.88564)
	(setq l_fm 0.23239)
	
	(setq a_ff 2.69349)
	(setq l_ff 0.41533)
	
	(setq a_t 1.57000)
	(setq l_t 0.31263)
	
	;;(setq calque "02 - Dévers")
	(setq hauteurtexte 0.25)
	(setq style (getvar "textstyle"))
	(if (= FacteurTexte nil)
		(setq FacteurTexte 1.0)
		)
	(if (= DeformationY nil)
		(setq DeformationY 10.0)
		)
	
	(setq 
		option nil
		option2 nil
		)
		
	(while 
		(not (= nil (progn		
			(initget  1 "Texte Deformation")
			(setq option (getpoint "\nSpécifiez le premier point ou [facteur du Texte/Déformation de l'axe vértical]: "))
			option
			)))
		(if (= option "Texte")
			(progn
			;;si oui
			
				;; socker les variables systeme et les mettre à 0
				(setq 
					VarDimzin (getvar "dimzin")
					)
				(setvar "dimzin" 0)
				
				;; Redéfinition du facteur
				(setq textechoix (strcat 
					"\nDéfinissez le facteur d'agrandissement du texte (ex: un facteur de \"1.0\" donnera une hauteur de texte de \"0.25\"): <"
					(rtos FacteurTexte 2 1)
					">:"
					)) 
				(initget 6)
				(setq option2 (getreal textechoix))
				(if (/= option2 nil)
					(setq FacteurTexte option2)
					)
				
				;; rétablissement des variables système
				(setvar "dimzin" VarDimzin)
				) ;;fin de si oui
			(if (= option "Deformation")
				(progn
				;;si oui
				
					;; socker les variables systeme et les mettre à 0
					(setq 
						VarDimzin (getvar "dimzin")
						)
					(setvar "dimzin" 0)
					
					;; Redéfinition du facteur
					(setq textechoix (strcat
						"\nDéfinissez la déformation de l'axe vertical (ex: si les echelles sont 1:500/50, alors le facteur est de 10) <"
						(rtos DeformationY 2 1)
						">:"
						)) 
					(initget 6)
					(setq option3 (getreal textechoix))
					(if (/= option3 nil)
						(setq DeformationY option3)
						)
					
					;; rétablissement des variables système
					(setvar "dimzin" VarDimzin)
					) ;;fin de si oui
				(progn
				;;si non
					(setq p1 option)
					(setq p2 (getpoint p1 "\nSpécifiez le deuxième point: "))
					(if (< (cadr p1) (cadr p2))
						(and
							(setq p p1)
							(setq p1 p2)
							(setq p2 p)
							) ;; and
						) ;; if
					(setq dX (- (car p2) (car p1)))
					(setq dY (- (cadr p2) (cadr p1)))
					(setq direction 
						(if (> (car p1) (car p2))
							"-"
							"+"
							)
						)
					(setq pente (abs (* (/ dY dX DeformationY) 100)))
					(setq angle 
						(if (> dX 0)
							(atan dY dX)
							(atan (* -1.0 dY) (* -1 dX))
							)
						)
					(setq pointmilieu
						(list
							(/ (+ (car p1) (car p2)) 2.00)
							(/ (+ (cadr p1) (cadr p2)) 2.00)
							0.00
							)
						)
					(setq texte (strcat (rtos pente 2 1) "%"))
					(entmakex
						(list
							(cons 0 "LWPOLYLINE")
							(cons 100 "AcDbEntity")
							;;(cons 8 calque)
							(cons 100 "AcDbPolyline")
							(cons 90 3)					
							(cons 70 0)
							(cons 10 (if (= direction "+")
								(polar pointmilieu (+ a_fp angle) (* FacteurTexte l_fp))
								(polar pointmilieu (+ (- PI a_fp) angle) (* FacteurTexte l_fp))
								)) ;; if cons
							(cons 40 0)
							(cons 41 (* FacteurTexte 0.1))
							(cons 10 (if (= direction "+")
								(polar pointmilieu (+ a_fm angle) (* FacteurTexte l_fm))
								(polar pointmilieu (+ (- PI a_fm) angle) (* FacteurTexte l_fm))
								)) ;; if cons
							(cons 40 0)
							(cons 41 0)
							(cons 10 (if (= direction "+")
								(polar pointmilieu (+ a_ff angle) (* FacteurTexte l_ff))
								(polar pointmilieu (+ (- PI a_ff) angle) (* FacteurTexte l_ff))
								)) ;; if cons
							) ;; entmakex
						)
					(entmakex 
						(list 
							(cons 0 "MTEXT")
							;;(cons 8 calque)
							(cons 100 "AcDbEntity")
							(cons 100 "AcDbMText")
							(cons 10 (polar pointmilieu (+ a_t angle) (* FacteurTexte l_t)))	;;point d'insertion
							(cons 40 (* FacteurTexte hauteurtexte))
							(cons 41 2.0)
							(cons 71 8)
							(cons 1 texte)
							(cons 7 style)
							(cons 50 angle)
							)
						)
					) ;;fin de si non
				);; fin de if
			);; fin de if
		);; fin de while
		
;; Futures modifications:
;; Ajouter préfixe/suffixe
	)	

	
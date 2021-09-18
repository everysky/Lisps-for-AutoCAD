(defun C:kaltitude_en_situation ()
;; prends des points en altitude et ajoute un texte centré sur ce point avec l'altitude au cm


	(setq hauteurtexte 0.25)
	(setq style (getvar "textstyle"))
	
	(if (= FacteurTexte nil)
		(setq FacteurTexte 1.0)
		)
		
	(setq 
		option nil
		option2 nil
		)
		
	(while 
		(not (= nil (progn		
			(initget  6 "Facteur")
			(setq option (getpoint "\nChoisissez un point dont vous voulez l'altitude ou [Facteur]: "))
			option
			)))
		(if (= option "Facteur")
			(progn
			
				;; socker les variables systeme et les mettre à 0
				(setq 
					VarDimzin (getvar "dimzin")
					)
				(setvar "dimzin" 0)
				
				;; Redéfinition du facteur
				(setq textechoix (strcat "\nDéfinissez le facteur d'agrandissement ou ENTER[" (rtos FacteurTexte 2 1) "]:")) 
				(setq option2 (getreal textechoix))
				(if (/= option2 nil)
					(setq FacteurTexte option2)
					)
				
				;; rétablissement des variables système
				(setvar "dimzin" VarDimzin)
				)
				
			(progn
				(setq 
					altitude (caddr option)
					p1 (list (car option) (cadr option) 0)
					p2 (getpoint p1 "\nSpécifiez la direction du texte: ")
					p2	(list (car p2) (cadr p2) 0)
					)
					
				;; calcul des distances (sur x, sur y et sur z)
				(setq dx (- (car p2) (car p1)))
				(setq dy (- (cadr p2) (cadr p1)))
				
				;; détermine l'angle du texte et de la flèche dans le SCU utilisateur
				(setq angle
					(if (> dx 0)
						(atan dy dx)
						(atan (* -1.0 dy) (* -1 dx))
						)
					)
				
				;; socker les variables systeme et les mettre à 0
				(setq 
					VarDimzin (getvar "dimzin")
					)
				(setvar "dimzin" 0)
				
				;; crée la chaine de texte à afficher comme pente
				(setq texte (strcat "+" (rtos altitude 2 2)))
				
				;; rétablissement des variables système
				(setvar "dimzin" VarDimzin)
				
				;; transformation des points de coordonnées utilisateurs à coordonnées générales
				(setq 
					p1_final (trans p1 1 0)
					p1_final (list (car p1_final) (cadr p1_final) 0)
					)
				
				(entmakex 
					(list 
						(cons 0 "MTEXT")
						;;(cons 8 calque)
						(cons 100 "AcDbEntity")
						(cons 100 "AcDbMText")
						(cons 10 p1_final)	;;point d'insertion
						(cons 40 (* FacteurTexte hauteurtexte))
						(cons 71 5)
						(cons 1 texte)
						(cons 7 style)
						(cons 50 angle)
						(cons 90 3)			;; utiliser la couleur d'arrière plan du dessin comme masque d'arrière plan
						(cons 45 1.1)		;; Facteur de décalage de bordure
						)
					)
					
				)
			)
		
		)
	)
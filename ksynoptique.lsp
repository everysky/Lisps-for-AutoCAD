;;kpsynoptique

(defun C:ksynoptique ()
	
			;;variables de base
	(setq listetransfert ktransfert)
	
	(setq CalqueLigneSynoptique "S+N - pl_ligne_050")
	
	(setq CalqueTexteKilometrage "S+N - pl_piano_texte_025")
	(setq HauteurTexteKilometrage 2.50)
	(setq DecalagehorizontalTexteKilometrage 2.00)
	(setq CalqueLigneKilometrage "S+N - pl_piano_ligne_018")
	

	(setq CalqueTexteLargeurChaussee "S+N - pl_piano_texte_018")
	(setq HauteurTexteLargeurChaussee 2.50)
	(setq DecalagehorizontalTexteLargeurChaussee 2.00)
	(setq CalqueLigneLargeurChaussee "S+N - pl_piano_ligne_018")
	

	(setq CalqueTexteLargeurGauche "S+N - pl_piano_texte_025")
	(setq HauteurTexteLargeurGauche 2.50)
	(setq DecalagehorizontalTexteLargeurGauche 2.00)
	(setq CalqueLigneLargeurGauche "S+N - pl_piano_ligne_018")

	
	(setq CalqueTexteLargeurDroite "S+N - pl_piano_texte_018")
	(setq HauteurTexteLargeurDroite 2.50)
	(setq DecalagehorizontalTexteLargeurDroite 2.00)
	(setq CalqueLigneLargeurDroite "S+N - pl_piano_ligne_018")
	
	
	(setq CalqueTextePenteGauche "S+N - pl_piano_texte_025")
	(setq HauteurTextePenteGauche 2.50)
	(setq DecalagehorizontalTextePenteGauche 2.00)
	(setq CalqueLignePenteGauche "S+N - pl_piano_ligne_018")
	
	
	(setq CalqueTextePenteDroite "S+N - pl_piano_texte_018")
	(setq HauteurTextePenteDroite 2.50)
	(setq DecalagehorizontalTextePenteDroite 2.00)
	(setq CalqueLignePenteDroite "S+N - pl_piano_ligne_018")
	
				;; entrées utilisateur
				
	(if (= facteur nil)
		(setq facteur (getreal "\nDéfinissez le facteur d'agrandissement de l'axe vértical (ex: si 5 fois plus grand que la réalité => 5): "))
		)
	(if (= echelle nil)
		(setq echelle (getreal "\nDéfinissez l'echelle du texte (ex: 1:500 => 500): "))
		)

		
	(if (= origine nil)
		(setq origine (getpoint "\nDéfinissez le point d'origine du Piano: "))
		)
	(if (= ligne1 nil)
		(setq ligne1 (getpoint "\nSélectionez un point sur la ligne du piano qui sépare les kilométrages et la largeur de la chaussée: "))
		)
	(if (= ligne2 nil)
		(setq ligne2 (getpoint "\nSélectionez un point sur la ligne du piano qui sépare la largeur de la chaussée et la largeur du dévers Ouest: "))
		)
	(if (= ligne3 nil)
		(setq ligne3 (getpoint "\nSélectionez un point sur la ligne du piano qui sépare la largeur du dévers Ouest et la largeur du dévers Est: "))
		)
	(if (= ligne4 nil)
		(setq ligne4 (getpoint "\nSélectionez un point sur la ligne du piano qui sépare la largeur du dévers Est et la pente du dévers Ouest: "))
		)
	(if (= ligne5 nil)
		(setq ligne5 (getpoint "\nSélectionez un point sur la ligne du piano qui sépare la pente du dévers Ouest et la pente du dévers Est: "))
		)
	(if (= ligne6 nil)
		(setq ligne6 (getpoint "\nSélectionez un point sur la ligne du bas du piano: "))
		)
	
	(setq ProfilOrigine (getpoint "\nSélectionner le point à l'intersection de votre axe de chaussée et votre profil initial: "))
	(setq ProfilPoint ProfilOrigine)
	(setq KilonetrageProfilOrigine (getreal "\n Définissez le kilométrage du profil que vous avez sélectionné [m]: "))
	(setq ProfilKilometrage KilonetrageProfilOrigine)
	(setq DistanceProfil (getreal "\nDéfinissez la distance entre chaque profil [m]: "))
	
	(while (> (length listetransfert) 0)
		(setq profil (car listetransfert))
		(setq listetransfert (cdr listetransfert))
		
		;; Ajout des points dans les polyligne 
		
		(setq PointToit (list (cons 10 (list
			(car ProfilPoint)
			(- (cadr ProfilPoint) (* (cadr profil) facteur))
			0.0
			))))
		(setq ListePointToit (append ListePointToit PointToit))

		(setq PointGauche (list (cons 10 (list
			(car ProfilPoint)
			(- (cadr ProfilPoint) (* (cadr profil) facteur) (* (car (caddr profil)) facteur))
			0.0
			))))
		(setq ListePointGauche (append ListePointGauche PointGauche))
		
		(setq PointDroite (list (cons 10 (list
			(car ProfilPoint)
			(- (cadr ProfilPoint) (* (cadr profil) facteur) (* (car (cadddr profil)) facteur))
			0.0
			))))
		(setq ListePointDroite (append ListePointDroite PointDroite))
		
		;; calcul des pentes
		
		(setq PenteGauche (* (/ (cadr (caddr profil)) (car (caddr profil))) 100.0))
		(setq PenteDroite (* (/ (cadr (cadddr profil)) (car (cadddr profil))) 100.0))
		
		;; création des objets du piano
		
		(setq os (getvar "osmode"))
		(setvar "osmode" 0)
		
		(entmakex	;; texte kilometrage
			(list
				(cons 0 "TEXT")
				(cons 8 CalqueTexteKilometrage)
				(cons 10 (list 0.0 0.0 0.0))
				(cons 40 (* echelle (/ HauteurTexteKilometrage 1000.0)))
				(cons 1 (rtos ProfilKilometrage 2 2))
				(cons 50 4.71238898)
				(cons 41 1.00)
				(cons 7 "romans095")
				(cons 72 1)
				(cons 73 2)
				(cons 11 (list (+ (car ProfilPoint) (* echelle (/ DecalagehorizontalTexteKilometrage 1000.0))) (/ (+ (cadr origine) (cadr ligne1)) 2.000) 0.0))
				)
			)
		(entmakex	;; ligne kilometrage
			(list
				(cons 0 "LWPOLYLINE")
				(cons 100 "AcDbEntity")
				(cons 8 CalqueLigneKilometrage)
				(cons 100 "AcDbPolyline")
				(cons 90 2)					
				(cons 70 0)
				(cons 10 (list (car ProfilPoint) (cadr origine) 0.0))
				(cons 10 (list (car ProfilPoint) (cadr ligne1) 0.0))
				)
			)
		(entmakex 	;; texte largeur chaussée
			(list
				(cons 0 "TEXT")
				(cons 8 CalqueTexteLargeurChaussee)
				(cons 10 (list 0.0 0.0 0.0))
				(cons 40 (* echelle (/ HauteurTexteLargeurChaussee 1000.0)))
				(cons 1 (rtos (+ (abs (car (caddr profil))) (abs (car (cadddr profil)))) 2 2))
				(cons 50 4.71238898)
				(cons 41 1.00)
				(cons 7 "romans095")
				(cons 72 1)
				(cons 73 2)
				(cons 11 (list (+ (car ProfilPoint) (* echelle (/ DecalagehorizontalTexteLargeurChaussee 1000.0))) (/ (+ (cadr ligne1) (cadr ligne2)) 2.000) 0.0))
				)
			)
		(entmakex	;; ligne largeur chaussée
			(list
				(cons 0 "LWPOLYLINE")
				(cons 100 "AcDbEntity")
				(cons 8 CalqueLigneLargeurChaussee)
				(cons 100 "AcDbPolyline")
				(cons 90 2)					
				(cons 70 0)
				(cons 10 (list (car ProfilPoint) (cadr ligne1) 0.0))
				(cons 10 (list (car ProfilPoint) (cadr ligne2) 0.0))
				)
			)
		(entmakex 	;; texte largeur gauche
			(list
				(cons 0 "TEXT")
				(cons 8 CalqueTexteLargeurGauche)
				(cons 10 (list 0.0 0.0 0.0))
				(cons 40 (* echelle (/ HauteurTexteLargeurGauche 1000.0)))
				(cons 1 (rtos (abs (car (caddr profil))) 2 2))
				(cons 50 4.71238898)
				(cons 41 1.00)
				(cons 7 "romans095")
				(cons 72 1)
				(cons 73 2)
				(cons 11 (list (+ (car ProfilPoint) (* echelle (/ DecalagehorizontalTexteLargeurGauche 1000.0))) (/ (+ (cadr ligne2) (cadr ligne3)) 2.000) 0.0))
				)
			)
		(entmakex	;; ligne largeur gauche
			(list
				(cons 0 "LWPOLYLINE")
				(cons 100 "AcDbEntity")
				(cons 8 CalqueLigneLargeurGauche)
				(cons 100 "AcDbPolyline")
				(cons 90 2)					
				(cons 70 0)
				(cons 10 (list (car ProfilPoint) (cadr ligne2) 0.0))
				(cons 10 (list (car ProfilPoint) (cadr ligne3) 0.0))
				)
			)
		(entmakex 	;; texte largeur droite
			(list
				(cons 0 "TEXT")
				(cons 8 CalqueTexteLargeurDroite)
				(cons 10 (list 0.0 0.0 0.0))
				(cons 40 (* echelle (/ HauteurTexteLargeurDroite 1000.0)))
				(cons 1 (rtos (abs (car (cadddr profil))) 2 2))
				(cons 50 4.71238898)
				(cons 41 1.00)
				(cons 7 "romans095")
				(cons 72 1)
				(cons 73 2)
				(cons 11 (list (+ (car ProfilPoint) (* echelle (/ DecalagehorizontalTexteLargeurDroite 1000.0))) (/ (+ (cadr ligne3) (cadr ligne4)) 2.000) 0.0))
				)
			)
		(entmakex	;; ligne largeur droite
			(list
				(cons 0 "LWPOLYLINE")
				(cons 100 "AcDbEntity")
				(cons 8 CalqueLigneLargeurDroite)
				(cons 100 "AcDbPolyline")
				(cons 90 2)					
				(cons 70 0)
				(cons 10 (list (car ProfilPoint) (cadr ligne3) 0.0))
				(cons 10 (list (car ProfilPoint) (cadr ligne4) 0.0))
				)
			)
		(entmakex 	;; texte pente gauche
			(list
				(cons 0 "TEXT")
				(cons 8 CalqueTextePenteGauche)
				(cons 10 (list 0.0 0.0 0.0))
				(cons 40 (* echelle (/ HauteurTextePenteGauche 1000.0)))
				(cons 1 (strcat (rtos (abs PenteGauche) 2 1) "%"))
				(cons 50 4.71238898)
				(cons 41 1.00)
				(cons 7 "romans095")
				(cons 72 1)
				(cons 73 2)
				(cons 11 (list (+ (car ProfilPoint) (* echelle (/ DecalagehorizontalTextePenteGauche 1000.0))) (/ (+ (cadr ligne4) (cadr ligne5)) 2.000) 0.0))
				)
			)
		(entmakex	;; ligne pente gauche
			(list
				(cons 0 "LWPOLYLINE")
				(cons 100 "AcDbEntity")
				(cons 8 CalqueLignePenteGauche)
				(cons 100 "AcDbPolyline")
				(cons 90 2)					
				(cons 70 0)
				(cons 10 (list (car ProfilPoint) (cadr ligne4) 0.0))
				(cons 10 (list (car ProfilPoint) (cadr ligne5) 0.0))
				)
			)
		(entmakex 	;; texte pente droite
			(list
				(cons 0 "TEXT")
				(cons 8 CalqueTextePenteDroite)
				(cons 10 (list 0.0 0.0 0.0))
				(cons 40 (* echelle (/ HauteurTextePenteDroite 1000.0)))
				(cons 1 (strcat (rtos (abs PenteDroite) 2 1) "%"))
				(cons 50 4.71238898)
				(cons 41 1.00)
				(cons 7 "romans095")
				(cons 72 1)
				(cons 73 2)
				(cons 11 (list (+ (car ProfilPoint) (* echelle (/ DecalagehorizontalTextePenteDroite 1000.0))) (/ (+ (cadr ligne5) (cadr ligne6)) 2.000) 0.0))
				)
			)
		(entmakex	;; ligne pente droite
			(list
				(cons 0 "LWPOLYLINE")
				(cons 100 "AcDbEntity")
				(cons 8 CalqueLignePenteDroite)
				(cons 100 "AcDbPolyline")
				(cons 90 2)					
				(cons 70 0)
				(cons 10 (list (car ProfilPoint) (cadr ligne5) 0.0))
				(cons 10 (list (car ProfilPoint) (cadr ligne6) 0.0))
				)
			)
		
		(setvar "osmode" os)
		
		(setq ProfilPoint (list (+ (car ProfilPoint) DistanceProfil) (cadr ProfilPoint) 0.0))	;; imcrémenter le point du profil d'une distance de profil
		(setq ProfilKilometrage (+ ProfilKilometrage DistanceProfil))							;; imcrémenter le kilométrage d'une distance de profil
		)
		

	(entmakex 
		(append 
			(list 
				(cons 0 "LWPOLYLINE")
				(cons 100 "AcDbEntity")
				(cons 8 CalqueLigneSynoptique)
				(cons 100 "AcDbPolyline")
				(cons 90 (length ListePointToit))
				(cons 70 0)
				)
			ListePointToit
			)
		)
	(entmakex 
		(append 
			(list 
				(cons 0 "LWPOLYLINE")
				(cons 100 "AcDbEntity")
				(cons 8 CalqueLigneSynoptique)
				(cons 100 "AcDbPolyline")
				(cons 90 (length ListePointGauche))
				(cons 70 0)
				)
			ListePointGauche
			)
		)
	(entmakex 
		(append 
			(list 
				(cons 0 "LWPOLYLINE")
				(cons 100 "AcDbEntity")
				(cons 8 CalqueLigneSynoptique)
				(cons 100 "AcDbPolyline")
				(cons 90 (length ListePointDroite))
				(cons 70 0)
				)
			ListePointDroite
			)
		)
	(setq ListePointToit nil)
	(setq ListePointGauche nil)
	(setq ListePointDroite nil)
	)
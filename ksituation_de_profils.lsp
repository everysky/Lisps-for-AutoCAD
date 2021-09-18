;; A partir des profils en travers, et de l'axe en situation, recréer les les points d'implantation en situation et le tableau de coordonnées
(defun C:kprofils_a_situation ()
	(if (= ktransfert nil)
		(progn
			(setq pointGauche (getpoint "\nCliquer sur le point gauche de la chaussée: "))
			(setq pointToit (getpoint "\nCliquer sur le point du sommet du Toit: "))
			(setq pointAxe (getpoint "\nChoisissez un point sur l'axe du profil: "))
			(setq pointDroite (getpoint "\nCliquer sur le point droite de la chaussée: "))
			
			(setq altgauche (cadr pointGauche))
			(setq alttoit (cadr pointToit))
			(setq altdroite (cadr pointDroite))
			
			(setq axetoit (- (car pointToit) (car pointAxe)))
			(setq toitgauche (- (car pointGauche) (car pointToit)))
			(setq toitdroite (- (car pointDroite) (car pointToit)))
			
			(setq profil (list axetoit altgauche toitgauche alttoit toitdroite altdroite))
			(setq ktransfert (list profil))
			)
		)
	(while (setq pointGauche (getpoint "\nCliquer sur le point gauche de la chaussée ou ENTER: "))
		(setq pointToit (getpoint "\nCliquer sur le point du sommet du Toit: "))
		(setq pointAxe (getpoint "\nChoisissez un point sur l'axe du profil: "))
		(setq pointDroite (getpoint "\nCliquer sur le point droite de la chaussée: "))
		
		(setq altgauche (cadr pointGauche))
		(setq alttoit (cadr pointToit))
		(setq altdroite (cadr pointDroite))
		
		(setq axetoit (- (car pointToit) (car pointAxe)))
		(setq toitgauche (- (car pointGauche) (car pointToit)))
		(setq toitdroite (- (car pointDroite) (car pointToit)))
		
		(setq profil (list axetoit altgauche toitgauche alttoit toitdroite altdroite))
		(setq ktransfert (append ktransfert (list profil)))
		)
	(length ktransfert)
	)
	
	

(setq ktransfert '(
(0.0 397.54 -4.53092 397.62 4.46908 397.492)
(0.0 397.59 -4.52801 397.69 4.47199 397.541)
(0.0 397.643 -4.54272 397.76 4.4749 397.587) 
(-1.36637 397.736 -4.54069 397.872 5.84418 397.694) 
(-3.10199 397.86 -4.59341 397.998 7.58272 397.767) 
(-3.41636 397.935 -4.5 398.07 7.9 397.829) 
(-3.41636 398.034 -6.75176 398.17 7.90783 397.93) 
(-3.38393 398.05 -4.5 398.243 7.89258 397.886) 
(-1.96441 397.99 -4.5 398.208 6.45678 397.92) 
(-0.200306 398.04 -4.5 398.159 4.69559 397.964) 
(0.0 398.079 -4.5018 398.214 4.4982 398.011) 
(0.0 398.11 -4.49889 398.25 4.50111 398.043) 
(0.0 398.154 -4.49598 398.25 4.50402 398.058) 
(0.0 398.097 -4.49307 398.224 4.50693 398.057) 
(0.0 398.053 -4.49016 398.16 4.50984 398.028) 
(0.0 397.972 -4.48725 398.074 4.51275 397.91) 
(0.0 397.91 -4.48434 397.98 4.52819 397.858) 
(0.0 397.774 -4.48975 397.88 4.51027 397.753) 
(0.0 397.623 -4.59502 397.74 4.40518 397.61) 
(-0.320397 397.497 -4.50503 397.602 4.49559 397.431) 
(-0.679966 397.366 -4.50102 397.469 7.6498 397.257) 
(-0.935787 397.243 -4.66413 397.329 9.03577 397.048) 
(-1.03214 397.093 -4.9086 397.16 11.4331 396.94) 
(-1.73 396.97 -4.46786 397.068 9.7392 396.761) 
(-2.05 396.867 -4.32129 396.904 10.3712 396.714) 
(-1.99 396.808 -4.25179 396.872 10.4984 396.571) 
(-1.92921 396.797 -4.25 396.884 10.5 396.523)
(-1.51 396.834 -4.25051 396.896 10.5061 396.406)
))


(defun C:ksituation_de_profils ()
	(defun aucarre (asdf) (* asdf asdf))
	(if (= CommandeEnCours nil)
		(setq 
			listeatrier ktransfert 
			)
		)

;; valeurs pour la création des objets dans le dessin
	(setq 
		tableauDecalageKilometrage 2.00
		tableauDecalageNumero 5.25
		tableauDecalageCoordonneeX 8.95
		tableauDecalageCoordonneeY 13.65
		tableauDecalageCoordonneeZ 18.35
		tableauDecalageRemarque 20.95
		)
	(setq 
		tableauLigneVerticale1Decalage 3.90
		tableauLigneVerticale2Decalage 6.60
		tableauLigneVerticale3Decalage 11.30
		tableauLigneVerticale4Decalage 16.00
		tableauLigneVerticale5Decalage 20.70
		tableauLigneVerticaleDroiteDecalage 28.20
		)
	(setq 
		tableauHauteurLigne 0.9
		tableauDecalagetexteLigne 0.45
		)
	(setq
		tableauHauteurTexte 0.6
		tableauPolice "ARIAL"
		tableauStyleTexte "ARIAL"
		)
	(setq 
		situDecalageTexte 1
		situAzimutTexte pi
		situHauteurTexte 0.5
		situRotationTexte (/ pi 2.0)
		situPolice "ARIAL"
		situStyleTexte "ARIAL"
		)
	(setq 
		situLigneHorizontalMineurCalque "tableaux coordonnées points - 010"
		situLigneHorizontalMajeurCalque "tableaux coordonnées points - 050"
		situLigneVerticalMineurCalque "tableaux coordonnées points - 013"
		situLigneVerticalMajeurCalque "tableaux coordonnées points - 050"
		)
		
	(setq
		a_fp 0.44810
		l_fp 0.41533
		a_fm 0.88564
		l_fm 0.23239
		a_ff 2.69349
		l_ff 0.41533
		a_t 1.57000
		l_t 0.31263
		FacteurFlèche 2.0
		hauteurtexte 0.25
		)
	(setq style (getvar "textstyle"))
	
;; valeurs de calcul pour la fonction et entrées utilisateur

	(if (= CommandeEnCours nil)
		(setq pointInsertionTableau (getpoint "\nChoisissez un point qui sera le coin haut gauche du tableau de coordonnée:"))
		)
	(if (= CommandeEnCours nil)
		(setq numeroPoint (getreal "\nDéfinissez le numéro du premier point: "))
		)
	(if (= CommandeEnCours nil)
		(setq tableauKilometrageDepart (getreal "\nDéfinissez le kilomètrage de premier profil (en mètre): "))
		)
	(if (= CommandeEnCours nil)
		(setq tableauKilometrageProfil tableauKilometrageDepart)
		)
	(if (= CommandeEnCours nil)
		(setq tableauDistanceEntreProfil (getreal "\nDéfinissez la distance entre les profils (en mètre): "))
		)
	(if (= CommandeEnCours nil)
		(setq CoinHautGaucheligneTexte pointInsertionTableau)
		)
	(if (= CommandeEnCours nil)
		(setq 
			CommandeEnCours "oui"
			InterProfilEnCours nil
			)
		)
	
;;début de la boucle de création
	(while (> (length listeatrier) 0) 
;; creation du profil de base
		(if (= InterProfilEnCours nil)
			(progn
		;; recuperation et calcul des données pour le profil
				(progn
			;; stockage des points pour déterminer l'angle du profil en situation
					(setq pointsituaxeU (getpoint "\nCliquer sur le point d'intersection entre la ligne de profil et l'axe: "))
					(setq pointsitdroiteU (getpoint pointsituaxeU "\nSelectionnez un point sur le profil à droite de l'axe: "))
					
			;; calculs pour déterminer l'angle du profil en situation dans le SCU utilisateur
					(setq dxU (- (car pointsitdroiteU) (car pointsituaxeU)))
					(setq dyU (- (cadr pointsitdroiteU) (cadr pointsituaxeU)))
					(setq angleprofilU (atan dyU dxU))
					
			;; transformation des points de coordonnées utilisateurs en coordonnées générales et calcul des angles finaux
					(setq 
						pointsituaxeW (trans pointsituaxeU 1 0)
						pointsitdroiteW (trans pointsitdroiteU 1 0)
						)
					(setq dxW (- (car pointsitdroiteW) (car pointsituaxeW)))
					(setq dyW (- (cadr pointsitdroiteW) (cadr pointsituaxeW)))
					(setq difference_angle (- (atan dyU dxU) (atan dyW dxW)))
					(setq angleprofilW (- angleprofilU difference_angle))
					
			;; récuperation des information du profil
					(setq profilatrier (car listeatrier))
					(setq 
						distanceAxeToit (nth 0 Profilatrier)
						altitudeGauche (nth 1 Profilatrier)
						distanceToitGauche (nth 2 Profilatrier)
						altitudeToit (nth 3 Profilatrier)
						distanceToitDroite (nth 4 Profilatrier)
						altitudeDroite (nth 5 Profilatrier)
						)
						
			;; creation d'une variable de nombres de point créer dans le profil
					(setq nombreDePointDansProfil 0)
						
			;; socker les variables systeme et les mettre à 0
					(setq 
						os (getvar "osmode")
						dim (getvar "dimzin")
						)
					(setvar "osmode" 0)
					(setvar "dimzin" 0)
				)
				
			;; création du point gauche en situation et stockage de son id
				(progn
					(setq SituInsertionObjectGauche (polar pointsituaxeW angleprofilW (+ distanceAxeToit distanceToitGauche)))
					(setq SituInsertionObjectGauche (list (car SituInsertionObjectGauche) (cadr SituInsertionObjectGauche) altitudeGauche))
					(setq idObjectGauche (entmakex (list 
						(cons 0 "POINT")
						(cons 10 SituInsertionObjectGauche)
						)))
					
			;; création des textes de coordonnées du point gauche dans le tableau
					(setq TableauTextePointGaucheCoordonneeX (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectGauche))) ">%).Coordinates \\f \"%lu2%pt1%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 TableauTextePointGaucheCoordonneeX)
							(cons 50 difference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeX) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
					(setq TableauTextePointGaucheCoordonneeY (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectGauche))) ">%).Coordinates \\f \"%lu2%pt2%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 TableauTextePointGaucheCoordonneeY)
							(cons 50 difference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeY) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
					(setq TableauTextePointGaucheCoordonneeZ (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectGauche))) ">%).Coordinates \\f \"%lu2%pt4%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 TableauTextePointGaucheCoordonneeZ)
							(cons 50 difference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeZ) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
						
			;; création du texte de numéro de point gauche dans le tableau et stockage de son ID
					(setq TableauTextePointGaucheNumero (rtos numeroPoint 2 0))
					(setq idnumerogauche (entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 TableauTextePointGaucheNumero)
							(cons 50 difference_angle)
							(cons 7 tableauPolice)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageNumero) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						))
			;; création du texte de numéro de point en situation
					(setq situTextePointGaucheNumero (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idnumeroGauche))) ">%).TextString>%"))
					(setq situInsertionTexteGauche (polar SituInsertionObjectGauche (+ angleprofilW situAzimutTexte) situDecalageTexte))
					(setq situInsertionTexteGauche (list (car situInsertionTexteGauche) (cadr situInsertionTexteGauche) 0.0))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 situHauteurTexte)
							(cons 1 situTextePointGaucheNumero)
							(cons 50 (+ angleprofilU situRotationTexte))
							(cons 7 situStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 situInsertionTexteGauche)
							)
						)
						
			;; création du texte de remarque du point gauche
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 "Bordure Ouest")
							(cons 50 difference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 0)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageRemarque) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
						
			;; création de la ligne en dessous des textes
					(entmakex (list
						(cons 0 "LINE")
						(cons 8 situLigneHorizontalMineurCalque)
						(cons 10 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticale1Decalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
						(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticaleDroiteDecalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
						))
						
			;; incrémentation de 1 du numéro de point et du nombre de point dans le profil
					(setq 
						numeroPoint (+ numeroPoint 1)
						nombreDePointDansProfil (+ nombreDePointDansProfil 1)
						CoinHautGaucheligneTexte (list (car CoinHautGaucheligneTexte) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0)
						)
				)
				
			;; si la distance Axe-Toit est plus petit que Zero on crée le point toit avant le point Axe
				(if (< distanceAxeToit 0)
					(progn

		;; création du point toit en situation et stockage de son id
						(setq SituInsertionObjectToit (polar pointsituaxeW angleprofilW distanceAxeToit))
						(setq SituInsertionObjectToit (list (car SituInsertionObjectToit) (cadr SituInsertionObjectToit) altitudeToit))
						(setq idObjectToit (entmakex (list 
							(cons 0 "POINT")
							(cons 10 SituInsertionObjectToit)
							)))
					
		;; création des textes de coordonnées du point toit dans le tableau
						(setq TableauTextePointToitCoordonneeX (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectToit))) ">%).Coordinates \\f \"%lu2%pt1%pr2\">%"))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 TableauTextePointToitCoordonneeX)
								(cons 50 difference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeX) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
						(setq TableauTextePointToitCoordonneeY (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectToit))) ">%).Coordinates \\f \"%lu2%pt2%pr2\">%"))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 TableauTextePointToitCoordonneeY)
								(cons 50 difference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeY) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
						(setq TableauTextePointToitCoordonneeZ (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectToit))) ">%).Coordinates \\f \"%lu2%pt4%pr2\">%"))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 TableauTextePointToitCoordonneeZ)
								(cons 50 difference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeZ) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
				
		;; création du texte de numéro de point Toit dans le tableau et stockage de son ID
						(setq TableauTextePointToitNumero (rtos numeroPoint 2 0))
						(setq idnumeroToit (entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 TableauTextePointToitNumero)
								(cons 50 difference_angle)
								(cons 7 tableauPolice)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageNumero) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							))
		;; création du texte de numéro de point en situation
						(setq situTextePointToitNumero (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idnumeroToit))) ">%).TextString>%"))
						(setq situInsertionTexteToit (polar SituInsertionObjectToit (+ angleprofilW situAzimutTexte) situDecalageTexte))
						(setq situInsertionTexteToit (list (car situInsertionTexteToit) (cadr situInsertionTexteToit) 0.0))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 situHauteurTexte)
								(cons 1 situTextePointToitNumero)
								(cons 50 (+ angleprofilU situRotationTexte))
								(cons 7 situStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 situInsertionTexteToit)
								)
							)
							
		;; création du texte de remarque du point Toit
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 "Toit")
								(cons 50 difference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 0)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageRemarque) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
							
		;; création de la ligne en dessous des textes
						(entmakex (list
							(cons 0 "LINE")
							(cons 8 situLigneHorizontalMineurCalque)
							(cons 10 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticale1Decalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticaleDroiteDecalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
							))

		;; incrémentation de 1 du numéro de point et du nombre de point dans le profil
						(setq 
							numeroPoint (+ numeroPoint 1)
							nombreDePointDansProfil (+ nombreDePointDansProfil 1)
							CoinHautGaucheligneTexte (list (car CoinHautGaucheligneTexte) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0)
							)
						)
					)
			;; création du point Axe en situation et stockage de son id
				(progn
					(setq SituInsertionObjectAxe pointsituaxeW)
					(setq altitudeAxe 
						(if (> distanceAxeToit 0)
							(- altitudeToit (* distanceAxeToit (/ (- altitudeGauche altitudeToit) (* -1.0 distanceToitGauche))))
							(if (< distanceAxeToit 0)
								(- altitudeToit (* distanceAxeToit (/ (- altitudeDroite altitudeToit) distanceToitDroite)))
								altitudeToit)
							)
						)
					(setq SituInsertionObjectAxe (list (car SituInsertionObjectAxe) (cadr SituInsertionObjectAxe) altitudeAxe))
					(setq idObjectAxe (entmakex (list 
						(cons 0 "POINT")
						(cons 10 SituInsertionObjectAxe)
						)))
					
			;; création des textes de coordonnées du point Axe dans le tableau
					(setq TableauTextePointAxeCoordonneeX (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectAxe))) ">%).Coordinates \\f \"%lu2%pt1%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 TableauTextePointAxeCoordonneeX)
							(cons 50 difference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeX) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
					(setq TableauTextePointAxeCoordonneeY (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectAxe))) ">%).Coordinates \\f \"%lu2%pt2%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 TableauTextePointAxeCoordonneeY)
							(cons 50 difference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeY) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
					(setq TableauTextePointAxeCoordonneeZ (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectAxe))) ">%).Coordinates \\f \"%lu2%pt4%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 TableauTextePointAxeCoordonneeZ)
							(cons 50 difference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeZ) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
						
			;; création du texte de numéro de point Axe dans le tableau et stockage de son ID
					(setq TableauTextePointAxeNumero (rtos numeroPoint 2 0))
					(setq idnumeroAxe (entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 TableauTextePointAxeNumero)
							(cons 50 difference_angle)
							(cons 7 tableauPolice)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageNumero) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						))
			;; création du texte de numéro de point Axe en situation
					(setq situTextePointAxeNumero (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idnumeroAxe))) ">%).TextString>%"))
					(setq situInsertionTexteAxe (polar SituInsertionObjectAxe (+ angleprofilW situAzimutTexte (if (< distanceAxeToit 0) pi 0.0)) situDecalageTexte))
					(setq situInsertionTexteAxe (list (car situInsertionTexteAxe) (cadr situInsertionTexteAxe) 0.0))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 situHauteurTexte)
							(cons 1 situTextePointAxeNumero)
							(cons 50 (+ angleprofilU situRotationTexte))
							(cons 7 situStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 situInsertionTexteAxe)
							)
						)
						
			;; création du texte de remarque du point Axe
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 "Axe")
							(cons 50 difference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 0)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageRemarque) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
						
			;; création de la ligne en dessous des textes
					(entmakex (list
						(cons 0 "LINE")
						(cons 8 situLigneHorizontalMineurCalque)
						(cons 10 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticale1Decalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
						(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticaleDroiteDecalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
						))
						
			;; incrémentation de 1 du numéro de point et du nombre de point dans le profil
					(setq 
						numeroPoint (+ numeroPoint 1)
						nombreDePointDansProfil (+ nombreDePointDansProfil 1)
						CoinHautGaucheligneTexte (list (car CoinHautGaucheligneTexte) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0)
						)
					)
				
			;; si la distance Axe-Toit est plus grande que Zero on crée le point toit après le point Axe
				(if (> distanceAxeToit 0)
					(progn

		;; création du point toit en situation et stockage de son id
						(setq SituInsertionObjectToit (polar pointsituaxeW angleprofilW distanceAxeToit))
						(setq SituInsertionObjectToit (list (car SituInsertionObjectToit) (cadr SituInsertionObjectToit) altitudeToit))
						(setq idObjectToit (entmakex (list 
							(cons 0 "POINT")
							(cons 10 SituInsertionObjectToit)
							)))
					
		;; création des textes de coordonnées du point toit dans le tableau
						(setq TableauTextePointToitCoordonneeX (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectToit))) ">%).Coordinates \\f \"%lu2%pt1%pr2\">%"))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 TableauTextePointToitCoordonneeX)
								(cons 50 difference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeX) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
						(setq TableauTextePointToitCoordonneeY (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectToit))) ">%).Coordinates \\f \"%lu2%pt2%pr2\">%"))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 TableauTextePointToitCoordonneeY)
								(cons 50 difference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeY) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
						(setq TableauTextePointToitCoordonneeZ (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectToit))) ">%).Coordinates \\f \"%lu2%pt4%pr2\">%"))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 TableauTextePointToitCoordonneeZ)
								(cons 50 difference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeZ) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
				
		;; création du texte de numéro de point Toit dans le tableau et stockage de son ID
						(setq TableauTextePointToitNumero (rtos numeroPoint 2 0))
						(setq idnumeroToit (entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 TableauTextePointToitNumero)
								(cons 50 difference_angle)
								(cons 7 tableauPolice)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageNumero) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							))
		;; création du texte de numéro de point Toit en situation
						(setq situTextePointToitNumero (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idnumeroToit))) ">%).TextString>%"))
						(setq situInsertionTexteToit (polar SituInsertionObjectToit (+ angleprofilW situAzimutTexte pi) situDecalageTexte))
						(setq situInsertionTexteToit (list (car situInsertionTexteToit) (cadr situInsertionTexteToit) 0.0))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 situHauteurTexte)
								(cons 1 situTextePointToitNumero)
								(cons 50 (+ angleprofilU situRotationTexte))
								(cons 7 situStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 situInsertionTexteToit)
								)
							)
							
		;; création du texte de remarque du point Toit
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 "Toit")
								(cons 50 difference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 0)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageRemarque) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
							
		;; création de la ligne en dessous des textes
						(entmakex (list
							(cons 0 "LINE")
							(cons 8 situLigneHorizontalMineurCalque)
							(cons 10 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticale1Decalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticaleDroiteDecalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
							))
							
		;; incrémentation de 1 du numéro de point et du nombre de point dans le profil
						(setq 
							numeroPoint (+ numeroPoint 1)
							nombreDePointDansProfil (+ nombreDePointDansProfil 1)
							CoinHautGaucheligneTexte (list (car CoinHautGaucheligneTexte) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0)
							)
						)
					)
			;; création du point droite en situation et stockage de son id
				(progn 
					(setq SituInsertionObjectDroite (polar pointsituaxeW angleprofilW (+ distanceAxeToit distanceToitDroite)))
					(setq SituInsertionObjectDroite (list (car SituInsertionObjectDroite) (cadr SituInsertionObjectDroite) altitudeDroite))
					(setq idObjectDroite (entmakex (list 
						(cons 0 "POINT")
						(cons 10 SituInsertionObjectDroite)
						)))
					
			;; création des textes de coordonnées du point Droite dans le tableau
					(setq TableauTextePointDroiteCoordonneeX (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectDroite))) ">%).Coordinates \\f \"%lu2%pt1%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 TableauTextePointDroiteCoordonneeX)
							(cons 50 difference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeX) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
					(setq TableauTextePointDroiteCoordonneeY (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectDroite))) ">%).Coordinates \\f \"%lu2%pt2%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 TableauTextePointDroiteCoordonneeY)
							(cons 50 difference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeY) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
					(setq TableauTextePointDroiteCoordonneeZ (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectDroite))) ">%).Coordinates \\f \"%lu2%pt4%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 TableauTextePointDroiteCoordonneeZ)
							(cons 50 difference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeZ) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
						
			;; création du texte de numéro de point Droite dans le tableau et stockage de son ID
					(setq TableauTextePointDroiteNumero (rtos numeroPoint 2 0))
					(setq idnumeroDroite (entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 TableauTextePointDroiteNumero)
							(cons 50 difference_angle)
							(cons 7 tableauPolice)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageNumero) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						))
			;; création du texte de numéro de point droite en situation
					(setq situTextePointDroiteNumero (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idnumeroDroite))) ">%).TextString>%"))
					(setq situInsertionTexteDroite (polar SituInsertionObjectDroite (+ angleprofilW situAzimutTexte pi) situDecalageTexte))
					(setq situInsertionTexteDroite (list (car situInsertionTexteDroite) (cadr situInsertionTexteDroite) 0.0))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 situHauteurTexte)
							(cons 1 situTextePointDroiteNumero)
							(cons 50 (+ angleprofilU situRotationTexte))
							(cons 7 situStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 situInsertionTexteDroite)
							)
						)
						
			;; création du texte de remarque du point Droite
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 "Bordure Est")
							(cons 50 difference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 0)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageRemarque) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
						
			;; création de la ligne en dessous des textes
					(if (not (= (cadr listeatrier) nil))
						(entmakex (list
							(cons 0 "LINE")
							(cons 8 situLigneHorizontalMajeurCalque)
							(cons 10 (list (car CoinHautGaucheligneTexte) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticaleDroiteDecalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
							))
						)
						
			;; incrémentation de 1 du numéro de point et du nombre de point dans le profil
					(setq 
						numeroPoint (+ numeroPoint 1)
						nombreDePointDansProfil (+ nombreDePointDansProfil 1)
						CoinHautGaucheligneTexte (list (car CoinHautGaucheligneTexte) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0)
						)
					)
			;; création du texte de kilométrage du profil
				(setq TableauTexteKilometrage (rtos tableauKilometrageProfil 2 2))
				(entmakex ;; création du texte
					(list
						(cons 0 "TEXT")
						(cons 10 (list 0 0 0 ))
						(cons 40 tableauHauteurTexte)
						(cons 1 TableauTexteKilometrage)
						(cons 50 difference_angle)
						(cons 7 tableauStyleTexte)
						(cons 72 1)
						(cons 73 2)
						(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageKilometrage) (+ (cadr CoinHautGaucheligneTexte) (/ (* tableauHauteurLigne nombreDePointDansProfil) 2.0)) 0.0 ))
						)
					)

			;; création de la flèche de pente de gauche
				(progn
					(setq p1 (trans SituInsertionObjectGauche 0 1))
					(setq p2 (if (= distanceAxeToit 0.0) (trans SituInsertionObjectAxe 0 1) (trans SituInsertionObjectToit 0 1)))
					(setq p1_final SituInsertionObjectGauche)
					(setq p2_final (if (= distanceAxeToit 0.0) SituInsertionObjectAxe SituInsertionObjectToit))
					
					(if (< (caddr p1) (caddr p2))
						(and
							(setq p p1)
							(setq p1 p2)
							(setq p2 p)
							(setq p_final p1_final)
							(setq p1_final p2_final)
							(setq p2_final p_final)
							) ;; and
						) ;; if
				
				;; calcul des distances (sur x, sur y et sur z)
					(setq dx (- (car p2) (car p1)))
					(setq dy (- (cadr p2) (cadr p1)))
					(setq dz (- (caddr p2) (caddr p1)))
					
				;; variable pour savoir la direction de la flèche (si "+" = flèche vers la droite, si "-" flèche vers la gauche)
					(setq direction 
						(if (> (car p1) (car p2))
							"-"
							"+"
							)
						)
						
				;; determiner la pente entre les deux points
					(setq pente (abs (* (/ dz (sqrt (+ (* dx dx) (* dy dy)))) 100)))

				;; détermine l'angle du texte et de la flèche dans le SCU utilisateur
					(setq angle
						(if (> dx 0)
							(atan dy dx)
							(atan (* -1.0 dy) (* -1 dx))
							)
						)
						
				;; détermine le point de départ pour l'insertion du texte et de la flèche
					(setq pointmilieu
						(list
							(/ (+ (car p1) (car p2)) 2.00)
							(/ (+ (cadr p1) (cadr p2)) 2.00)
							0.00
							)
						)
						
				;; crée la chaine de texte à afficher comme pente
					(setq texte (strcat (rtos pente 2 1) "%"))
					
				;; transformation du point milieu de coordonnées utilisateurs à coordonnées générales
					(setq pointmilieu_final (trans pointmilieu 1 0))
					
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
								(polar pointmilieu_final (+ a_fp angle_final) (* FacteurFlèche l_fp))
								(polar pointmilieu_final (+ (- PI a_fp) angle_final) (* FacteurFlèche l_fp))
								)) ;; if cons
							(cons 40 0)
							(cons 41 (* FacteurFlèche 0.1))
							(cons 10 (if (= direction "+")
								(polar pointmilieu_final (+ a_fm angle_final) (* FacteurFlèche l_fm))
								(polar pointmilieu_final (+ (- PI a_fm) angle_final) (* FacteurFlèche l_fm))
								)) ;; if cons
							(cons 40 0)
							(cons 41 0)
							(cons 10 (if (= direction "+")
								(polar pointmilieu_final (+ a_ff angle_final) (* FacteurFlèche l_ff))
								(polar pointmilieu_final (+ (- PI a_ff) angle_final) (* FacteurFlèche l_ff))
								)) ;; if cons
							) ;; entmakex
						)
					(entmakex 
						(list 
							(cons 0 "MTEXT")
							;;(cons 8 calque)
							(cons 100 "AcDbEntity")
							(cons 100 "AcDbMText")
							(cons 10 (polar pointmilieu_final (+ a_t angle_final) (* FacteurFlèche l_t)))	;;point d'insertion
							(cons 40 (* FacteurFlèche hauteurtexte))
							(cons 41 2.0)
							(cons 71 8)
							(cons 1 texte)
							(cons 7 style)
							(cons 50 angle)
							)
						)
					)
					
			;; création de la flèche de pente de droite
				(progn
					(setq p1 (trans SituInsertionObjectDroite 0 1))
					(setq p2 (if (= distanceAxeToit 0.0) (trans SituInsertionObjectAxe 0 1) (trans SituInsertionObjectToit 0 1)))
					(setq p1_final SituInsertionObjectDroite)
					(setq p2_final (if (= distanceAxeToit 0.0) SituInsertionObjectAxe SituInsertionObjectToit))
					
					(if (< (caddr p1) (caddr p2))
						(and
							(setq p p1)
							(setq p1 p2)
							(setq p2 p)
							(setq p_final p1_final)
							(setq p1_final p2_final)
							(setq p2_final p_final)
							) ;; and
						) ;; if
				
				;; calcul des distances (sur x, sur y et sur z)
					(setq dx (- (car p2) (car p1)))
					(setq dy (- (cadr p2) (cadr p1)))
					(setq dz (- (caddr p2) (caddr p1)))
					
				;; variable pour savoir la direction de la flèche (si "+" = flèche vers la droite, si "-" flèche vers la gauche)
					(setq direction 
						(if (> (car p1) (car p2))
							"-"
							"+"
							)
						)
						
				;; determiner la pente entre les deux points
					(setq pente (abs (* (/ dz (sqrt (+ (* dx dx) (* dy dy)))) 100)))

				;; détermine l'angle du texte et de la flèche dans le SCU utilisateur
					(setq angle
						(if (> dx 0)
							(atan dy dx)
							(atan (* -1.0 dy) (* -1 dx))
							)
						)
						
				;; détermine le point de départ pour l'insertion du texte et de la flèche
					(setq pointmilieu
						(list
							(/ (+ (car p1) (car p2)) 2.00)
							(/ (+ (cadr p1) (cadr p2)) 2.00)
							0.00
							)
						)
						
				;; crée la chaine de texte à afficher comme pente
					(setq texte (strcat (rtos pente 2 1) "%"))
					
				;; transformation du point milieu de coordonnées utilisateurs à coordonnées générales
					(setq pointmilieu_final (trans pointmilieu 1 0))
					
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
								(polar pointmilieu_final (+ a_fp angle_final) (* FacteurFlèche l_fp))
								(polar pointmilieu_final (+ (- PI a_fp) angle_final) (* FacteurFlèche l_fp))
								)) ;; if cons
							(cons 40 0)
							(cons 41 (* FacteurFlèche 0.1))
							(cons 10 (if (= direction "+")
								(polar pointmilieu_final (+ a_fm angle_final) (* FacteurFlèche l_fm))
								(polar pointmilieu_final (+ (- PI a_fm) angle_final) (* FacteurFlèche l_fm))
								)) ;; if cons
							(cons 40 0)
							(cons 41 0)
							(cons 10 (if (= direction "+")
								(polar pointmilieu_final (+ a_ff angle_final) (* FacteurFlèche l_ff))
								(polar pointmilieu_final (+ (- PI a_ff) angle_final) (* FacteurFlèche l_ff))
								)) ;; if cons
							) ;; entmakex
						)
					(entmakex 
						(list 
							(cons 0 "MTEXT")
							;;(cons 8 calque)
							(cons 100 "AcDbEntity")
							(cons 100 "AcDbMText")
							(cons 10 (polar pointmilieu_final (+ a_t angle_final) (* FacteurFlèche l_t)))	;;point d'insertion
							(cons 40 (* FacteurFlèche hauteurtexte))
							(cons 41 2.0)
							(cons 71 8)
							(cons 1 texte)
							(cons 7 style)
							(cons 50 angle)
							)
						)
					)
			;; variable de fin de profil principal
				(setq InterProfilEnCours "oui")
				(setvar "osmode" os)
				(setvar "dimzin" dim)
				)
			)
;; profil intermédiaire
		(setq ProchProfilatrier (cadr listeatrier))
		(if (not (= ProchProfilatrier nil))
			(progn
			
	;; recuperation et calcul des données pour le profil
				(progn
					(setq 
						ProchDistanceAxeToit (nth 0 ProchProfilatrier)
						ProchAltitudeGauche (nth 1 ProchProfilatrier)
						ProchDistanceToitGauche (nth 2 ProchProfilatrier)
						ProchAltitudeToit (nth 3 ProchProfilatrier)
						ProchDistanceToitDroite (nth 4 ProchProfilatrier)
						ProchAltitudeDroite (nth 5 ProchProfilatrier)
						)
		;; recuperation	des points en situation		
					(setq InterSituInsertionObjectGaucheU (getpoint "\nCliquer sur le point de gauche du profil intermediaire:"))
					(setq InterSituInsertionObjectGaucheW (trans InterSituInsertionObjectGaucheU 1 0))
					(setq InterSituInsertionObjectToitU (getpoint "\nCliquer sur le point de Toit du profil intermediaire:"))
					(setq InterSituInsertionObjectToitW (trans InterSituInsertionObjectToitU 1 0))
					(setq InterSituInsertionObjectAxeU (getpoint "\nCliquer sur le point à l'axe du profil intermediaire:"))
					(setq InterSituInsertionObjectAxeW (trans InterSituInsertionObjectAxeU 1 0))
					(setq InterSituInsertionObjectDroiteU (getpoint "\nCliquer sur le point de droite du profil intermediaire:"))
					(setq InterSituInsertionObjectDroiteW (trans InterSituInsertionObjectDroiteU 1 0))
					
		;; creation d'une variable de nombres de point créer dans le profil
					(setq nombreDePointDansProfil 0)
						
		;; socker les variables systeme et les mettre à 0
					(setq 
						os (getvar "osmode")
						dim (getvar "dimzin")
						)
					(setvar "osmode" 0)
					(setvar "dimzin" 0)
					
		;; calculs pour déterminer l'angle du profil en situation dans le SCU utilisateur
					(setq InetrDxU (- (car InterSituInsertionObjectDroiteU) (car InterSituInsertionObjectGaucheU)))
					(setq InterDyU (- (cadr InterSituInsertionObjectDroiteU) (cadr InterSituInsertionObjectGaucheU)))
					(setq InterAngleprofilU (atan InterDyU InetrDxU))
					
		;; transformation des points de coordonnées utilisateurs en coordonnées générales et calcul des angles finaux
					(setq InterDxW (- (car InterSituInsertionObjectDroiteW) (car InterSituInsertionObjectGaucheW)))
					(setq InterDyW (- (cadr InterSituInsertionObjectDroiteW) (cadr InterSituInsertionObjectGaucheW)))
					(setq InterDifference_angle (- (atan InterDyU InetrDxU) (atan InterDyW InterDxW)))
					(setq InterAngleprofilW (- InterAngleprofilU InterDifference_angle))
					
		;; calcul des distances et altitudes des points du profil intermediare
					(setq InterDistanceAxeToit (sqrt (+ (aucarre (- (car InterSituInsertionObjectToitW) (car InterSituInsertionObjectAxeW))) (aucarre (- (cadr InterSituInsertionObjectToitW) (cadr InterSituInsertionObjectAxeW))))))
					(if (< (* (- (cadr InterSituInsertionObjectToitW) (cadr InterSituInsertionObjectAxeW)) InterDyW) 0.0)
						(setq InterDistanceAxeToit (* -1.0 InterDistanceAxeToit))
						)
					(setq InterAltitudeGauche (/ (+ altitudeGauche ProchAltitudeGauche) 2.0))
					(setq InterDistanceToitGauche (sqrt (+ (aucarre (- (car InterSituInsertionObjectGaucheW) (car InterSituInsertionObjectToitW))) (aucarre (- (cadr InterSituInsertionObjectGaucheW) (cadr InterSituInsertionObjectToitW))))))
					(if (< (* (- (cadr InterSituInsertionObjectGaucheW) (cadr InterSituInsertionObjectToitW)) InterDyW) 0.0)
						(setq InterDistanceToitGauche (* -1.0 InterDistanceToitGauche))
						)
					(setq InterAltitudeToit (/ (+ altitudeToit ProchAltitudeToit) 2.0))
					(setq InterDistanceToitDroite (sqrt (+ (aucarre (- (car InterSituInsertionObjectDroiteW) (car InterSituInsertionObjectToitW))) (aucarre (- (cadr InterSituInsertionObjectDroiteW) (cadr InterSituInsertionObjectToitW))))))
					(if (< (* (- (cadr InterSituInsertionObjectDroiteW) (cadr InterSituInsertionObjectToitW)) InterDyW) 0.0)
						(setq InterDistanceToitDroite (* -1.0 InterDistanceToitDroite))
						)
					(setq InterAltitudeDroite (/ (+ altitudeDroite ProchAltitudeDroite) 2.0))
					)
					
	;; création du point gauche en situation et stockage de son id
				(progn
					(setq InterSituInsertionObjectGaucheW (list (car InterSituInsertionObjectGaucheW) (cadr InterSituInsertionObjectGaucheW) InterAltitudeGauche))
					(setq InteridObjectGauche (entmakex (list 
						(cons 0 "POINT")
						(cons 10 InterSituInsertionObjectGaucheW)
						)))
					
			;; création des textes de coordonnées du point gauche dans le tableau
					(setq InterTableauTextePointGaucheCoordonneeX (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridObjectGauche))) ">%).Coordinates \\f \"%lu2%pt1%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 InterTableauTextePointGaucheCoordonneeX)
							(cons 50 InterDifference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeX) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
					(setq InterTableauTextePointGaucheCoordonneeY (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridObjectGauche))) ">%).Coordinates \\f \"%lu2%pt2%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 InterTableauTextePointGaucheCoordonneeY)
							(cons 50 InterDifference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeY) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
					(setq InterTableauTextePointGaucheCoordonneeZ (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridObjectGauche))) ">%).Coordinates \\f \"%lu2%pt4%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 InterTableauTextePointGaucheCoordonneeZ)
							(cons 50 InterDifference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeZ) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
						
			;; création du texte de numéro de point gauche dans le tableau et stockage de son ID
					(setq InterTableauTextePointGaucheNumero (rtos numeroPoint 2 0))
					(setq Interidnumerogauche (entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 InterTableauTextePointGaucheNumero)
							(cons 50 InterDifference_angle)
							(cons 7 tableauPolice)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageNumero) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						))
			;; création du texte de numéro de point en situation
					(setq InterSituTextePointGaucheNumero (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridnumeroGauche))) ">%).TextString>%"))
					(setq InterSituInsertionTexteGauche (polar InterSituInsertionObjectGaucheW (+ InterAngleprofilW situAzimutTexte) situDecalageTexte))
					(setq InterSituInsertionTexteGauche (list (car InterSituInsertionTexteGauche) (cadr InterSituInsertionTexteGauche) 0.0))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 situHauteurTexte)
							(cons 1 InterSituTextePointGaucheNumero)
							(cons 50 (+ InterAngleprofilU situRotationTexte))
							(cons 7 situStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 InterSituInsertionTexteGauche)
							)
						)
						
			;; création du texte de remarque du point gauche
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 "Bordure Ouest")
							(cons 50 InterDifference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 0)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageRemarque) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
						
			;; création de la ligne en dessous des textes
					(entmakex (list
						(cons 0 "LINE")
						(cons 8 situLigneHorizontalMineurCalque)
						(cons 10 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticale1Decalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
						(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticaleDroiteDecalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
						))
						
			;; incrémentation de 1 du numéro de point et du nombre de point dans le profil
					(setq 
						numeroPoint (+ numeroPoint 1)
						nombreDePointDansProfil (+ nombreDePointDansProfil 1)
						CoinHautGaucheligneTexte (list (car CoinHautGaucheligneTexte) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0)
						)
					)
	
	;; si la distance Axe-Toit est plus petit que Zero on crée le point toit avant le point Axe
				(if (< InterDistanceAxeToit 0)
					(progn

		;; création du point toit en situation et stockage de son id
						(setq InterSituInsertionObjectToitW (list (car InterSituInsertionObjectToitW) (cadr InterSituInsertionObjectToitW) InterAltitudeToit))
						(setq InteridObjectToit (entmakex (list 
							(cons 0 "POINT")
							(cons 10 InterSituInsertionObjectToitW)
							)))
					
		;; création des textes de coordonnées du point toit dans le tableau
						(setq InterTableauTextePointToitCoordonneeX (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridObjectToit))) ">%).Coordinates \\f \"%lu2%pt1%pr2\">%"))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 InterTableauTextePointToitCoordonneeX)
								(cons 50 InterDifference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeX) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
						(setq InterTableauTextePointToitCoordonneeY (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridObjectToit))) ">%).Coordinates \\f \"%lu2%pt2%pr2\">%"))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 InterTableauTextePointToitCoordonneeY)
								(cons 50 InterDifference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeY) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
						(setq InterTableauTextePointToitCoordonneeZ (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridObjectToit))) ">%).Coordinates \\f \"%lu2%pt4%pr2\">%"))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 InterTableauTextePointToitCoordonneeZ)
								(cons 50 InterDifference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeZ) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
				
		;; création du texte de numéro de point Toit dans le tableau et stockage de son ID
						(setq InterTableauTextePointToitNumero (rtos numeroPoint 2 0))
						(setq InteridnumeroToit (entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 InterTableauTextePointToitNumero)
								(cons 50 InterDifference_angle)
								(cons 7 tableauPolice)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageNumero) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							))
		;; création du texte de numéro de point en situation
						(setq InterSituTextePointToitNumero (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridnumeroToit))) ">%).TextString>%"))
						(setq InterSsituInsertionTexteToit (polar InterSituInsertionObjectToitW (+ InterAngleprofilW situAzimutTexte) situDecalageTexte))
						(setq InterSsituInsertionTexteToit (list (car InterSsituInsertionTexteToit) (cadr InterSsituInsertionTexteToit) 0.0))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 situHauteurTexte)
								(cons 1 InterSituTextePointToitNumero)
								(cons 50 (+ InterAngleprofilU situRotationTexte))
								(cons 7 situStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 InterSsituInsertionTexteToit)
								)
							)
							
		;; création du texte de remarque du point Toit
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 "Toit")
								(cons 50 InterDifference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 0)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageRemarque) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
							
		;; création de la ligne en dessous des textes
						(entmakex (list
							(cons 0 "LINE")
							(cons 8 situLigneHorizontalMineurCalque)
							(cons 10 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticale1Decalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticaleDroiteDecalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
							))

		;; incrémentation de 1 du numéro de point et du nombre de point dans le profil
						(setq 
							numeroPoint (+ numeroPoint 1)
							nombreDePointDansProfil (+ nombreDePointDansProfil 1)
							CoinHautGaucheligneTexte (list (car CoinHautGaucheligneTexte) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0)
							)
						)
					)
										
	;; création du point Axe en situation et stockage de son id
				(progn
					(setq InterAltitudeAxe 
						(if (> InterDistanceAxeToit 0)
							(- InterAltitudeToit (* InterDistanceAxeToit (/ (- InterAltitudeGauche InterAltitudeToit) (* -1.0 InterDistanceToitGauche))))
							(if (< InterDistanceAxeToit 0)
								(- InterAltitudeToit (* InterDistanceAxeToit (/ (- InterAltitudeDroite InterAltitudeToit) InterDistanceToitDroite)))
								InterAltitudeToit)
							)
						)
					(setq InterSituInsertionObjectAxeW (list (car InterSituInsertionObjectAxeW) (cadr InterSituInsertionObjectAxeW) InterAltitudeAxe))
					(setq InteridObjectAxe (entmakex (list 
						(cons 0 "POINT")
						(cons 10 InterSituInsertionObjectAxeW)
						)))
					
			;; création des textes de coordonnées du point Axe dans le tableau
					(setq InterTableauTextePointAxeCoordonneeX (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridObjectAxe))) ">%).Coordinates \\f \"%lu2%pt1%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 InterTableauTextePointAxeCoordonneeX)
							(cons 50 InterDifference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeX) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
					(setq InterTableauTextePointAxeCoordonneeY (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridObjectAxe))) ">%).Coordinates \\f \"%lu2%pt2%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 InterTableauTextePointAxeCoordonneeY)
							(cons 50 InterDifference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeY) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
					(setq InterTableauTextePointAxeCoordonneeZ (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridObjectAxe))) ">%).Coordinates \\f \"%lu2%pt4%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 InterTableauTextePointAxeCoordonneeZ)
							(cons 50 InterDifference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeZ) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
						
			;; création du texte de numéro de point Axe dans le tableau et stockage de son ID
					(setq InterTableauTextePointAxeNumero (rtos numeroPoint 2 0))
					(setq InteridnumeroAxe (entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 InterTableauTextePointAxeNumero)
							(cons 50 InterDifference_angle)
							(cons 7 tableauPolice)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageNumero) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						))
			;; création du texte de numéro de point Axe en situation
					(setq InterSituTextePointAxeNumero (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridnumeroAxe))) ">%).TextString>%"))
					(setq InterSituInsertionTexteAxe (polar InterSituInsertionObjectAxeW (+ InterAngleprofilW situAzimutTexte (if (< InterDistanceAxeToit 0) pi 0.0)) situDecalageTexte))
					(setq InterSituInsertionTexteAxe (list (car InterSituInsertionTexteAxe) (cadr InterSituInsertionTexteAxe) 0.0))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 situHauteurTexte)
							(cons 1 InterSituTextePointAxeNumero)
							(cons 50 (+ InterAngleprofilU situRotationTexte))
							(cons 7 situStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 InterSituInsertionTexteAxe)
							)
						)
						
			;; création du texte de remarque du point Axe
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 "Axe")
							(cons 50 InterDifference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 0)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageRemarque) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
						
			;; création de la ligne en dessous des textes
					(entmakex (list
						(cons 0 "LINE")
						(cons 8 situLigneHorizontalMineurCalque)
						(cons 10 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticale1Decalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
						(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticaleDroiteDecalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
						))
						
			;; incrémentation de 1 du numéro de point et du nombre de point dans le profil
					(setq 
						numeroPoint (+ numeroPoint 1)
						nombreDePointDansProfil (+ nombreDePointDansProfil 1)
						CoinHautGaucheligneTexte (list (car CoinHautGaucheligneTexte) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0)
						)
					)
				
	;; si la distance Axe-Toit est plus grande que Zero on crée le point toit après le point Axe
				(if (> distanceAxeToit 0)
					(progn

		;; création du point toit en situation et stockage de son id
						(setq InterSituInsertionObjectToitW (list (car InterSituInsertionObjectToitW) (cadr InterSituInsertionObjectToitW) InterAltitudeToit))
						(setq InteridObjectToit (entmakex (list 
							(cons 0 "POINT")
							(cons 10 InterSituInsertionObjectToitW)
							)))
					
		;; création des textes de coordonnées du point toit dans le tableau
						(setq InterTableauTextePointToitCoordonneeX (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridObjectToit))) ">%).Coordinates \\f \"%lu2%pt1%pr2\">%"))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 InterTableauTextePointToitCoordonneeX)
								(cons 50 InterDifference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeX) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
						(setq InterTableauTextePointToitCoordonneeY (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridObjectToit))) ">%).Coordinates \\f \"%lu2%pt2%pr2\">%"))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 InterTableauTextePointToitCoordonneeY)
								(cons 50 InterDifference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeY) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
						(setq InterTableauTextePointToitCoordonneeZ (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridObjectToit))) ">%).Coordinates \\f \"%lu2%pt4%pr2\">%"))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 InterTableauTextePointToitCoordonneeZ)
								(cons 50 InterDifference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeZ) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
				
		;; création du texte de numéro de point Toit dans le tableau et stockage de son ID
						(setq InterTableauTextePointToitNumero (rtos numeroPoint 2 0))
						(setq InteridnumeroToit (entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 InterTableauTextePointToitNumero)
								(cons 50 InterDifference_angle)
								(cons 7 tableauPolice)
								(cons 72 1)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageNumero) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							))
		;; création du texte de numéro de point en situation
						(setq InterSituTextePointToitNumero (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridnumeroToit))) ">%).TextString>%"))
						(setq InterSsituInsertionTexteToit (polar InterSituInsertionObjectToitW (+ InterAngleprofilW situAzimutTexte pi) situDecalageTexte))
						(setq InterSsituInsertionTexteToit (list (car InterSsituInsertionTexteToit) (cadr InterSsituInsertionTexteToit) 0.0))
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 situHauteurTexte)
								(cons 1 InterSituTextePointToitNumero)
								(cons 50 (+ InterAngleprofilU situRotationTexte))
								(cons 7 situStyleTexte)
								(cons 72 1)
								(cons 73 2)
								(cons 11 InterSsituInsertionTexteToit)
								)
							)
							
		;; création du texte de remarque du point Toit
						(entmakex ;; création du texte
							(list
								(cons 0 "TEXT")
								(cons 10 (list 0 0 0 ))
								(cons 40 tableauHauteurTexte)
								(cons 1 "Toit")
								(cons 50 InterDifference_angle)
								(cons 7 tableauStyleTexte)
								(cons 72 0)
								(cons 73 2)
								(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageRemarque) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
								)
							)
							
		;; création de la ligne en dessous des textes
						(entmakex (list
							(cons 0 "LINE")
							(cons 8 situLigneHorizontalMineurCalque)
							(cons 10 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticale1Decalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticaleDroiteDecalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
							))

		;; incrémentation de 1 du numéro de point et du nombre de point dans le profil
						(setq 
							numeroPoint (+ numeroPoint 1)
							nombreDePointDansProfil (+ nombreDePointDansProfil 1)
							CoinHautGaucheligneTexte (list (car CoinHautGaucheligneTexte) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0)
							)
						)
					)
	;; création du point droite en situation et stockage de son id
				(progn 
					(setq InterSituInsertionObjectDroiteW (list (car InterSituInsertionObjectDroiteW) (cadr InterSituInsertionObjectDroiteW) InterAltitudeDroite))
					(setq InteridObjectDroite (entmakex (list 
						(cons 0 "POINT")
						(cons 10 InterSituInsertionObjectDroiteW)
						)))
					
			;; création des textes de coordonnées du point Droite dans le tableau
					(setq InterTableauTextePointDroiteCoordonneeX (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridObjectDroite))) ">%).Coordinates \\f \"%lu2%pt1%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 InterTableauTextePointDroiteCoordonneeX)
							(cons 50 InterDifference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeX) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
					(setq InterTableauTextePointDroiteCoordonneeY (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridObjectDroite))) ">%).Coordinates \\f \"%lu2%pt2%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 InterTableauTextePointDroiteCoordonneeY)
							(cons 50 InterDifference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeY) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
					(setq InterTableauTextePointDroiteCoordonneeZ (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridObjectDroite))) ">%).Coordinates \\f \"%lu2%pt4%pr2\">%"))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 InterTableauTextePointDroiteCoordonneeZ)
							(cons 50 InterDifference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageCoordonneeZ) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
						
			;; création du texte de numéro de point Droite dans le tableau et stockage de son ID
					(setq InterTableauTextePointDroiteNumero (rtos numeroPoint 2 0))
					(setq InteridnumeroDroite (entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 InterTableauTextePointDroiteNumero)
							(cons 50 InterDifference_angle)
							(cons 7 tableauPolice)
							(cons 72 1)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageNumero) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						))
			;; création du texte de numéro de point droite en situation
					(setq InterSituTextePointDroiteNumero (strcat "%<\\AcObjProp " "Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object InteridnumeroDroite))) ">%).TextString>%"))
					(setq InterSituInsertionTexteDroite (polar InterSituInsertionObjectDroiteW (+ InterAngleprofilW situAzimutTexte pi) situDecalageTexte))
					(setq InterSituInsertionTexteDroite (list (car InterSituInsertionTexteDroite) (cadr InterSituInsertionTexteDroite) 0.0))
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 situHauteurTexte)
							(cons 1 InterSituTextePointDroiteNumero)
							(cons 50 (+ angleprofilU situRotationTexte))
							(cons 7 situStyleTexte)
							(cons 72 1)
							(cons 73 2)
							(cons 11 InterSituInsertionTexteDroite)
							)
						)
						
			;; création du texte de remarque du point Droite
					(entmakex ;; création du texte
						(list
							(cons 0 "TEXT")
							(cons 10 (list 0 0 0 ))
							(cons 40 tableauHauteurTexte)
							(cons 1 "Bordure Est")
							(cons 50 InterDifference_angle)
							(cons 7 tableauStyleTexte)
							(cons 72 0)
							(cons 73 2)
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageRemarque) (- (cadr CoinHautGaucheligneTexte) tableauDecalagetexteLigne) 0.0 ))
							)
						)
						
			;; création de la ligne en dessous des textes
					(if (not (= (cadr listeatrier) nil))
						(entmakex (list
							(cons 0 "LINE")
							(cons 8 situLigneHorizontalMajeurCalque)
							(cons 10 (list (car CoinHautGaucheligneTexte) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
							(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticaleDroiteDecalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
							))
						)
						
			;; incrémentation de 1 du numéro de point et du nombre de point dans le profil
					(setq 
						numeroPoint (+ numeroPoint 1)
						nombreDePointDansProfil (+ nombreDePointDansProfil 1)
						CoinHautGaucheligneTexte (list (car CoinHautGaucheligneTexte) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0)
						)
					)
	;; création du texte de kilométrage du profil
				(setq InterTableauTexteKilometrage (rtos (+ tableauKilometrageProfil (/ tableauDistanceEntreProfil 2.0)) 2 2))
				(entmakex ;; création du texte
					(list
						(cons 0 "TEXT")
						(cons 10 (list 0 0 0 ))
						(cons 40 tableauHauteurTexte)
						(cons 1 InterTableauTexteKilometrage)
						(cons 50 InterDifference_angle)
						(cons 7 tableauStyleTexte)
						(cons 72 1)
						(cons 73 2)
						(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauDecalageKilometrage) (+ (cadr CoinHautGaucheligneTexte) (/ (* tableauHauteurLigne nombreDePointDansProfil) 2.0)) 0.0 ))
						)
					)

	;; création de la flèche de pente de gauche
				(progn
					(setq p1 (trans InterSituInsertionObjectGaucheW 0 1))
					(setq p2 (if (= InterDistanceAxeToit 0.0) (trans InterSituInsertionObjectAxeW 0 1) (trans InterSituInsertionObjectToitW 0 1)))
					(setq p1_final InterSituInsertionObjectGaucheW)
					(setq p2_final (if (= InterDistanceAxeToit 0.0) InterSituInsertionObjectAxeW InterSituInsertionObjectToitW))
					
					(if (< (caddr p1) (caddr p2))
						(and
							(setq p p1)
							(setq p1 p2)
							(setq p2 p)
							(setq p_final p1_final)
							(setq p1_final p2_final)
							(setq p2_final p_final)
							) ;; and
						) ;; if
				
				;; calcul des distances (sur x, sur y et sur z)
					(setq dx (- (car p2) (car p1)))
					(setq dy (- (cadr p2) (cadr p1)))
					(setq dz (- (caddr p2) (caddr p1)))
					
				;; variable pour savoir la direction de la flèche (si "+" = flèche vers la droite, si "-" flèche vers la gauche)
					(setq direction 
						(if (> (car p1) (car p2))
							"-"
							"+"
							)
						)
						
				;; determiner la pente entre les deux points
					(setq pente (abs (* (/ dz (sqrt (+ (* dx dx) (* dy dy)))) 100)))

				;; détermine l'angle du texte et de la flèche dans le SCU utilisateur
					(setq angle
						(if (> dx 0)
							(atan dy dx)
							(atan (* -1.0 dy) (* -1 dx))
							)
						)
						
				;; détermine le point de départ pour l'insertion du texte et de la flèche
					(setq pointmilieu
						(list
							(/ (+ (car p1) (car p2)) 2.00)
							(/ (+ (cadr p1) (cadr p2)) 2.00)
							0.00
							)
						)
						
				;; crée la chaine de texte à afficher comme pente
					(setq texte (strcat (rtos pente 2 1) "%"))
					
				;; transformation du point milieu de coordonnées utilisateurs à coordonnées générales
					(setq pointmilieu_final (trans pointmilieu 1 0))
					
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
								(polar pointmilieu_final (+ a_fp angle_final) (* FacteurFlèche l_fp))
								(polar pointmilieu_final (+ (- PI a_fp) angle_final) (* FacteurFlèche l_fp))
								)) ;; if cons
							(cons 40 0)
							(cons 41 (* FacteurFlèche 0.1))
							(cons 10 (if (= direction "+")
								(polar pointmilieu_final (+ a_fm angle_final) (* FacteurFlèche l_fm))
								(polar pointmilieu_final (+ (- PI a_fm) angle_final) (* FacteurFlèche l_fm))
								)) ;; if cons
							(cons 40 0)
							(cons 41 0)
							(cons 10 (if (= direction "+")
								(polar pointmilieu_final (+ a_ff angle_final) (* FacteurFlèche l_ff))
								(polar pointmilieu_final (+ (- PI a_ff) angle_final) (* FacteurFlèche l_ff))
								)) ;; if cons
							) ;; entmakex
						)
					(entmakex 
						(list 
							(cons 0 "MTEXT")
							;;(cons 8 calque)
							(cons 100 "AcDbEntity")
							(cons 100 "AcDbMText")
							(cons 10 (polar pointmilieu_final (+ a_t angle_final) (* FacteurFlèche l_t)))	;;point d'insertion
							(cons 40 (* FacteurFlèche hauteurtexte))
							(cons 41 2.0)
							(cons 71 8)
							(cons 1 texte)
							(cons 7 style)
							(cons 50 angle)
							)
						)
					)
					
	;; création de la flèche de pente de droite
				(progn
					(setq p1 (trans InterSituInsertionObjectDroiteW 0 1))
					(setq p2 (if (= InterDistanceAxeToit 0.0) (trans InterSituInsertionObjectAxeW 0 1) (trans InterSituInsertionObjectToitW 0 1)))
					(setq p1_final InterSituInsertionObjectDroiteW)
					(setq p2_final (if (= InterDistanceAxeToit 0.0) InterSituInsertionObjectAxeW InterSituInsertionObjectToitW))
					
					(if (< (caddr p1) (caddr p2))
						(and
							(setq p p1)
							(setq p1 p2)
							(setq p2 p)
							(setq p_final p1_final)
							(setq p1_final p2_final)
							(setq p2_final p_final)
							) ;; and
						) ;; if
				
				;; calcul des distances (sur x, sur y et sur z)
					(setq dx (- (car p2) (car p1)))
					(setq dy (- (cadr p2) (cadr p1)))
					(setq dz (- (caddr p2) (caddr p1)))
					
				;; variable pour savoir la direction de la flèche (si "+" = flèche vers la droite, si "-" flèche vers la gauche)
					(setq direction 
						(if (> (car p1) (car p2))
							"-"
							"+"
							)
						)
						
				;; determiner la pente entre les deux points
					(setq pente (abs (* (/ dz (sqrt (+ (* dx dx) (* dy dy)))) 100)))

				;; détermine l'angle du texte et de la flèche dans le SCU utilisateur
					(setq angle
						(if (> dx 0)
							(atan dy dx)
							(atan (* -1.0 dy) (* -1 dx))
							)
						)
						
				;; détermine le point de départ pour l'insertion du texte et de la flèche
					(setq pointmilieu
						(list
							(/ (+ (car p1) (car p2)) 2.00)
							(/ (+ (cadr p1) (cadr p2)) 2.00)
							0.00
							)
						)
						
				;; crée la chaine de texte à afficher comme pente
					(setq texte (strcat (rtos pente 2 1) "%"))
					
				;; transformation du point milieu de coordonnées utilisateurs à coordonnées générales
					(setq pointmilieu_final (trans pointmilieu 1 0))
					
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
								(polar pointmilieu_final (+ a_fp angle_final) (* FacteurFlèche l_fp))
								(polar pointmilieu_final (+ (- PI a_fp) angle_final) (* FacteurFlèche l_fp))
								)) ;; if cons
							(cons 40 0)
							(cons 41 (* FacteurFlèche 0.1))
							(cons 10 (if (= direction "+")
								(polar pointmilieu_final (+ a_fm angle_final) (* FacteurFlèche l_fm))
								(polar pointmilieu_final (+ (- PI a_fm) angle_final) (* FacteurFlèche l_fm))
								)) ;; if cons
							(cons 40 0)
							(cons 41 0)
							(cons 10 (if (= direction "+")
								(polar pointmilieu_final (+ a_ff angle_final) (* FacteurFlèche l_ff))
								(polar pointmilieu_final (+ (- PI a_ff) angle_final) (* FacteurFlèche l_ff))
								)) ;; if cons
							) ;; entmakex
						)
					(entmakex 
						(list 
							(cons 0 "MTEXT")
							;;(cons 8 calque)
							(cons 100 "AcDbEntity")
							(cons 100 "AcDbMText")
							(cons 10 (polar pointmilieu_final (+ a_t angle_final) (* FacteurFlèche l_t)))	;;point d'insertion
							(cons 40 (* FacteurFlèche hauteurtexte))
							(cons 41 2.0)
							(cons 71 8)
							(cons 1 texte)
							(cons 7 style)
							(cons 50 angle)
							)
						)
					)
	;; variable de fin de profil principal
				(setq InterProfilEnCours nil)
				(setvar "osmode" os)
				(setvar "dimzin" dim)
				)							
			)
			
;; Fin des deux profils + incrémentation de la liste à trier
		(setq listeatrier (cdr listeatrier))
		(setq tableauKilometrageProfil (+ tableauKilometrageProfil tableauDistanceEntreProfil))

;; fin de boucle de creation	
		)
		
;; Création des lignes vérticales
		(entmakex (list
			(cons 0 "LINE")
			(cons 8 situLigneVerticalMineurCalque)
			(cons 10 (list (+ (car pointInsertionTableau) tableauLigneVerticale1Decalage) (cadr pointInsertionTableau) 0.0 ))
			(cons 11 (list (+ (car pointInsertionTableau) tableauLigneVerticale1Decalage) (cadr CoinHautGaucheligneTexte) 0.0 ))
			))
		(entmakex (list
			(cons 0 "LINE")
			(cons 8 situLigneVerticalMineurCalque)
			(cons 10 (list (+ (car pointInsertionTableau) tableauLigneVerticale2Decalage) (cadr pointInsertionTableau) 0.0 ))
			(cons 11 (list (+ (car pointInsertionTableau) tableauLigneVerticale2Decalage) (cadr CoinHautGaucheligneTexte) 0.0 ))
			))
		(entmakex (list
			(cons 0 "LINE")
			(cons 8 situLigneVerticalMineurCalque)
			(cons 10 (list (+ (car pointInsertionTableau) tableauLigneVerticale3Decalage) (cadr pointInsertionTableau) 0.0 ))
			(cons 11 (list (+ (car pointInsertionTableau) tableauLigneVerticale3Decalage) (cadr CoinHautGaucheligneTexte) 0.0 ))
			))
		(entmakex (list
			(cons 0 "LINE")
			(cons 8 situLigneVerticalMineurCalque)
			(cons 10 (list (+ (car pointInsertionTableau) tableauLigneVerticale4Decalage) (cadr pointInsertionTableau) 0.0 ))
			(cons 11 (list (+ (car pointInsertionTableau) tableauLigneVerticale4Decalage) (cadr CoinHautGaucheligneTexte) 0.0 ))
			))
		(entmakex (list
			(cons 0 "LINE")
			(cons 8 situLigneVerticalMineurCalque)
			(cons 10 (list (+ (car pointInsertionTableau) tableauLigneVerticale5Decalage) (cadr pointInsertionTableau) 0.0 ))
			(cons 11 (list (+ (car pointInsertionTableau) tableauLigneVerticale5Decalage) (cadr CoinHautGaucheligneTexte) 0.0 ))
			))
			
;; Création du cadre
		(setq liste 
			(list 
				(cons 10 pointInsertionTableau)
				(cons 10 (list (car pointInsertionTableau) (cadr CoinHautGaucheligneTexte) 0.0))
				(cons 10 (list (+ (car pointInsertionTableau) tableauLigneVerticaleDroiteDecalage) (cadr CoinHautGaucheligneTexte) 0.0))
				(cons 10 (list (+ (car pointInsertionTableau) tableauLigneVerticaleDroiteDecalage) (cadr pointInsertionTableau) 0.0))
				))
		
		(entmakex ;; création du contour
			(append 
				(list 
					(cons 0 "LWPOLYLINE")
					(cons 100 "AcDbEntity")
					(cons 8 situLigneVerticalMajeurCalque)
					(cons 100 "AcDbPolyline")
					(cons 90 (length liste))
					(cons 70 1)
					)
				liste
				)
			)

;; retablissement de la variables de fin de commande
	(setq CommandeEnCours nil)
	)




	
(defun C:kpl_a_situation ()
	(if (= facteur nil)
		(setq facteur (getreal "\nDéfinissez le facteur d'agrandissement de l'axe vértical (ex: si les echelles sont 1:500//50, alors le facteur est de 10): "))
		)
	(if (= origine nil)
		(setq origine (getpoint "\nDéfinissez le point qui est en même temps l'origine du kilométrage et l'horizon: "))
		)
	(if (= horizon nil)
		(setq horizon (getreal "\nDéfinissez l'altitude de l'horizon: "))
		)
		
	(if (= ktransfert nil)
		(progn
			(setq pointGauche (getpoint "\nCliquer sur le point gauche de la chaussée: "))
			(setq pointToit (getpoint "\nCliquer sur le point du sommet du Toit: "))
			(setq pointAxe (getpoint "\nChoisissez un point sur l'axe du profil: "))
			(setq pointDroite (getpoint "\nCliquer sur le point droite de la chaussée: "))
			
			(setq altgauche (+ horizon (/ (- (cadr pointGauche) (cadr origine)) facteur)))
			(setq alttoit (+ horizon (/ (- (cadr pointToit) (cadr origine)) facteur)))
			(setq altdroite (+ horizon (/ (- (cadr pointDroite) (cadr origine)) facteur)))
			
			(setq axetoit "PL")
			(setq toitgauche "PL")
			(setq toitdroite "PL")
			
			(setq profil (list axetoit altgauche toitgauche alttoit toitdroite altdroite))
			(setq ktransfert (list profil))
			)
		)
	(while (setq pointGauche (getpoint "\nCliquer sur le point gauche de la chaussée ou ENTER: "))
		(setq pointToit (getpoint "\nCliquer sur le point du sommet du Toit: "))
		(setq pointAxe (getpoint "\nChoisissez un point sur l'axe du profil: "))
		(setq pointDroite (getpoint "\nCliquer sur le point droite de la chaussée: "))
		
		(setq altgauche (+ horizon (/ (- (cadr pointGauche) (cadr origine)) facteur)))
		(setq alttoit (+ horizon (/ (- (cadr pointToit) (cadr origine)) facteur)))
		(setq altdroite (+ horizon (/ (- (cadr pointDroite) (cadr origine)) facteur)))
		
		(setq axetoit "PL")
		(setq toitgauche "PL")
		(setq toitdroite "PL")
		
		(setq profil (list axetoit altgauche toitgauche alttoit toitdroite altdroite))
		(setq ktransfert (append ktransfert (list profil)))
		)
	(length ktransfert)
	)
(("PL" 397.779 "PL" 397.646 "PL" 397.486) 
("PL" 398.366 "PL" 398.227 "PL" 398.112) 
("PL" 398.879 "PL" 398.779 "PL" 398.651) 
("PL" 399.354 "PL" 399.249 "PL" 399.111) 
("PL" 399.795 "PL" 399.665 "PL" 399.506) 
("PL" 400.167 "PL" 400.053 "PL" 399.894) 
("PL" 400.452 "PL" 400.351 "PL" 400.221) 
("PL" 400.7 "PL" 400.59 "PL" 400.474) 
("PL" 400.899 "PL" 400.812 "PL" 400.665) 
("PL" 401.028 "PL" 400.94 "PL" 400.806) 
("PL" 401.127 "PL" 401.027 "PL" 400.907) 
("PL" 401.206 "PL" 401.084 "PL" 400.97))

(defun C:ksituation_de_pl_modif_alt_points ()
	(defun aucarre (asdf) (* asdf asdf))
	(if (= CommandeEnCours nil)
		(setq 
			listeatrier ktransfert 
			)
		)
	(setq
		a_fp 0.44810
		l_fp 0.41533
		a_fm 0.88564
		l_fm 0.23239
		a_ff 2.69349
		l_ff 0.41533
		a_t 1.57000
		l_t 0.31263
		FacteurFlèche 2.0
		hauteurtexte 0.25
		)
	(setq style (getvar "textstyle"))
	(setq VarUCS (getvar "ucsxdir"))
	(setq difference_angle (atan (cadr VarUCS) (car VarUCS)))
	
;; valeurs de calcul pour la fonction et entrées utilisateur
	(if (= CommandeEnCours nil)
		(setq 
			CommandeEnCours "oui"
			)
		)
	
;;début de la boucle des profils
	(while (> (length listeatrier) 0) 

		;; récuperation des information du profil
		(setq profilatrier (car listeatrier))
		(setq 
			distanceAxeToit (nth 0 Profilatrier) ;; = "PL"
			altitudeGauche (nth 1 Profilatrier)
			distanceToitGauche (nth 2 Profilatrier) ;; = "PL"
			altitudeToit (nth 3 Profilatrier)
			distanceToitDroite (nth 4 Profilatrier) ;; = "PL"
			altitudeDroite (nth 5 Profilatrier)
			)

		;; Modification du point gauche
		(progn
			(while 
				(/= "POINT" (progn
					(initget 1)
					(setq EntPointGauche (car (entsel "\nSelectionner le point gauche du profil: ")))
					(setq 
						LstdxfPointGauche (entget EntPointGauche)
						TypeEntPointGauche (cdr (assoc 0 LstdxfPointGauche))
						)
					TypeEntPointGauche
					))
				(alert "L'objet selectionné n'est pas un point.")
				)
				
			(setq
				CoordonneesPointGauche (cdr (assoc 10 LstdxfPointGauche))
				NewCoordonneesPointGauche (list (car CoordonneesPointGauche) (cadr CoordonneesPointGauche) altitudeGauche)
				NewLstdxfPointGauche (subst (cons 10 NewCoordonneesPointGauche) (assoc 10 LstdxfPointGauche) LstdxfPointGauche)
				)
			(entmod NewLstdxfPointGauche)
			)
		
		;; Modification du point toit
		(progn
			(while 
				(/= "POINT" (progn
					(initget 1)
					(setq EntPointToit (car (entsel "\nSelectionner le point toit du profil: ")))
					(setq 
						LstdxfPointToit (entget EntPointToit)
						TypeEntPointToit (cdr (assoc 0 LstdxfPointToit))
						)
					TypeEntPointToit
					))
				(alert "L'objet selectionné n'est pas un point.")
				)
				
			(setq
				CoordonneesPointToit (cdr (assoc 10 LstdxfPointToit))
				NewCoordonneesPointToit (list (car CoordonneesPointToit) (cadr CoordonneesPointToit) altitudeToit)
				NewLstdxfPointToit (subst (cons 10 NewCoordonneesPointToit) (assoc 10 LstdxfPointToit) LstdxfPointToit)
				)
			(entmod NewLstdxfPointToit)
			)
			
		;; Modification du point Droite
		(progn
			(while 
				(/= "POINT" (progn
					(initget 1)
					(setq EntPointDroite (car (entsel "\nSelectionner le point droite du profil: ")))
					(setq 
						LstdxfPointDroite (entget EntPointDroite)
						TypeEntPointDroite (cdr (assoc 0 LstdxfPointDroite))
						)
					TypeEntPointDroite
					))
				(alert "L'objet selectionné n'est pas un point.")
				)
				
			(setq
				CoordonneesPointDroite (cdr (assoc 10 LstdxfPointDroite))
				NewCoordonneesPointDroite (list (car CoordonneesPointDroite) (cadr CoordonneesPointDroite) altitudeDroite)
				NewLstdxfPointDroite (subst (cons 10 NewCoordonneesPointDroite) (assoc 10 LstdxfPointDroite) LstdxfPointDroite)
				)
			(entmod NewLstdxfPointDroite)
			)
			
		;; stocker les variables systeme et les mettre à 0
		(progn
			(setq 
				os (getvar "osmode")
				dim (getvar "dimzin")
				)
			(setvar "osmode" 0)
			(setvar "dimzin" 0)
			)
		
		;; création de la flèche de pente de gauche
		(progn
			(setq p1 (trans NewCoordonneesPointGauche 0 1))
			(setq p2 (trans NewCoordonneesPointToit 0 1))
			(setq p1_final NewCoordonneesPointGauche)
			(setq p2_final NewCoordonneesPointToit)
			
			(if (< (caddr p1) (caddr p2))
				(and
					(setq p p1)
					(setq p1 p2)
					(setq p2 p)
					(setq p_final p1_final)
					(setq p1_final p2_final)
					(setq p2_final p_final)
					) ;; and
				) ;; if
		
			;; calcul des distances (sur x, sur y et sur z)
			(setq dx (- (car p2) (car p1)))
			(setq dy (- (cadr p2) (cadr p1)))
			(setq dz (- (caddr p2) (caddr p1)))
			
			;; variable pour savoir la direction de la flèche (si "+" = flèche vers la droite, si "-" flèche vers la gauche)
			(setq direction 
				(if (> (car p1) (car p2))
					"-"
					"+"
					)
				)
				
			;; determiner la pente entre les deux points
			(setq pente (abs (* (/ dz (sqrt (+ (* dx dx) (* dy dy)))) 100)))

			;; détermine l'angle du texte et de la flèche dans le SCU utilisateur
			(setq angle
				(if (> dx 0)
					(atan dy dx)
					(atan (* -1.0 dy) (* -1 dx))
					)
				)
				
			;; détermine le point de départ pour l'insertion du texte et de la flèche
			(setq pointmilieu
				(list
					(/ (+ (car p1) (car p2)) 2.00)
					(/ (+ (cadr p1) (cadr p2)) 2.00)
					0.00
					)
				)
				
			;; crée la chaine de texte à afficher comme pente
			(setq texte (strcat (rtos pente 2 1) "%"))
			
			;; transformation du point milieu de coordonnées utilisateurs à coordonnées générales
			(setq pointmilieu_final (trans pointmilieu 1 0))
			
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
						(polar pointmilieu_final (+ a_fp angle_final) (* FacteurFlèche l_fp))
						(polar pointmilieu_final (+ (- PI a_fp) angle_final) (* FacteurFlèche l_fp))
						)) ;; if cons
					(cons 40 0)
					(cons 41 (* FacteurFlèche 0.1))
					(cons 10 (if (= direction "+")
						(polar pointmilieu_final (+ a_fm angle_final) (* FacteurFlèche l_fm))
						(polar pointmilieu_final (+ (- PI a_fm) angle_final) (* FacteurFlèche l_fm))
						)) ;; if cons
					(cons 40 0)
					(cons 41 0)
					(cons 10 (if (= direction "+")
						(polar pointmilieu_final (+ a_ff angle_final) (* FacteurFlèche l_ff))
						(polar pointmilieu_final (+ (- PI a_ff) angle_final) (* FacteurFlèche l_ff))
						)) ;; if cons
					) ;; entmakex
				)
			(entmakex 
				(list 
					(cons 0 "MTEXT")
					;;(cons 8 calque)
					(cons 100 "AcDbEntity")
					(cons 100 "AcDbMText")
					(cons 10 (polar pointmilieu_final (+ a_t angle_final) (* FacteurFlèche l_t)))	;;point d'insertion
					(cons 40 (* FacteurFlèche hauteurtexte))
					(cons 41 2.0)
					(cons 71 8)
					(cons 1 texte)
					(cons 7 style)
					(cons 50 angle)
					)
				)
			)
			
		;; création de la flèche de pente de droite
		(progn
			(setq p1 (trans NewCoordonneesPointDroite 0 1))
			(setq p2 (trans NewCoordonneesPointToit 0 1))
			(setq p1_final NewCoordonneesPointDroite)
			(setq p2_final NewCoordonneesPointToit)
			
			(if (< (caddr p1) (caddr p2))
				(and
					(setq p p1)
					(setq p1 p2)
					(setq p2 p)
					(setq p_final p1_final)
					(setq p1_final p2_final)
					(setq p2_final p_final)
					) ;; and
				) ;; if
		
			;; calcul des distances (sur x, sur y et sur z)
			(setq dx (- (car p2) (car p1)))
			(setq dy (- (cadr p2) (cadr p1)))
			(setq dz (- (caddr p2) (caddr p1)))
			
			;; variable pour savoir la direction de la flèche (si "+" = flèche vers la droite, si "-" flèche vers la gauche)
			(setq direction 
				(if (> (car p1) (car p2))
					"-"
					"+"
					)
				)
				
			;; determiner la pente entre les deux points
			(setq pente (abs (* (/ dz (sqrt (+ (* dx dx) (* dy dy)))) 100)))

			;; détermine l'angle du texte et de la flèche dans le SCU utilisateur
			(setq angle
				(if (> dx 0)
					(atan dy dx)
					(atan (* -1.0 dy) (* -1 dx))
					)
				)
				
			;; détermine le point de départ pour l'insertion du texte et de la flèche
			(setq pointmilieu
				(list
					(/ (+ (car p1) (car p2)) 2.00)
					(/ (+ (cadr p1) (cadr p2)) 2.00)
					0.00
					)
				)
				
			;; crée la chaine de texte à afficher comme pente
			(setq texte (strcat (rtos pente 2 1) "%"))
			
			;; transformation du point milieu de coordonnées utilisateurs à coordonnées générales
			(setq pointmilieu_final (trans pointmilieu 1 0))
			
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
						(polar pointmilieu_final (+ a_fp angle_final) (* FacteurFlèche l_fp))
						(polar pointmilieu_final (+ (- PI a_fp) angle_final) (* FacteurFlèche l_fp))
						)) ;; if cons
					(cons 40 0)
					(cons 41 (* FacteurFlèche 0.1))
					(cons 10 (if (= direction "+")
						(polar pointmilieu_final (+ a_fm angle_final) (* FacteurFlèche l_fm))
						(polar pointmilieu_final (+ (- PI a_fm) angle_final) (* FacteurFlèche l_fm))
						)) ;; if cons
					(cons 40 0)
					(cons 41 0)
					(cons 10 (if (= direction "+")
						(polar pointmilieu_final (+ a_ff angle_final) (* FacteurFlèche l_ff))
						(polar pointmilieu_final (+ (- PI a_ff) angle_final) (* FacteurFlèche l_ff))
						)) ;; if cons
					) ;; entmakex
				)
			(entmakex 
				(list 
					(cons 0 "MTEXT")
					;;(cons 8 calque)
					(cons 100 "AcDbEntity")
					(cons 100 "AcDbMText")
					(cons 10 (polar pointmilieu_final (+ a_t angle_final) (* FacteurFlèche l_t)))	;;point d'insertion
					(cons 40 (* FacteurFlèche hauteurtexte))
					(cons 41 2.0)
					(cons 71 8)
					(cons 1 texte)
					(cons 7 style)
					(cons 50 angle)
					)
				)
			)
			
		;; rétablissement des variables système
		(setvar "osmode" os)
		(setvar "dimzin" dim)
			
		;; Fin du profil + incrémentation de la liste à trier
		(setq listeatrier (cdr listeatrier))

;; fin de boucle des profils
		)

;; retablissement de la variables de fin de commande
	(setq CommandeEnCours nil)
	)
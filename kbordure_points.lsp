(defun C:kbordure_points ()
	(defun aucarre (asdf) (* asdf asdf))
	
	(setq 
		;; décalage sur X des points d'insertions des textes dans le tableau depuit la ligne verticale la plus à gauche du tableau
		;; tableauDecalageKilometrage 2.00 (annulé)
		tableauDecalageNumero 1.35
		tableauDecalageCoordonneeX 5.05
		tableauDecalageCoordonneeY 9.75
		tableauDecalageCoordonneeZ 14.45
		;; tableauDecalageRemarque 17.05 (annulé)

		;; décalage sur X des lignes verticales du tableau par rapport à la ligne la plus à gauche du tableau
		;; tableauLigneVerticale1Decalage 3.90 (annulé)
		tableauLigneVerticale2Decalage 2.70
		tableauLigneVerticale3Decalage 7.40
		tableauLigneVerticale4Decalage 12.10
		tableauLigneVerticale5Decalage 16.80
		tableauLigneVerticale6Decalage 20.15
		tableauLigneVerticaleDroiteDecalage 23.50

		;; décalage sur Y des objets du tableau 
		tableauHauteurLigne 0.9
		tableauDecalagetexteLigne 0.45

		;;informations des objets textes dans le tableau
		tableauHauteurTexte 0.6
		tableauPolice "ARIAL"
		)
		(if (= (tblsearch "STYLE" "ARIAL") nil)
			(progn
				(print "\nLe style de texte \"ARIAL\" n'existe pas. \nLes objets qui devaient être créer avec ce style seront créer avec le style de texte courant. ")
				(setq tableauStyleTexte (getvar "textstyle"))
				)
			(setq tableauStyleTexte "ARIAL")
			)
	(setq 
		;; informations sur les objets en situation
		situDecalageTexte 1
		situAzimutTexte 0
		situHauteurTexte 0.5
		situRotationTexte (* 3.0 (/ pi 2.00))
		situPolice "ARIAL"
		)
		
	(if (= (tblsearch "STYLE" "ARIAL") nil)
		;; pas besoin de rajouter le texte "Le style "ARIAL" n'héxiste pas..." car déjà mis avant
		(setq situStyleTexte (getvar "textstyle"))
		(setq situStyleTexte "ARIAL")
		)
		
	(if (= SituAltitude nil)
		(setq SituAltitude 0.0)
		)
		
	(setq style (getvar "textstyle"))
	
	;; informations sur les calques
	(if (= (tblsearch "LAYER" "tableaux coordonnées points - 010") nil) ;;calque TableauLigneHorizontalMineurCalque
		(progn
			(print "\nLe calque \"tableaux coordonnées points - 010\" n'existe pas. \nLes objets qui devaient être créer dans ce calque seront mis dans le calque \"0\". ")
			(setq TableauLigneHorizontalMineurCalque "0")
			)
		(setq TableauLigneHorizontalMineurCalque "tableaux coordonnées points - 010")
		)
		
	(if (= (tblsearch "LAYER" "tableaux coordonnées points - 050") nil) ;;calques TableauLigneHorizontalMajeurCalque TableauLigneVerticalMajeurCalque
		(progn
			(print "\nLe calque \"tableaux coordonnées points - 050\" n'existe pas. \nLes objets qui devaient être créer dans ce calque seront mis dans le calque \"0\". ")
			(setq 
				TableauLigneHorizontalMajeurCalque "0"
				TableauLigneVerticalMajeurCalque "0"
				)
			)
		(setq 
			TableauLigneHorizontalMajeurCalque "tableaux coordonnées points - 050"
			TableauLigneVerticalMajeurCalque "tableaux coordonnées points - 050"
			)
		)
		
	(if (= (tblsearch "LAYER" "tableaux coordonnées points - 013") nil) ;;calque TableauLigneVerticalMineurCalque
		(progn
			(print "\nLe calque \"tableaux coordonnées points - 013\" n'existe pas. \nLes objets qui devaient être créer dans ce calque seront mis dans le calque \"0\". ")
			(setq TableauLigneVerticalMineurCalque "0")
			)
		(setq TableauLigneVerticalMineurCalque "tableaux coordonnées points - 013")
		)
		
	(if (= (tblsearch "LAYER" "Points") nil) 							;; calque SituPointCalqueBordure
		(progn
			(print "\nLe calque \"Points\" n'existe pas. \nLes objets qui devaient être créer dans ce calque seront mis dans le calque \"0\". ")
			(setq SituPointCalqueBordure "0")
			)
		(setq SituPointCalqueBordure "Points")
		)
		
	(if (= (tblsearch "LAYER" "Point avec changement de rayon") nil) 	;; calque SituPointCalqueGeometrie
		(progn
			(print "\nLe calque \"Point avec changement de rayon\" n'existe pas. \nLes objets qui devaient être créer dans ce calque seront mis dans le calque \"0\". ")
			(setq SituPointCalqueGeometrie "0")
			)
		(setq SituPointCalqueGeometrie "Point avec changement de rayon")
		)
	
	(if  ;;si ces deux calques existent, un choix sera disponible plus tard. Sinon pas de choix.
		(or
			(= (tblsearch "LAYER" "Points") nil)
			(= (tblsearch "LAYER" "Point avec changement de rayon") nil)
			)
		(setq ChoixTypePoint "NON")
		(setq ChoixTypePoint "OUI")
		)
	
;;entrées utilisateurs	
	(initget 1)
	(setq pointInsertionTableau (getpoint "\nChoisissez un point qui sera le coin haut gauche du tableau de coordonnée:"))
	
	(setq CoinHautGaucheligneTexte pointInsertionTableau)
	
	(setq numeroPoint (getreal "\nDéfinissez le numéro du premier point: "))
	(if (= numeroPoint nil) (setq numeroPoint 1))
		
;; début de la boucle	
	(while 
		;; entrées utilisateur
		
			;;point d'insertion
		(/= (setq Point1U (getpoint "\nChoisissez un point sur la bordure ou ENTER pour mettre fin à la commande: ")) nil)
		(setq Point1W (trans Point1U 1 0))
			
			;;orientationkp
		(if (= AncienOrientationTexteU nil)
			(setq TexteOrientation "\nChoisissez l'orientation du texte: ")
			(setq TexteOrientation "\nChoisissez l'orientation du texte ou ENTER pour prendre l'orientation du texte précedent: ")
			)
			
		(if (= AncienOrientationTexteU nil)
					(initget 1)
					)
	
		(setq Point2U (getpoint Point1U TexteOrientation))
		(if (= Point2U nil)
			(setq OrientationTexteU AncienOrientationTexteU)
			(progn
				(setq dxU (- (car Point2U) (car Point1U)))
				(setq dyU (- (cadr Point2U) (cadr Point1U)))
				(setq OrientationTexteU (atan dyU dxU))
				
				(setq Point2W (trans Point2U 1 0))
				(setq dxW (- (car Point2W) (car Point1W)))
				(setq dyW (- (cadr Point2W) (cadr Point1W)))
				(setq difference_angle (- (atan dyU dxU) (atan dyW dxW)))
				(setq OrientationTexteW (- OrientationTexteU difference_angle))
				)
			)
		(setq AncienOrientationTexteU OrientationTexteU)
		
			;; choix du type de point
		(if (= ChoixTypePoint "OUI")
			(progn 
				(if (= AncienOptionTypeBordure nil)
					(setq TexteChoixTypeBordure (strcat "\nQu'elle est ce point? Un [changement de Type / changement de la Geometrie]?"))
					(setq TexteChoixTypeBordure (strcat
						"\nQu'elle est ce point? Un [changement de Type / changement de la Geometrie]? <" 
						(if (= AncienOptionTypeBordure "Type") "changement de Type" "changement de Geometrie")
						">"
						))
					)
				(if (= AncienOptionTypeBordure nil)
					(initget 1 "Type Geometrie")
					(initget "Type Geometrie")
					)
				(setq OptionTypeBordure (getkword TexteChoixTypeBordure)) ;;entrée utilisateur
				
				(if (= OptionTypeBordure nil)
					(setq OptionTypeBordure AncienOptionTypeBordure)
					)
				(if (= OptionTypeBordure "Type")
					(setq SituPointCalque SituPointCalqueBordure)
					)
				(if (= OptionTypeBordure "Geometrie")
					(setq SituPointCalque SituPointCalqueGeometrie)
					)
				(setq AncienOptionTypeBordure OptionTypeBordure)
				)
			(setq SituPointCalque SituPointCalqueBordure)
			)
		
		;; socker les variables systeme et les mettre à 0
		(setq 
			os (getvar "osmode")
			dim (getvar "dimzin")
			)
		(setvar "osmode" 0)
		(setvar "dimzin" 0)
				
		;; création du point gauche en situation et stockage de son id
		(setq SituInsertionObjetPoint Point1W)
		(setq SituInsertionObjetPoint (list (car SituInsertionObjetPoint) (cadr SituInsertionObjetPoint) SituAltitude))
		(setq idObjectPoint (entmakex (list 
			(cons 0 "POINT")
			(cons 8 SituPointCalque)
			(cons 10 SituInsertionObjetPoint)
			)))
					
		;; création des textes de coordonnées du point gauche dans le tableau
		(setq TableauTextePointGaucheCoordonneeX (strcat "%<\\AcObjProp Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectPoint))) ">%).Coordinates \\f \"%lu2%pt1%pr2\">%"))
		(entmakex ;; création du texte
			(list
				(cons 0 "TEXT")
				(cons 8 SituPointCalqueBordure)
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
		(setq TableauTextePointGaucheCoordonneeY (strcat "%<\\AcObjProp Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectPoint))) ">%).Coordinates \\f \"%lu2%pt2%pr2\">%"))
		(entmakex ;; création du texte
			(list
				(cons 0 "TEXT")
				(cons 8 SituPointCalqueBordure)
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
		(setq TableauTextePointGaucheCoordonneeZ (strcat "%<\\AcObjProp Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idObjectPoint))) ">%).Coordinates \\f \"%lu2%pt4%pr2\">%"))
		(entmakex ;; création du texte
			(list
				(cons 0 "TEXT")
				(cons 8 SituPointCalqueBordure)
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
			(setq idTexteNumero (entmakex ;; création du texte
				(list
					(cons 0 "TEXT")
					(cons 8 SituPointCalque)
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
			(setq situTextePointGaucheNumero (strcat "%<\\AcObjProp Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idTexteNumero))) ">%).TextString>%"))
			(setq situInsertionObjetNumero (polar Point1W (+ OrientationTexteW situAzimutTexte) situDecalageTexte))
			(setq situInsertionObjetNumero (list (car situInsertionObjetNumero) (cadr situInsertionObjetNumero) 0.0))
			(entmakex ;; création du texte
				(list
					(cons 0 "TEXT")
					(cons 8 SituPointCalque)
					(cons 10 (list 0 0 0 ))
					(cons 40 situHauteurTexte)
					(cons 1 situTextePointGaucheNumero)
					(cons 50 (+ OrientationTexteW situRotationTexte))
					(cons 7 situStyleTexte)
					(cons 72 1)
					(cons 73 2)
					(cons 11 situInsertionObjetNumero)
					)
				)
						
			;; création de la ligne en dessous des textes
			(setq idObjectLine (entmakex (list
				(cons 0 "LINE")
				(cons 8 TableauLigneHorizontalMineurCalque)
				(cons 10 (list (car CoinHautGaucheligneTexte) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
				(cons 11 (list (+ (car CoinHautGaucheligneTexte) tableauLigneVerticale5Decalage) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0 ))
				)))
						
			;; incrémentation de 1 du numéro de point
			(setq 
				numeroPoint (+ numeroPoint 1)
				CoinHautGaucheligneTexte (list (car CoinHautGaucheligneTexte) (- (cadr CoinHautGaucheligneTexte) tableauHauteurLigne) 0.0)
				)
				
			;; variable de fin de profil principal
			(setvar "osmode" os)
			(setvar "dimzin" dim)
			
			;; reinitialisation des variables
			(setq 
				Point1U nil
				Point2U nil
				Point1W nil
				Point2W nil
				dxU nil
				dyU nil
				dxW nil
				dyW nil
				)
				
			)
			;; fin de boucle
			
		;; Création des lignes vérticales
		(entmakex (list
			(cons 0 "LINE")
			(cons 8 TableauLigneVerticalMineurCalque)
			(cons 10 (list (+ (car pointInsertionTableau) tableauLigneVerticale2Decalage) (cadr pointInsertionTableau) 0.0 ))
			(cons 11 (list (+ (car pointInsertionTableau) tableauLigneVerticale2Decalage) (cadr CoinHautGaucheligneTexte) 0.0 ))
			))
		(entmakex (list
			(cons 0 "LINE")
			(cons 8 TableauLigneVerticalMineurCalque)
			(cons 10 (list (+ (car pointInsertionTableau) tableauLigneVerticale3Decalage) (cadr pointInsertionTableau) 0.0 ))
			(cons 11 (list (+ (car pointInsertionTableau) tableauLigneVerticale3Decalage) (cadr CoinHautGaucheligneTexte) 0.0 ))
			))
		(entmakex (list
			(cons 0 "LINE")
			(cons 8 TableauLigneVerticalMineurCalque)
			(cons 10 (list (+ (car pointInsertionTableau) tableauLigneVerticale4Decalage) (cadr pointInsertionTableau) 0.0 ))
			(cons 11 (list (+ (car pointInsertionTableau) tableauLigneVerticale4Decalage) (cadr CoinHautGaucheligneTexte) 0.0 ))
			))
		(entmakex (list
			(cons 0 "LINE")
			(cons 8 TableauLigneVerticalMineurCalque)
			(cons 10 (list (+ (car pointInsertionTableau) tableauLigneVerticale5Decalage) (cadr pointInsertionTableau) 0.0 ))
			(cons 11 (list (+ (car pointInsertionTableau) tableauLigneVerticale5Decalage) (cadr CoinHautGaucheligneTexte) 0.0 ))
			))
		(entmakex (list
			(cons 0 "LINE")
			(cons 8 TableauLigneVerticalMineurCalque)
			(cons 10 (list (+ (car pointInsertionTableau) tableauLigneVerticale6Decalage) (cadr pointInsertionTableau) 0.0 ))
			(cons 11 (list (+ (car pointInsertionTableau) tableauLigneVerticale6Decalage) (cadr CoinHautGaucheligneTexte) 0.0 ))
			))
		
		;; Création de la liste de points du cadre
		(setq liste 
			(list 
				(cons 10 pointInsertionTableau)
				(cons 10 (list (car pointInsertionTableau) (cadr CoinHautGaucheligneTexte) 0.0))
				(cons 10 (list (+ (car pointInsertionTableau) tableauLigneVerticaleDroiteDecalage) (cadr CoinHautGaucheligneTexte) 0.0))
				(cons 10 (list (+ (car pointInsertionTableau) tableauLigneVerticaleDroiteDecalage) (cadr pointInsertionTableau) 0.0))
				))
	
		(entmakex ;; création du cadre
			(append 
				(list 
					(cons 0 "LWPOLYLINE")
					(cons 100 "AcDbEntity")
					(cons 8 TableauLigneVerticalMajeurCalque)
					(cons 100 "AcDbPolyline")
					(cons 90 (length liste))
					(cons 70 1)
					)
				liste
				)
			)
		;; suppression de la dernière ligne horizontale
		(entdel idObjectLine)
	)
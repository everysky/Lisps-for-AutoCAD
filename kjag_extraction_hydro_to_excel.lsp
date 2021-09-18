(defun C:kjag_extraction_hydro_to_excel ()
	(vl-load-com)
	(defun aucarre (asdf) (* asdf asdf))
	(defun distance (qwertz1 qwertz2) (sqrt (+ (aucarre (- (car qwertz1) (car qwertz2))) (aucarre (- (cadr qwertz1) (cadr qwertz2))))))
	(defun angle (yxcv1 yxcv2) (atan (- (cadr yxcv2) (cadr yxcv1)) (- (car yxcv2) (car yxcv1))))
	
	;; code trouvé ici http://www.theswamp.org/index.php?topic=21764.msg263322#msg263322
	(defun _SetClipBoardText ( text / htmlfile result )

    ;;  Caller's sole responsibility is to pass a
    ;;  text string. Anything else? Pie in face.

		(setq result
			(vlax-invoke
				(vlax-get
					(vlax-get
						(setq htmlfile (vlax-create-object "htmlfile"))
					   'ParentWindow
						)
				   'ClipBoardData
					)
			   'SetData
				"Text"
				text
				)
			)
		(vlax-release-object htmlfile)
		text
		)
	
	(setq option1 nil)
	
	(if (/= listeInfoChambres nil) 
		(progn
			(initget "Continuer Nouveau")
			(setq option1 (getkword "\nUn réseau est déjà en cours de traitement. Que voulez-vous faire? Continuer le reseau existant ou en céer un nouveau? [Continuer/Nouveau]: <Continuer>"))
			
			(if (= option1 nil)
				(setq option1 "Continuer")
				)
				
			(if (= option1 "Nouveau")
				(setq
					listeInfoChambres (list (list "ID\tPosition X\tPosition Y\t\tAltitude fil d'eau\r\n"))
					listeInfoCanalisations (list (list "ID segment\tID point haut\tALT point haut\tID point bas\tAlt point bas\tØ\tCoordonnée\r\n"))
					int 1
					)
				)
			)
		)
	(while 
		(/= nil (progn
			(if (= option1 "Continuer")
				(progn
					(if (= option5 "Menu")
						(setq 
							int 1
							option5 nil
							)
						)
					(setq texteOption "Que voulez-vous faire? Continuer à relever le réseau, extraire les données vers Excel ou commencer un nouveau réseau? [Continuer/Extraire/Nouveau]: ")
					(initget 1 "Continuer Extraire Nouveau")
					(setq option (getkword texteOption))
					)
				(setq option "Nouveau")
				)
			option
			))
			
		(if (= option "Nouveau")
			(setq
				listeInfoChambres (list (list "ID\tPosition X\tPosition Y\t\tAltitude fil d'eau\r\n"))
				listeInfoCanalisations (list (list "ID segment\tID point haut\tALT point haut\tID point bas\tAlt point bas\tØ\trugosité\ttype\tCoordonnée\r\n"))
				option "Continuer"
				int 1
				)
			)
			
		(if (= option "Continuer")
			(while (< int 14)
				
				(if (= int 1) ;; point insertion chambre initiale
					(progn
						(if (= (length listeInfoChambres) 1)
							(progn
								(initget 1)
								(setq PointInsertionChambreBasse (getpoint "\nChoisissez la chambre la plus basse de votre réseau. Sélectionner le centre de cette chambre."))
								)
							)
						(setq 
							int (+ 1 int))
							option1 nil
							option nil
						)
					)
				
				(if (= int 2) ;; nom de la chambre
					(progn
						(if (= (length listeInfoChambres) 1)
							(progn
								(initget 1 "annUler")
								(setq IDChambreBasse (getstring "\nEntrer le nom de cette chambre ou [annUler]: "))
								(if (= IDChambreBasse "annUler")
									(setq 
										int (- int 1)
										IDChambreBasse nil
										)
									(setq int (+ int 1))
									)
								)
							(setq int (+ 1 int))
							)
						)
					)
					
				(if (= int 3) ;; altitude fil d'eau
					(progn
						(if (= (length listeInfoChambres) 1)
							(progn
								(initget 1 "annUler")
								(setq AltitudeChambreBasse (getreal "\nEntrer l'altitude du fil d'eau de la chambre ou [annUler]: "))
								(if (= AltitudeChambreBasse "annUler")
									(setq 
										int (- int 1)
										AltitudeChambreBasse nil
										)
									(setq int (+ int 1))
									)
								)
							(setq int (+ 1 int))
							)
						)
					)
					
				(if (= int 4) ;; OK chambre
					(progn
						(if (= (length listeInfoChambres) 1)
							(progn
								(initget "Continuer annUler")
								(setq TexteOption2 (strcat
									"\nChambre n°"
									IDChambreBasse
									" ¦ fil d'eau="
									(rtos AltitudeChambreBasse 2 2)
									" ¦ Voulez-vous continuer avec ces informations? [Continuer/annUler]: <Continuer>"
									))
								(setq option2 (getkword TexteOption2))
								
								(if (= option2 nil)
									(setq option2 "Continuer")
									)
								(if (= option2 "annUler")
									(setq 
										int (- int 1)
										)
									(progn
										(setq InfosChambre (list
											IDChambreBasse
											PointInsertionChambreBasse
											(strcat 		;; objet qgis
												"point("
												(rtos (car PointInsertionChambreBasse) 2 3)
												" "
												(rtos (cadr PointInsertionChambreBasse) 2 3)
												")"
												)
											AltitudeChambreBasse
											))
										(setq listeInfoChambres (append listeInfoChambres (list InfosChambre)))
										(setq int (+ int 1))
										)
									)
								)
							(setq int (+ 1 int))
							)
						)
					)
				
				(if (= int 5) ;; point insertion prochaine chambre
					(progn
						(initget 1)
						(setq PointInsertionChambrehaute (getpoint (cadr (last listeInfoChambres)) "\nChoisissez la prochaine chambre de votre réseau. Sélectionner le centre de cette chambre."))
						(setq int (+ 1 int))
						)
					)

				(if (= int 6) ;; nom de la chambre
					(progn
						(initget 1 "annUler")
						(setq IDChambrehaute (getstring "\nEntrer le nom de cette chambre ou [annUler]: "))
						(if (= IDChambrehaute "annUler")
							(setq 
								int (- int 1)
								IDChambrehaute nil
								)
							(setq int (+ int 1))
							)
						)
					)
					
				(if (= int 7) ;; altitude fil d'eau
					(progn
						(initget 1 "annUler")
						(setq AltitudeChambreHaute (getreal "\nEntrer l'altitude du fil d'eau de la chambre ou [annUler]: "))
						(if (= AltitudeChambreHaute "annUler")
							(setq 
								int (- int 1)
								AltitudeChambreHaute nil
								)
							(setq int (+ int 1))
							)
						)
					)
				
				(if (= int 8) ;; OK chambre
					(progn
						(initget "Continuer annUler")
						(setq TexteOption3 (strcat
							"\nChambre n°"
							IDChambrehaute
							" ¦ fil d'eau="
							(rtos AltitudeChambreHaute 2 2)
							" ¦ Voulez-vous continuer avec ces informations? [Continuer/annUler]: <Continuer>"
							))
						(setq option3 (getkword TexteOption3))
						
						(if (= option3 nil)
							(setq option3 "Continuer")
							)
						(if (= option3 "annUler")
							(setq 
								int (- int 1)
								)
							(progn
								(setq InfosChambre (list
									IDChambrehaute
									PointInsertionChambrehaute
									(strcat 		;; objet qgis
										"point("
										(rtos (car PointInsertionChambrehaute) 2 3)
										" "
										(rtos (cadr PointInsertionChambrehaute) 2 3)
										")"
										)
									AltitudeChambreHaute
									))
								(setq int (+ int 1))
								)
							)
						)
					)
				
				(if (= int 9) ;; diamètre de la canalisation
					(progn
						(initget 1)
						(setq DiametreCanalisation (getint "Quel est le diamètre de la canalisation entre les deux dernières chambres? (ex: Ø400 => Ecrivez 400): "))
						(setq int (+ 1 int))
						)
					)
					
				(if (= int 10) ;; alt point bas
					(progn
						(setq TexteAltitudeCanaBas (strcat
							"\nEntrer l'altitude du point bas de la canalisation ou [annUler]: <"
							(rtos (nth 3 (last listeInfoChambres)) 2 2)
							">"
							))
						(initget "annUler")
						(setq AltitudeCanaBas (getreal TexteAltitudeCanaBas))
						
						(if (= AltitudeCanaBas nil)
							(setq AltitudeCanaBas (nth 3 (last listeInfoChambres)))
							)
							
						(if (= AltitudeCanaBas "annUler")
							(setq
								int (- int 1)
								AltitudeCanaBas nil
								)
							(setq int (+ int 1))
							)
						)
					)
					
				(if (= int 11) ;; alt point haut
					(progn
						(setq TexteAltitudeCanaHaut (strcat
							"\nEntrer l'altitude du point haut de la canalisation ou [annUler]: <"
							(rtos AltitudeChambreHaute 2 2)
							">"
							))
						(initget "annUler")
						(setq AltitudeCanaHaut (getreal TexteAltitudeCanaHaut))
						
						(if (= AltitudeCanaHaut nil)
							(setq AltitudeCanaHaut AltitudeChambreHaute)
							)
							
						(if (= AltitudeCanaHaut "annUler")
							(setq 
								int (- int 1)
								AltitudeCanaHaut nil
								)
							(setq int (+ int 1))
							)
						)
					)
					
				(if (= int 12) ;; OK canalisation
					(progn
						(initget "Continuer annUler")
						(setq TexteOption4 (strcat
							"\nCanalisation Ø"
							(rtos DiametreCanalisation 2 0)
							" ¦ Point bas="
							(rtos AltitudeCanaBas 2 2)
							" ¦ Point haut="
							(rtos AltitudeCanaHaut 2 2)
							" ¦ Voulez-vous continuer avec ces informations? [Continuer/annUler]: <Continuer>"
							))
						(setq option4 (getkword TexteOption4))
						
						(if (= option4 nil)
							(setq option4 "Continuer")
							)
						(if (= option4 "annUler")
							(setq 
								int (- int 1)
								)
							(progn
								(setq InfosCanalisation (list
									(strcat 
										"S."
										(rtos (getvar "cdate") 2 6)
										)
									IDChambrehaute
									AltitudeCanaHaut
									(car (last listeInfoChambres))
									AltitudeCanaBas
									DiametreCanalisation
									(strcat 		;; objet qgis
										"LINESTRING("
										(rtos (car PointInsertionChambrehaute) 2 3)
										" "
										(rtos (cadr PointInsertionChambrehaute) 2 3)
										","
										(rtos (car (cadr (last listeInfoChambres))) 2 3)
										" "
										(rtos (cadr (cadr (last listeInfoChambres))) 2 3)
										")"
										)
									))
								(setq listeInfoCanalisations (append listeInfoCanalisations (list InfosCanalisation)))
								(setq listeInfoChambres (append listeInfoChambres (list InfosChambre)))
								(setq int (+ int 1))
								)
							)
						)
					)
				(if (= int 13) ;; continuer?
					(progn
						(initget "Continuer Menu")
						(setq option5 (getkword "\nQue voulez-vous faire? Continuer à relever le réseau ou revenir au menu? [Continuer/Menu]: <Continuer>"))
						
						(if (= option5 nil)
							(setq option5 "Continuer")
							)
							
						(if (= option5 "Continuer")
							(setq int 1)
							(setq int (+ int 1))
							)
						)
					)
				)
			)
		
		(if (= option "Extraire")
			(while
				(/= nil 
					(progn
						(setq texteOption6 "\nQue voulez-vous faire? Extraire les chambres, extraire les canalisations ou revenir au menu principal? [Chambres/cAnalisations/Menu]: ")
						(initget  "Chambres cAnalisations Menu")
						(setq option6 (getkword texteOption6))
						(if (= option6 "Menu")
							(setq option6 nil)
							)
						option6
						)
					)
				
				(if (= option6 "Chambres")
					(progn
						(setq 
							ListeATrier listeInfoChambres
							TexteFinal (car (car ListeATrier))
							ListeATrier (cdr ListeATrier)
							)
						(while (> (length ListeATrier) 0)
							(setq 
								chambreATraiter (car ListeATrier)
								TexteEnTraitement (strcat
									(nth 0 chambreATraiter)
									"\t"
									(rtos (car (nth 1 chambreATraiter))2 3)
									"\t"
									(rtos (cadr (nth 1 chambreATraiter)) 2 3)
									"\t"
									(nth 2 chambreATraiter)
									"\t"
									(rtos (nth 3 chambreATraiter) 2 2)
									"\r\n"
									)
								ListeATrier (cdr ListeATrier)
								TexteFinal (strcat TexteFinal TexteEnTraitement)
								)
							)
						(_SetClipBoardText TexteFinal)
						(princ "\nLes infos des chambres ont été copiées dans le presse papier.")
						)
					)
				
				(if (= option6 "cAnalisations")
					(progn
						(setq 
							ListeATrier listeInfoCanalisations
							TexteFinal (car (car ListeATrier))
							ListeATrier (cdr ListeATrier)
							)
						(while (> (length ListeATrier) 0)
							(setq 
								canalisationATraiter (car ListeATrier)
								TexteEnTraitement (strcat
									(nth 0 canalisationATraiter)
									"\t"
									(nth 1 canalisationATraiter)
									"\t"
									(rtos (nth 2 canalisationATraiter) 2 2)
									"\t"
									(nth 3 canalisationATraiter)
									"\t"
									(rtos (nth 4 canalisationATraiter) 2 2)
									"\t"
									(rtos (nth 5 canalisationATraiter) 2 0)
									"\t"
									(nth 6 canalisationATraiter)
									"\r\n"
									)
								ListeATrier (cdr ListeATrier)
								TexteFinal (strcat TexteFinal TexteEnTraitement)
								)
							)
						(_SetClipBoardText TexteFinal)
						(princ "\nLes infos des canalisations ont été copiées dans le presse papier.")
						)
					)
				)
			)
		)
	)
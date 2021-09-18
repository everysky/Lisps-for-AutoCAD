(defun C:ktri_collecteur_EC-EU ()

	(setq 
		NomDuBlocAChercher "RAE_PT_RACCORDEMENT"
		NomDeLAttributAChercher "Contenu"
		RayonDuCercleACreer 0.5
		)
	
	(entmake (list
		(cons 0 "LAYER")
		(cons 100 "AcDbSymbolTableRecord")
		(cons 100 "AcDbLayerTableRecord")
		(cons 2 "S+N - EC - collecteur")				;; nom du calque
		(cons 70 0)
		(cons 62 160)							;; couleur du calque
		(cons 6 "Continuous")					;; type de ligne 
		))
	(entmake (list
		(cons 0 "LAYER")
		(cons 100 "AcDbSymbolTableRecord")
		(cons 100 "AcDbLayerTableRecord")
		(cons 2 "S+N - EU - collecteur")
		(cons 70 0)
		(cons 62 10)							;; couleur du calque
		(cons 6 "Continuous")					;; type de ligne 
		))
	(entmake (list
		(cons 0 "LAYER")
		(cons 100 "AcDbSymbolTableRecord")
		(cons 100 "AcDbLayerTableRecord")
		(cons 2 "S+N - Désactivé")				;; nom du calque
		(cons 70 0)
		(cons 62 252)							;; couleur du calque
		(cons 6 "Continuous")					;; type de ligne 
		))
	
	(setq 
		NombreDeBlocsATrier nil
		NombreDeBlocsEC 0
		NombreDeBlocsEU 0
		NombreDeBlocsAutre 0
		ListeTermesEC nil
		ListeTermesEU nil
		)
	
	(princ "\nSelectionnez les objets a traiter:")
	(setq
		ssbase (ssget)	;; creation du jeu de selection ss avec tout les objets à traiter
		i	 0		;; compteur
		)
		
	;; test de la selection d'objet
	(if (= nil ssbase)
		(progn
		  (print "\nPas d'objets sélectionnés, sortie du programme")
		  (quit)
		  )
		(print "\nListe des objets séléctionnés non nulle, suite du programme")
		)
		
	;; boucle de tri pour séparer les blocs	
	(setq ssblock (ssadd))
	(repeat (sslength ssbase)
		(setq ent (ssname ssbase i))	;; définir l'entité à tester
		(setq lstdxf (entget ent))	;; lui extraire ses données DXf pour pouvoir tester
		(setq enttype (cdr (assoc 0 lstdxf)))	;; extrait le type d'objet de l'entité
		(cond
			((= enttype "INSERT") (ssadd ent ssblock))			;; si c'est un block, l'entitée est ajoutée à la liste de block
			)
		(setq i (1+ i)) 
		)
		
	;; test de la liste de bloc
	(if (= ssblock nil)
		(progn
			(print "\nPas de blocks sélectionnées, sortie du programme")
			(quit)
			)
		(print "\nListe des blocs non nulle, suite du programme")
		)
		
	(setq ssblockfinal ssblock) ;;ligne remplacant le code si dessous
		
	;; tri des blocs (seulement "RAE_REGARD_CHAMBRE")
	;;(setq i 0)
	;;(setq ssblockfinal (ssadd))
	;;(repeat (sslength ssblock)
	;;	(setq ent (ssname ssblock i))
	;;	(setq lstdxf (entget ent))
	;;	(setq entnom (cdr (assoc 2 lstdxf)))
	;;	(cond
	;;		((= entnom NomDuBlocAChercher) (ssadd ent ssblockfinal))
	;;		)
	;;	(setq i (1+ i))
	;;	)
	
	;; test de la liste créée
	;;(if (= ssblockfinal nil)
	;;	(progn
	;;		(print "\nPas de blocs avec le bon nom, sortie du programme")
	;;		(quit)
	;;		)
	;;	(progn
	;;		(print "\nBlocs avec le bon nom existants, suite du programmme")
	;;		(setq NombreDeBlocsATrier (sslength ssblockfinal))
	;;		)
	;;	)
	
	;; boucle de tri des blocs dans les bons calques
	(setq i 0)
	(repeat (sslength ssblockfinal)						;; début de la boucle
		(setq EntBlock (ssname ssblockfinal i)) 		;; nom d'entité du block
		(setq lstdxf (entget EntBlock))					;; definition du block
		(setq PointInsertion (cdr (assoc 10 lstdxf)))	;; point d'insertion du bloc
		(setq AttText nil)								;; reset du texte de l'attribut
		(setq EntAtt (entnext EntBlock))							;; nom d'entité de l'entité suivante
		(setq EntAttLstdxf (entget EntAtt))							;; définition de l'entité
		(while (not (= (cdr (assoc 0 EntAttLstdxf)) "SEQEND"))		;; début de la boucle des attribut
			(if															;; si
				(and 
					(= (cdr (assoc 0 EntAttLstdxf)) "ATTRIB")					;; c'est une entité "attribu"
					(= (cdr (assoc 2 EntAttLstdxf)) NomDeLAttributAChercher)	;; le nom de l'entité "attribu" est "CONTENU"
					)
				(setq AttText (cdr (assoc 1 EntAttLstdxf)))					;; aller chercher le texte de l'entité "attribu"
				)
			(setq EntAtt (entnext EntAtt))								;; nom d'entité de l'entité suivante
			(setq EntAttLstdxf (entget EntAtt))							;; définition de l'entité
			)
		
		(setq 
			choixEcEu nil
			EstDansEC 0
			EstDansEU 0
			)
		(if (or (= AttText nil) (= AttText ""))		;; si le texte de l'attribut est null ou contient aucun caractère
			(setq NombreDeBlocsAutre (+ NombreDeBlocsAutre 1))	;; alors rien
			(progn									;; sinon
				(setq i2 0)									
				(repeat (length ListeTermesEC)			;; boucle de recherche dans la liste de terme pour EC
					(if (= (nth i2 ListeTermesEC) AttText)
						(setq EstDansEC 1)
						)
					(setq i2 (+ i2 1))
					)
				(setq i2 0)
				(repeat (length ListeTermesEU)			;; boucle de recherche dans la liste de terme pour EU
					(if (= (nth i2 ListeTermesEU) AttText)
						(setq EstDansEU 1)
						)
					(setq i2 (+ i2 1))
					)
				(if (and (= EstDansEC 0) (= EstDansEU 0)) 	;; si le texte de l'attribut n'est ni dans la liste EC ni dans la liste EU
					(progn
						(setq TexteChoixECEU (strcat "\nLe terme """ AttText """ n'est pas défini dans les liste. De quelle liste fait-il partie? [EC/EU/Autre]"))
						(initget 1 "eC eU Autre")
						(setq choixEcEu (getkword TexteChoixECEU))
						(if (= choixEcEu "eC")
							(setq 
								EstDansEC 1
								ListeTermesEC (append (list AttText) ListeTermesEC)
								)
							)
						(if (= choixEcEu "eU")
							(setq 
								EstDansEU 1
								ListeTermesEU (append (list AttText) ListeTermesEU)
								)
							)
						(if (= choixEcEu "Autre")
							(setq NombreDeBlocsAutre (+ NombreDeBlocsAutre 1))
							)
						)
					)
				(if (= EstDansEC 1)							;; si il est dans la liste de terme EC
					(progn
						(setq lstdxf (subst (cons 8 "S+N - EC - collecteur") (assoc 8 lstdxf) lstdxf))
						(entmod lstdxf)
						(princ EntBlock)
						(setq NombreDeBlocsEC (+ NombreDeBlocsEC 1))
						;;(entmakex (list 
						;;	(cons 0 "CIRCLE")
						;;	(cons 8 "S+N - EC - Chambre")
						;;	(cons 10 PointInsertion)
						;;	(cons 40 RayonDuCercleACreer)
						;;	))
						)
					)
				(if (= EstDansEU 1)							;; si il est dans la liste de terme EU
					(progn
						(setq lstdxf (subst (cons 8 "S+N - EU - collecteur") (assoc 8 lstdxf) lstdxf))
						(entmod lstdxf)
						(princ EntBlock)
						(setq NombreDeBlocsEU (+ NombreDeBlocsEU 1))
						;;(entmakex (list 
						;;	(cons 0 "CIRCLE")
						;;	(cons 8 "S+N - EU - Chambre")
						;;	(cons 10 PointInsertion)
						;;	(cons 40 RayonDuCercleACreer)
						;;	))
						)
					)
				)
			)
		(setq i (+ i 1))
		)
	(prompt (strcat 
		"\nNombre de blocs à triées:" 
		(rtos NombreDeBlocsATrier 2 0) 
		"\nNombre de blocs triés:" 
		(rtos (+ NombreDeBlocsAutre NombreDeBlocsEC NombreDeBlocsEU) 2 0) 
		"( EC:" 
		(rtos NombreDeBlocsEC 2 0) 
		" EU:"
		(rtos NombreDeBlocsEU 2 0)
		" Autres:"
		(rtos NombreDeBlocsAutre 2 0)
		")\n"
		))
	)
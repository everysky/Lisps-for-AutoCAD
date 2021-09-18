(defun C:ktri_courbes_de_niveaux ()
;; commande qui trie des polylignes en fonction de leur élévation

	;;création des calques si non existant
	(if (= (tblsearch "LAYER" "S+N - ktri - courbes de niveaux - 100cm") nil) 
		(entmake (list
			(cons 0 "LAYER")
			(cons 100 "AcDbSymbolTableRecord")
			(cons 100 "AcDbLayerTableRecord")
			(cons 2 "S+N - ktri - courbes de niveaux - 100cm")				;; nom du calque
			(cons 70 0)
			(cons 62 7)							;; couleur du calque
			(cons 6 "CONTINUOUS")					;; type de ligne 
			))
		)
		
	(if (= (tblsearch "LAYER" "S+N - ktri - courbes de niveaux - 10cm") nil) 
		(entmake (list
			(cons 0 "LAYER")
			(cons 100 "AcDbSymbolTableRecord")
			(cons 100 "AcDbLayerTableRecord")
			(cons 2 "S+N - ktri - courbes de niveaux - 10cm")				;; nom du calque
			(cons 70 0)
			(cons 62 1)							;; couleur du calque
			(cons 6 "CONTINUOUS")					;; type de ligne 
			))
		)
	
	(if (= (tblsearch "LAYER" "S+N - ktri - courbes de niveaux - 2cm") nil) 
		(entmake (list
			(cons 0 "LAYER")
			(cons 100 "AcDbSymbolTableRecord")
			(cons 100 "AcDbLayerTableRecord")
			(cons 2 "S+N - ktri - courbes de niveaux - 2cm")				;; nom du calque
			(cons 70 0)
			(cons 62 6)							;; couleur du calque
			(cons 6 "CONTINUOUS")					;; type de ligne 
			))
		)
		
;; début du tri des objets

	;; création d'une selection d'objets
	(princ "\nSelectionnez les objets a traiter:")
	(setq
		ss (ssget)	;; creation du jeu de selection ss avec tout les objets à traiter
		i1	 0		;; compteur
		)
		
	;; test de la selection d'objet
	(if (or (= (sslength ss) 0) (= ss nil))
		(progn
		  (print "\nSelection vide -> sortie du programme")
		  (quit)
		  )
		(print "\nSelection non vide -> suite du programme")
		)
	;; création de la liste des polylignes
	(setq sspolyline (ssadd)	;; creation d'une variable qui appelle un groupe d'entité nil
		i2 0				;; compteur
		)		
	
	;; boucle de tri pour séparer les polylignes	
	(repeat (sslength ss)
		(setq ent1 (ssname ss i1))	;; définir l'entité à tester
		(setq lstdxf (entget ent1))	;; lui extraire ses données DXf pour pouvoir tester
		(setq enttype (cdr (assoc 0 lstdxf)))	;; extrait le type d'objet de l'entité
		(if (= enttype "LWPOLYLINE")
			(ssadd ent1 sspolyline)			;; si c'est une polyligne, l'entitée est ajoutée à la liste de polyligne
			)
		(setq i1 (1+ i1)) 
		)
		
		;; test de la liste
	(if (or (= (sslength sspolyline) 0) (= sspolyline nil))
		(progn
			(print "\nPas de polylignes dans la sélection -> sortie du programme")
			(quit)
			)
		(print "\nLa selection contient bien des polylignes -> suite du programme")
		)
		
	(setq total (rtos (sslength sspolyline) 2 0))
	
	;; boucle de tri pour séparer les polylignes dans les bons calques
	(repeat (sslength sspolyline)
		(setq ent2 (ssname sspolyline i2))	;; définir l'entité à trier
		(setq lstdxf (entget ent2))	;; lui extraire ses données DXf pour pouvoir la trier
		(setq entelev (cdr (assoc 38 lstdxf)))	;; extrait l'élévation de la polyligne
		(if (< (abs (- entelev (atof (rtos entelev 2 0)))) 0.01) ;;si la diférence entre l'élévation de la polylligne et son arrondi au mêtre est plus petit que 0.01 mètre
			(progn
				(setq lstdxf (subst (cons 8 "S+N - ktri - courbes de niveaux - 100cm") (assoc 8 lstdxf) lstdxf))
				(entmod lstdxf)
				)
			(if (< (abs (- entelev (atof (rtos entelev 2 1)))) 0.01) ;;si la diférence entre l'élévation de la polylligne et son arrondi à 10 cm est plus petit que 0.01 mètre
				(progn
					(setq lstdxf (subst (cons 8 "S+N - ktri - courbes de niveaux - 10cm") (assoc 8 lstdxf) lstdxf))
					(entmod lstdxf)
					)
				(progn
					(setq lstdxf (subst (cons 8 "S+N - ktri - courbes de niveaux - 2cm") (assoc 8 lstdxf) lstdxf))
					(entmod lstdxf)
					)
				)
			)
		(if (< (abs (- i2 (* (atof (rtos (/ i2 100.00) 2 0)) 100))) 1)
			(progn
				(setq textedattente (strcat "\nPolyligne " (rtos i2 2 0) "/" total))
				(print textedattente)
				)
			)
		(setq i2 (1+ i2))
		)	
	(print "\nFINI!")
	)
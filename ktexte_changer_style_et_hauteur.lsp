(defun C:ktexte_changer_style_et_hauteur ()
;; commande qui changer le style et la hauteur de textmult forcé (hauteur et police forcées)

	(setq 
		style "arial" 
		hauteur 2.58
		)

	(princ "\nSelectionnez les objets a traiter:")
	(setq
		ss (ssget)	;; creation du jeu de selection ss avec tout les objets à traiter
		i1	 0		;; compteur
		)
		
	;; test de la selection d'objet
	(if (= nil ss)
		(progn
		  (print "\nPas d'objets sélectionnés, sortie du programme")
		  (quit)
		  )
		(print "\nObjets selectionnés, suite du programme")
		)
	;; création de la liste de textmult	
	(setq ssmtext (ssadd)	;; creation d'une variable qui appelle un groupe d'entité nil
		i2 0				;; compteur
		)		
	
	;; boucle de tri pour séparer les blocs et les polylignes	
	(repeat (sslength ss)
		(setq ent (ssname ss i1))	;; définir l'entité à tester
		(setq lstdxf (entget ent))	;; lui extraire ses données DXf pour pouvoir tester
		(setq enttype (cdr (assoc 0 lstdxf)))	;; extrait le type d'objet de l'entité
		(if (= enttype "MTEXT")
			(ssadd ent ssmtext)			;; si c'est un block, l'entitée est ajoutée à la liste de block
			)
		(setq i1 (1+ i1)) 
		)

		;; test de la liste
	(if (= ssmtext nil)
		(progn
			(print "\nPas de textmult sélectionnées, sortie du programme")
			(quit)
			)
		(print "\nTextmult existants, suite du programme")
		)
	
	;; boucle pour tout les textmult
	(repeat (sslength ssmtext)
		(setq ent (ssname ss i2))	;; définir l'entité à tester
		(princ ent)
		(setq lstdxf (entget ent))	;; lui extraire ses données DXf pour pouvoir tester
		(setq entindex (cdr (assoc 1 lstdxf)))	;; extrait l'index du texte

		(setq longueur_texte (strlen entindex))											;; longueur du texte
		(if 
			(and
				(not (= (vl-string-position (ascii ";") entindex nil T) nil))
				(not (= 0 (strlen entindex)))
				(not (= nil (strlen entindex)))
				)
			(progn
				(setq position_caractère (vl-string-position (ascii ";") entindex nil T)) 		;; recherche le dernier ";" dans le texte
				(setq longueur_subtexte (- longueur_texte position_caractère 1)) 				;; longeur du texte final
				(setq texte_final (substr entindex (+ position_caractère 2) longueur_subtexte))	;; création du sous-texte
				
				(setq lstdxf (subst (cons 1 texte_final) (assoc 1 lstdxf) lstdxf))
				)
			)
	
		(setq lstdxf (subst (cons 40 hauteur) (assoc 40 lstdxf) lstdxf))
		(setq lstdxf (subst (cons 7 style) (assoc 7 lstdxf) lstdxf))
		(setq lstdxf (subst (cons 43 hauteur) (assoc 43 lstdxf) lstdxf))

		(entmod lstdxf)
		(princ ent)
		(setq i2 (1+ i2)) 
		)
	)
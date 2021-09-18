(defun C:kjag_avant_metree_polyligne ()
;; ce lisp prends une selection et trie les polilygnes étant dans le calque "S+N - tableaux déblais remblais" et ayant une couleur de 70 ou 94
;; pour leur mettre une épaisseur de 0.35 et les mettre à l'avant du tracé


	;; Ajouter une liste d'items après un item spécifique dans une liste
	(defun add-list-items-after-item-in-list (ListeItems Item ListeBase / NumeroItem LongueurListeBase Liste1 ListeFinale)
		(setq NumeroItem (vl-position Item ListeBase))
		(setq LongueurListeBase (length ListeBase))
		(setq Liste1 (reverse (repeat (+ NumeroItem 1) (setq liste1 (append (list (car ListeBase)) Liste1)) (setq ListeBase (cdr ListeBase)) Liste1)))
		(setq listeFinale (append Liste1 ListeItems Listebase))
		)

	;;vérification de l'existance du calque, sinon on quitte
	(if (= (tblsearch "LAYER" "S+N - tableaux déblais remblais") nil)
		(progn
			(print "Le calque recherché n'existe pas")
			(quit)
			)
		)
	
	;; création d'une selection d'objets
	(princ "\nSelectionnez les objets a traiter:")
	(setq
		ss (ssget '((0 . "LWPOLYLINE") (8 . "S+N - tableaux déblais remblais")))	;; creation du jeu de selection ss avec tout les objets à traiter
		i1	 0		;; compteur
		ssfinal (ssadd)
		)
		
	;; test de la selection d'objet
	(if (or (= (sslength ss) 0) (= ss nil))
		(progn
		  (print "\nSelection vide -> sortie du programme")
		  (quit)
		  )
		(print "\nSelection non vide -> suite du programme")
		)
		
	;; boucle de tri pour séparer les polylignes	
	(repeat (sslength ss)
		(setq ent1 (ssname ss i1))	;; définir l'entité à tester
		(setq lstdxf (entget ent1))	;; lui extraire ses données DXf pour pouvoir tester
		(setq entCouleur (cdr (assoc 62 lstdxf)))	;; extrait la couleur de l'entité
		(if (or (= entCouleur 70) (= entCouleur 94))
			(progn
				(setq lstdxf (add-list-items-after-item-in-list (list (cons 370 35)) (assoc 62 lstdxf) lstdxf))
				(entmod lstdxf)
				(ssadd ent1 ssfinal)
				)
			)
		(setq i1 (+ i1 1))
		)
	
	;; mettre les objets du groupe final au premier plan
	(command "ordretrace" ssfinal "" "avant")
	)
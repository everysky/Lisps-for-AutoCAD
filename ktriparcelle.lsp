;;ktriparcelle
(defun C:ktriparcelle () ;;/ ss i ssblock sspolyline sspolylinefinal ent enttype lstdxf entfermée

	(princ "\nSelectionnez les objets a traiter:")
	(setq
		ss (ssget)	;; creation du jeu de selection ss avec tout les objets à traiter
		i	 0		;; compteur
		)
		
	;; test de la selection d'objet
	(if (= nil ss)
		(progn
		  (print "\nPas d'objets sélectionnés, sortie du programme")
		  (quit)
		  )
		(print "\nObjets selectionnés, suite du programme")
		)
		
	;; création des deux listes (blocs et polylignes)
	(setq ssblock (ssadd))		;; creation d'une variable qui appelle un groupe d'entité nil
	(setq sspolyline (ssadd))	;; creation d'une variable qui appelle un groupe d'entité nil
	
	;; boucle de tri pour séparer les blocs et les polylignes	
	(repeat (sslength ss)
		(setq ent (ssname ss i))	;; définir l'entité à tester
		(setq lstdxf (entget ent))	;; lui extraire ses données DXf pour pouvoir tester
		(setq enttype (cdr (assoc 0 lstdxf)))	;; extrait le type d'objet de l'entité
		(cond
			((= enttype "INSERT") (ssadd ent ssblock))			;; si c'est un block, l'entitée est ajoutée à la liste de block
			((= enttype "LWPOLYLINE") (ssadd ent sspolyline))	;; si c'est une polyligne, l'entitée est ajoutée à la liste de polylignes
			)
		(setq i (1+ i)) 
		)
	
	;; test des deux listes
	(if (= ssblock nil)
		(progn
			(print "\nPas de blocks sélectionnées, sortie du programme")
			(quit)
			)
		(print "\nBlocs existants, suite du programme")
		)
	(if (= sspolyline nil)
		(progn
			(print "\nPas de polyligne sélectionnées, sortie du programme")
			(quit)
			)
		(print "\nPolylignes existantes, suite du programme")
		)
	
	;; tri des polylignes (seulement les poylignes fermées)
	(setq i 0)
	(setq sspolylinefinal (ssadd))
	(repeat (sslength sspolyline)			;; ouverture de la boucle de tri
		(setq ent (ssname sspolyline i))	;; définir l'entité à tester
		(setq lstdxf (entget ent))			;; lui extraire ses données DXf pour pouvoir tester
		(setq entfermée (cdr (assoc 70 lstdxf)))	;; extrait l'info voulue (si la polyligne est fermée ou pas)
		(cond
			((or (= entfermée 1) (= entfermée 129)) (ssadd ent sspolylinefinal))	;; si polyligne est fermée, alors ajouter à la liste finale
			)
		(setq i (1+ i))
		)
	
	;; test de la liste créée
	(if (= sspolylinefinal nil)
		(progn
			(print "\nPas de polyligne férmée, sortie du programme")
			(quit)
			)
		(print "\nPolylignes fermées existantes, suite du programmme")
		)
		
	;; tri des blocs (seulement "CAD_PARCELLAIRE")
	(setq i 0)
	(setq ssblockfinal (ssadd))
	(repeat (sslength ssblock)
		(setq ent (ssname ssblock i))
		(setq lstdxf (entget ent))
		(setq entnom (cdr (assoc 2 lstdxf)))
		(cond
			((= entnom "CAD_PARCELLAIRE") (ssadd ent ssblockfinal))
			)
		(setq i (1+ i))
		)
	
	;; test de la liste créée
	(if (= ssblockfinal nil)
		(progn
			(print "\nPas de blocs avec le bon nom, sortie du programme")
			(quit)
			)
		(print "\nBlocs avec le bon nom existants, suite du programmme")
		)

	)
	
	
;; aller chercher tout les infos d'un attribut d'un bloc
;; ATTENTION l'attribut doit exister dans le bloc sinon boucle infini jusqu'au prochain bloc contenant l'attribut
(defun getattribut (entity  nameattribut / valeurs dxf)
	(While (= valeurs nil)									;; tant qu'il y a rien dans la liste de retour (donc attribut pas trouvé)
		(setq entity (entnext entity))						;; il va chercher le nom de la prochaine entité
		(setq dxf (entget entity))							;; il en extrait la liste dxf des informations
		(if													;; si les conditions suivantes sont remplies
			(and 
				(= (cdr (assoc 0 dxf)) "ATTRIB")			;; l'entité est un attribut
				(= (cdr (assoc 2 dxf)) nameattribut)		;; le nom de l'attribut est celui recherché
				)
			(setq valeurs dxf)								;; alors: la liste de retour est égal à la liste d'infos de cette entité
			)
		)
		valeurs												;; valeur de retour (sinon la fonction ne retourne rien)
	)
	
	
;; definition de la fonction de centre d'une polyligne http://cadxp.com/topic/16333-centre-de-gravite/page__p__85671#entry85671
	(defun vl-pline-centroid (pl / AcDoc Space obj reg cen)
		(vl-load-com)
		(setq
			AcDoc (vla-get-ActiveDocument (vlax-get-acad-object))
			Space (if (= (getvar "CVPORT") 1) (vla-get-PaperSpace AcDoc) (vla-get-ModelSpace AcDoc))
			)
		(or (= (type pl) 'VLA-OBJECT) (setq obj (vlax-ename->vla-object pl)))
		(setq 
			reg (vlax-invoke Space 'addRegion (list obj))
			cen (vlax-get (car reg) 'Centroid)
			)
		(vla-delete (car reg))
		(trans cen 1 (vlax-get obj 'Normal))
		)
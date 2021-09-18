(defun C:kbordure_geometrie ()
	(defun aucarre (asdf) (* asdf asdf))
	(setq 
		HauteurTexte 0.6
		style (getvar "textstyle")
		distanceTextes 3.38
		)
	(if (= (tblsearch "LAYER" "Points") nil) 							;; calque TableauTexteCalque
		(progn
			(print "\nLe calque \"Points\" n'existe pas. \nLes objets qui devaient être créer dans ce calque seront mis dans le calque \"0\". ")
			(setq TableauTexteCalque "0")
			)
		(setq TableauTexteCalque "Points")
		)
	(while 
		(/= (setq Point1 (getpoint "\nChoisissez le point de DEBUT de la géométie ou ENTER pour mettre fin à la commande: ")) nil)
		(initget 1)
		(setq Point2 (getpoint "\nChoisissez le point de FIN de la géométie: "))
		(initget "Droite")
		(setq Point3 (getpoint "\nChoisissez un troisième point sur la géométrie si c'est un arc de cercle ou [Droite] <Droite>: "))
		(if
			(= (type Point3) 'LIST) 								;; condition
			(progn													;; si oui
				(setq 
					dx12 (- (car Point2) (car Point1))
					dy12 (- (cadr Point2) (cadr Point1))
					dx13 (- (car Point3) (car Point1))
					dy13 (- (cadr Point3) (cadr Point1))
					)												
				(if	
					(= (/ dx13 dx12) (/ dy13 dy12))							;; condition
					(setq 													;; si oui
						TexteRayon "Droite"
						TexteFleche "0"
						)													;; fin de si oui
					(progn													;; si non
						(setq a (command "_.circle" "_3P" Point1 Point2 Point3))
						(setq 
							ent (entlast)
							lstdxf (entget ent)
							)
						(entdel ent)
						(setq
							centre (cdr (assoc 10 lstdxf))
							rayon (cdr (assoc 40 lstdxf))
							AngleDebut (atan (- (cadr Point1) (cadr centre)) (- (car Point1) (car centre)))
							AngleFin (atan (- (cadr Point2) (cadr centre)) (- (car Point2) (car centre)))
							PointMilieuArc (polar centre (/ (+ AngleDebut AngleFin) 2.0) rayon)
							PointMilieuCorde (list (/ (+ (car Point1) (car Point2)) 2.0) (/ (+ (cadr Point1) (cadr Point2)) 2.0) 0.0)
							fleche (- rayon (sqrt (+ (aucarre (- (car PointMilieuCorde) (car centre))) (aucarre (- (cadr PointMilieuCorde) (cadr centre))))))
							LongueurArc (/ (* (abs (- AngleDebut AngleFin)) (* 2 pi rayon)) (* 2 pi))
							TexteRayon (rtos rayon 2 2)
							TexteFleche (rtos fleche 2 2)
							)
						)													;; fin de si non
					)
				)													;; fin de si oui
			(if														;; si non
				(or															;; condition
					(= Point3 nil)
					(= Point3 "Droite")
					)
				(setq 														;; si oui
					TexteRayon "Droite"
					TexteFleche "0"
					)														;; fin de si oui
				(progn														;; si non
					(alert "Ce n'est pas un point.")
					(quit)
					)														;; fin de si non
				)													;; fin de si non
			)			
		(initget 1)
		(setq PointTexteRayon (getpoint "\nChoisissez le point d'insertion du texte de rayon dans le tableau: "))
		(entmakex 
			(list 
				(cons 0 "MTEXT")
				(cons 8 TableauTexteCalque)
				(cons 100 "AcDbEntity")
				(cons 100 "AcDbMText")
				(cons 10 PointTexteRayon)
				(cons 40 HauteurTexte)
				(cons 41 2.0)
				(cons 71 5)
				(cons 1 TexteRayon)
				(cons 7 style)
				;; (cons 50 angle)
				)
			)
		(setq PointTexteFleche (list (+ (car PointTexteRayon) distanceTextes) (cadr PointTexteRayon) 0.0))
		(entmakex 
			(list 
				(cons 0 "MTEXT")
				(cons 8 TableauTexteCalque)
				(cons 100 "AcDbEntity")
				(cons 100 "AcDbMText")
				(cons 10 PointTexteFleche)
				(cons 40 HauteurTexte)
				(cons 41 2.0)
				(cons 71 5)
				(cons 1 TexteFleche)
				(cons 7 style)
				;; (cons 50 angle)
				)
			)
		)
	)
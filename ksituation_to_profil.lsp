;; récupérer la distance par rapport à l'axe et l'altitude des bords de chaussée, à chaque profil, en situation.
;; et en faire une liste transferable.

(defun C:ksituation_to_profil ()

	(defun au_carre (x) (* x x))
	
	(while (setq PointAxe (getpoint "\nSéléctionner le point à l'intersection de l'axe et du profil ou [Enter] pour finir: "))
		(setq os (getvar "osmode"))
		;;(setvar "osmode" 512)
		
		(setq PointGauche (getpoint "\nSéléctionner le point gauche du bord de chaussée: "))
		(setq PointDroite (getpoint "\nSéléctionner le point droite du bord de chaussée: "))
		
		;;(setvar "osmode" os)
		
		(setq DistGauche (sqrt (+ (au_carre (- (car PointAxe) (car PointGauche))) (au_carre (- (cadr PointAxe) (cadr PointGauche))))))
		(setq AltitudeGauche (caddr PointGauche))
		(setq DistDroite (sqrt (+ (au_carre (- (car PointAxe) (car PointDroite))) (au_carre (- (cadr PointAxe) (cadr PointDroite))))))
		(setq AltitudeDroite (caddr PointDroite))
	
		(setq profil (list DistGauche AltitudeGauche DistDroite AltitudeDroite))
		(setq ktransfert (append ktransfert (list profil)))
		)
	)
	
	
	
	
(defun C:kprofil_from_situation ()
	(setq ListeATrier ktransfert)
	(while (> (length ListeATrier) 0)
		(setq profil (car ListeATrier))
		(setq PointAxe (getpoint "\nSelectionner un point sur l'axe du profil; "))
		(setq PointGauche (list (- (car PointAxe) (car profil)) (cadr profil) 0.0)) ;; calcul du point d'insertion de la bordure gauche
		(setq PointDroite (list (+ (car PointAxe) (caddr profil)) (last profil) 0.0)) ;; calcul du point d'insertion de la bordure droite
		(entmakex	;; Bordure gauche
			(list
				(cons 0 "INSERT")
				(cons 100 "AcDbEntity")
				(cons 8 "09 - TN")					;; calque
				(cons 100 "AcDbBlockReference")
				(cons 2 "Bordure_Type 20X24")		;; nom du bloc
				(cons 10 PointGauche)				;; point d'insertion
				(cons 41 1.0)						;; echelle x
				(cons 42 1.0)						;; echelle y
				(cons 43 1.0)						;; echelle Z				
				(cons 70 0)							;; rotation
				)
			)
		(entmakex	;; Bordure droite
			(list
				(cons 0 "INSERT")
				(cons 100 "AcDbEntity")
				(cons 8 "09 - TN")					;; calque
				(cons 100 "AcDbBlockReference")
				(cons 2 "Bordure_Type 20X24")		;; nom du bloc
				(cons 10 Pointdroite)				;; point d'insertion
				(cons 41 -1.0)						;; echelle x
				(cons 42 1.0)						;; echelle y
				(cons 43 1.0)						;; echelle Z
				(cons 70 0)							;; rotation
				)
			)
		(setq ListeATrier (cdr ListeATrier))
		)
	(princ "fini!!!!!!")	
	)

(defun C:ksynoptique_from_situation ()

;; mise à zéro des variables (listes, point, etc)
	(setq ListePointGauche nil)
	(setq ListePointDroite nil)
	(setq PointDepart nil)
	(setq ListeATrier nil)
	
;; création des variables de base et de leurs valeurs
	(setq ListeATrier ktransfert)
	(setq PointDepart (getpoint "\nSelectionner le point de départ; "))
	(setq NoProfil 0)
	(setq Facteur 100.0)
	
	(while (> (length ListeATrier) 0)
		(setq Profil (car ListeATrier))
		(setq PointGauche (list (+ (car PointDepart) (* 25 NoProfil)) (+ (cadr PointDepart) (* (car Profil) Facteur)) 0.0))
		(setq PointDroite (list (+ (car PointDepart) (* 25 NoProfil)) (- (cadr PointDepart) (* (caddr Profil) Facteur)) 0.0))
		
		(setq PointGaucheFinal (list (cons 10 PointGauche)))
		(setq ListePointGauche (append ListePointGauche PointGaucheFinal))
		
		(setq PointDroiteFinal (list (cons 10 PointDroite)))
		(setq ListePointDroite (append ListePointDroite PointDroiteFinal))
		
		(setq NoProfil (+ NoProfil 1))
		(setq ListeATrier (cdr ListeATrier))
		)
		
	(entmakex 
		(append 
			(list 
				(cons 0 "LWPOLYLINE")
				(cons 100 "AcDbEntity")
				(cons 8 "0")
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
				(cons 8 "0")
				(cons 100 "AcDbPolyline")
				(cons 90 (length ListePointDroite))
				(cons 70 0)
				)
			ListePointDroite
			)
		)
	)
	
	

;; bords de chaussées CSD d'après la situation
(setq ktransfert '((20.0 0.0 20.0 0.0) 
(20.0 0.0 20.0 0.0) (4.54327 0.0 4.95078 0.0) (4.55134 0.0 4.44867 0.0) 
(4.52574 0.0 4.47435 0.0) (4.53453 0.0 4.46548 0.0) (4.5767 0.0 4.42346 0.0) 
(4.49998 0.0 4.50015 0.0) (4.47726 0.0 4.52283 0.0) (4.48581 0.0 4.51423 0.0) 
(4.53548 0.0 4.46452 0.0) (4.51294 0.0 4.49038 0.0) (4.48862 0.0 4.49169 0.0) 
(4.70095 0.0 4.29525 0.0) (9.76299 0.0 9.08376 0.0) (8.44679 0.0 9.01031 0.0) 
(4.51428 0.0 4.5695 0.0) (4.52537 0.0 4.47463 0.0) (4.50339 0.0 4.49661 0.0) 
(4.52449 0.0 4.47552 0.0) (4.49725 0.0 4.50293 0.0) (4.49704 0.0 4.50313 0.0) 
(4.52496 0.0 4.47504 0.0) (4.5262 0.0 4.4738 0.0) (4.52743 0.0 4.47257 0.0) 
(4.52867 0.0 4.47133 0.0) (4.53032 0.0 4.47009 0.0) (4.53115 0.0 4.46885 0.0) 
(4.53239 0.0 4.46761 0.0) (4.51957 0.0 4.44551 0.0) (4.52081 0.0 4.33994 0.0) 
(4.52204 0.0 4.26393 0.0) (4.52328 0.0 4.77411 0.0) (4.71786 0.0 6.27712 0.0) 
(14.5791 0.0 15.8541 0.0) (5.1087 0.0 5.63478 0.0) (4.48125 0.0 5.27111 0.0) 
(4.63297 0.0 5.19469 0.0) (4.93611 0.0 4.86535 0.0) (5.59405 0.0 4.74165 0.0) 
(7.47584 0.0 4.70304 0.0) (7.84513 0.0 4.66442 0.0) (9.67777 0.0 4.62581 0.0) 
(7.75698 0.0 4.5872 0.0) (4.71529 0.0 4.54859 0.0) (4.46385 0.0 4.53615 0.0) 
(4.46558 0.0 4.53441 0.0) (4.47749 0.0 4.52251 0.0) (4.4894 0.0 4.5106 0.0) 
(4.49983 0.0 4.50017 0.0) (4.50138 0.0 4.49862 0.0) (4.50293 0.0 4.49707 0.0) 
(4.49776 0.0 4.50207 0.0) (4.46502 0.0 4.53498 0.0) (4.54652 0.0 4.45367 0.0) 
(4.78293 0.0 4.21773 0.0) (5.16484 0.0 6.96557 0.0) (5.57141 0.0 8.10734 0.0) 
(5.936 0.0 9.51263 0.0) (6.16334 0.0 8.01671 0.0) (6.27836 0.0 8.32404 0.0) 
(6.37775 0.0 8.51662 0.0) (6.29715 0.0 8.5881 0.0) (5.75619 0.0 9.02832 0.0) 
(6.10696 0.0 10.1802 0.0)))	



(defun C:kprofil_to_synoptique ()
	(while (setq PointAxe (getpoint "\nSéléctionner un point sur l'axe ou [Enter] pour finir: "))
		;;(setq os (getvar "osmode"))
		;;(setvar "osmode" 512)
		
		(setq PointGauche (getpoint "\nSéléctionner le point gauche du bord de chaussée: "))
		(setq PointDroite (getpoint "\nSéléctionner le point droite du bord de chaussée: "))
		
		;;(setvar "osmode" os)
		
		(setq DistGauche (abs (- (car PointAxe) (car PointGauche))))
		(setq AltitudeGauche (cadr PointGauche))
		(setq DistDroite (abs (- (car PointAxe) (car PointDroite))))
		(setq AltitudeDroite (cadr PointDroite))
	
		(setq profil (list DistGauche AltitudeGauche DistDroite AltitudeDroite))
		(setq ktransfert (append ktransfert (list profil)))
		)
	)
	
(defun C:ktrait_situation_to_synoptique ()

	(defun au_carre (x) (* x x))
	
	(while (setq PointAxe (getpoint "\nSéléctionner un point sur l'axe de référence ou [Enter] pour finir: "))
		(setq PointTrait (getpoint "\nSéléctionner un point le trait: "))
		(setq Agauche (< (car PointTrait) (car PointAxe)))
		(if (= Agauche T) 
			(setq DistTrait (sqrt (+ (au_carre (- (car PointAxe) (car PointTrait))) (au_carre (- (cadr PointAxe) (cadr PointTrait))))))
			(setq DistTrait (* -1 (sqrt (+ (au_carre (- (car PointAxe) (car PointTrait))) (au_carre (- (cadr PointAxe) (cadr PointTrait)))))))
			)
		(setq profil (list DistTrait 0.0 0.0 0.0))
		(setq ktransfert (append ktransfert (list profil)))
		)
	)
	
	
((1.14401 0.0 0.0 0.0) 
(0.00465404 0.0 0.0 0.0) 
(0.0256981 0.0 0.0 0.0) 
(0.0345252 0.0 0.0 0.0) 
(0.0766181 0.0 0.0 0.0) 
(8.15593e-05 0.0 0.0 0.0) 
(0.0227838 0.0 0.0 0.0) 
(0.0142115 0.0 0.0 0.0) 
(0.0346615 0.0 0.0 0.0) 
(0.00968281 0.0 0.0 0.0) 
(0.00831134 0.0 0.0 0.0) 
(0.205201 0.0 0.0 0.0))


(defun C:ksituation-m1_to_profil ()

	(defun au_carre (x) (* x x))
	
	(while (setq PointM1 (getpoint "\nSéléctionner le point à l'intersection de l'axe du M1 et du profil ou [Enter] pour finir: "))
		(setq os (getvar "osmode"))																;; stocker l'accroche objet utilisateur
		(setvar "osmode" 512)																	;; accroche objet "proche"
		(setq PointGauche (getpoint "\nSéléctionner le point gauche du bord de chaussée: "))	;; prendre le point bord de chaussée gauche
		(setvar "osmode" os)																	;; rétablir l'accroche objet utilisateur
		(setq PointAxe (getpoint "\nSéléctionner le point à l'axe de la chaussée: "))			;; prendre le point à l'axe
		(setvar "osmode" 512)																	;; accroche objet "proche"
		(setq PointDroite (getpoint "\nSéléctionner le point droite du bord de chaussée: "))	;; prendre le point bord de chaussée droite
		(setvar "osmode" os)																	;; rétablir l'accroche objet utilisateur
		
		(setq DistGauche (sqrt (+ (au_carre (- (car PointM1) (car PointGauche))) (au_carre (- (cadr PointM1) (cadr PointGauche))))))
		(setq AltitudeGauche (caddr PointGauche))
		(setq DistAxe (sqrt (+ (au_carre (- (car PointM1) (car PointAxe))) (au_carre (- (cadr PointM1) (cadr PointAxe))))))
		(setq DistDroite (sqrt (+ (au_carre (- (car PointM1) (car PointDroite))) (au_carre (- (cadr PointM1) (cadr PointDroite))))))
		(setq AltitudeDroite (caddr PointDroite))
	
		(setq profil (list DistGauche AltitudeGauche DistAxe DistDroite AltitudeDroite))
		(setq ktransfert (append ktransfert (list profil)))
		)
	)
	
	
(defun C:kprofil_from_situation-m1 ()
	(setq Decalage 5.0)
	(setq ListeATrier ktransfert)
	(while (> (length ListeATrier) 0)
		(setq profil (car ListeATrier))
		(setq PointM1 (getpoint "\nSelectionner un point sur l'axe du profil; "))
		
		(setq PointGauche (list (- (car PointM1) (nth 0 profil)) (nth 1 profil) 0.0)) ;; calcul du point d'insertion de la bordure gauche
		(setq PointGaucheHaut (list (- (car PointM1) (nth 0 profil)) (+ (nth 1 profil) Decalage) 0.0))
		(setq PointGaucheBas (list (- (car PointM1) (nth 0 profil)) (- (nth 1 profil) Decalage) 0.0))
		
		(setq PointAxe (list (- (car PointM1) (nth 2 profil)) (/ (+ (nth 1 profil) (nth 4 profil)) 2.00) 0.0))	;; calcul du point de l'axe
		(setq PointAxeHaut (list (- (car PointM1) (nth 2 profil)) (+ (/ (+ (nth 1 profil) (nth 4 profil)) 2.00) Decalage) 0.0))
		(setq PointAxeBas (list (- (car PointM1) (nth 2 profil)) (- (/ (+ (nth 1 profil) (nth 4 profil)) 2.00) Decalage) 0.0))
		
		(setq PointDroite (list (- (car PointM1) (nth 3 profil)) (nth 4 profil) 0.0)) ;; calcul du point d'insertion de la bordure droite
		(setq PointDroiteHaut (list (- (car PointM1) (nth 3 profil)) (+ (nth 4 profil) Decalage) 0.0))
		(setq PointDroiteBas (list (- (car PointM1) (nth 3 profil)) (- (nth 4 profil) Decalage) 0.0))
		
		(entmakex	;; ligne bord gauche
			(list
				(cons 0 "LWPOLYLINE")
				(cons 100 "AcDbEntity")
				(cons 8 "0")
				(cons 100 "AcDbPolyline")
				(cons 90 3)					
				(cons 70 0)
				(cons 10 PointGaucheBas)
				(cons 10 PointGauche)
				(cons 10 PointGaucheHaut)
				)
			)
		(entmakex	;; Bordure gauche
			(list
				(cons 0 "INSERT")
				(cons 100 "AcDbEntity")
				(cons 8 "0")						;; calque
				(cons 100 "AcDbBlockReference")
				(cons 2 "Bordure_Type 20X24")		;; nom du bloc
				(cons 10 PointGauche)				;; point d'insertion
				(cons 41 1.0)						;; echelle x
				(cons 42 1.0)						;; echelle y
				(cons 43 1.0)						;; echelle Z				
				(cons 70 0)							;; rotation
				)
			)
		(entmakex	;; ligne axe
			(list
				(cons 0 "LWPOLYLINE")
				(cons 100 "AcDbEntity")
				(cons 8 "0")
				(cons 100 "AcDbPolyline")
				(cons 90 2)					
				(cons 70 0)
				(cons 10 PointAxeBas)
				(cons 10 PointAxeHaut)
				)
			)
		(entmakex	;; ligne bord droite
			(list
				(cons 0 "LWPOLYLINE")
				(cons 100 "AcDbEntity")
				(cons 8 "0")
				(cons 100 "AcDbPolyline")
				(cons 90 3)					
				(cons 70 0)
				(cons 10 PointDroiteBas)
				(cons 10 PointDroite)
				(cons 10 PointDroiteHaut)
				)
			)
		(entmakex	;; Bordure droite
			(list
				(cons 0 "INSERT")
				(cons 100 "AcDbEntity")
				(cons 8 "0")						;; calque
				(cons 100 "AcDbBlockReference")
				(cons 2 "Bordure_Type 20X24")		;; nom du bloc
				(cons 10 Pointdroite)				;; point d'insertion
				(cons 41 -1.0)						;; echelle x
				(cons 42 1.0)						;; echelle y
				(cons 43 1.0)						;; echelle Z
				(cons 70 0)							;; rotation
				)
			)
		(setq ListeATrier (cdr ListeATrier))
		)
	(princ "fini!!!!!!")	
	)
	
(defun C:ksituation_to_any ()
	(setq os (getvar "osmode"))																;; stocker l'accroche objet utilisateur
	(setvar "osmode" (+ os 512))															;; ajouter "proche" à l'accroche objet
	(defun au_carre (x) (* x x))
	(if (= ktransfert nil)
		(setq ktransfert (list "ksituation_to_any"))
		)
	
	(while (setq PointAxe (getpoint "\nSéléctionner un point sur l'axe de référence ou [Enter] pour finir: "))
		(setq profil nil)																	;; réinitialiser la liste des points entre chaque profil
		(while (setq Point (getpoint "\nSéléctionner des points ou [enter] pour passer au profil suivant: "))
			(setq AGauche (< (car Point) (car PointAxe)))
			(setq DistPoint (sqrt (+ (au_carre (- (car PointAxe) (car Point))) (au_carre (- (cadr PointAxe) (cadr Point))))))
			(if (= AGauche T)
				(setq DistPoint (* DistPoint -1))
				)
			(setq Altitude (caddr Point))
			(setq PointTransfert (list DistPoint Altitude))
			(setq profil (append profil (list PointTransfert)))
			)
		(setq ktransfert (append ktransfert (list profil)))
		)
	(setvar "osmode" os)
	(princ ktransfert)
	)


	
(defun C:kprofil_from_any ()
	(entmake (list
      (cons 0 "LAYER")
      (cons 100 "AcDbSymbolTableRecord")
      (cons 100 "AcDbLayerTableRecord")
      (cons 2 "S+N - klisp")				;; nom du calque
      (cons 70 0)
      (cons 62 25)							;; couleur du calque
      (cons 6 "Continuous")					;; type de ligne 
      )
    )
	(setq ListeATrier ktransfert)
	(if (= (car ListeATrier) "ksituation_to_any")
		(progn
			(setq ListeATrier (cdr ktransfert))		;; enlever le "ksituation_to_any"
			(while (> (length ListeATrier) 0)		;; tant que la liste n'est pas vide, faire ↓
			
				(setq ListePointsPolyligne nil)							;; réinitialier la liste de point de la polyligne
				(setq PointAxeProfil (getpoint "\nSelectionner un point sur l'axe du profil; "))		;; séléctionner le point par rapport auquel tout vas s'inserer
				(setq ListePointsProfil (car ListeATrier))				;; extraire la liste des points de CE profil
				(setq AltitudeMin (cadar ListePointsProfil))			;; deteriminer une altitude min pour comparaison futur
				(setq AltitudeMax (cadar ListePointsProfil))			;; deteriminer une altitude max pour comparaison futur
				(while (> (length ListePointsProfil) 0)					;; tant qu'il y a des points dans CE profil, faire ↓
				
					(setq PointProfil (car ListePointsProfil))		;; prendre le premier point de la liste de point de CE profil
					(setq PointPolyligne (list 							;; Créer le point au bonnes coordonnées
						(+ (car PointAxeProfil) (car PointProfil))		;; coordonnée X
						(cadr PointProfil)								;; coordonnée Y
						0.0												;; coordonnée Z
						))
					(setq PointPolyligneFinal (list (cons 10 PointPolyligne)))	;; transformer le point pour "ENTMAKEX"
					(setq ListePointsPolyligne (append ListePointsPolyligne PointPolyligneFinal))	;; Ajouter le point à la liste de points de la futur Polyligne du profil
					(if (< (cadr PointProfil) AltitudeMin)		;; Si l'altitude du point est plus petite que l'altitude min ↓
						(setq AltitudeMin (cadr PointProfil))	;; remplacer
						)
					(if (> (cadr PointProfil) AltitudeMax)		;; Si l'altitude du point est plus grande que l'altitude max ↓
						(setq AltitudeMax (cadr PointProfil))	;; remplacer
						)
					(setq ListePointsProfil (cdr ListePointsProfil))	;;supprimer le point courant de la liste de points
					)
				(setq PointAxe1 (list (car PointAxeProfil) AltitudeMin 0.0))
				(setq PointAxe1Final (list (cons 10 PointAxe1)))
				(setq PointAxe2 (list (car PointAxeProfil) AltitudeMax 0.0))
				(setq PointAxe2Final (list (cons 10 PointAxe2)))
				(setq ListePointsAxe (append PointAxe1Final PointAxe2Final))
				(entmakex 
					(append 
						(list 
							(cons 0 "LWPOLYLINE")
							(cons 100 "AcDbEntity")
							(cons 8 "S+N - klisp")
							(cons 100 "AcDbPolyline")
							(cons 90 (length ListePointsPolyligne))
							(cons 70 0)
							)
						ListePointsPolyligne
						)
					)
				(entmakex 
					(append 
						(list 
							(cons 0 "LWPOLYLINE")
							(cons 100 "AcDbEntity")
							(cons 8 "S+N - klisp")
							(cons 100 "AcDbPolyline")
							(cons 90 (length ListePointsAxe))
							(cons 70 0)
							)
						ListePointsAxe
						)
					)
				(setq ListeATrier (cdr ListeATrier))
				)
			)
		)
;;	(if (= (car ListeATrier) "ksituation_reseau_to_any")
;;		(progn
;;			(setq ProfondeurEC 1.50)
;;			(setq ProfondeurEU 1.50)
;;			(setq ProfondeurGAZ 1.20)
;;			(setq ProfondeurSWISS 1.80)
;;			(setq ProfondeurEAU 1.20)
;;			(setq ProfondeurELEC 1.80)
			
;;			)
;;		)
	)

;; km 0.00 à km 0.500	
("ksituation_to_any" 
((-4.53867 396.777) (-4.48867 396.684) (7.10552 396.32)) 
((-5.53428 397.467) (-5.47428 397.389) (8.4346 397.046) (8.50962 397.175)) 
((-7.14478 399.379) (-6.95575 398.317) (-4.59114 398.221) (-4.54256 398.058) (5.09075 397.738)) 
((-7.28724 399.938) (-7.10099 398.831) (-4.61958 398.75) (-4.57324 398.581) (4.34291 398.339)) 
((-8.19842 400.532) (-8.17845 399.975) (-4.63097 399.246) (-4.58694 399.086) (4.49102 398.802)) 
((-4.59985 399.653) (-4.55347 399.528) (5.33365 399.228)) 
((-4.62824 400.058) (-4.58045 399.955) (5.43813 399.622)) 
((-4.58316 400.362) (-4.53316 400.282) (5.13285 400.032)) 
((-4.51815 400.652) (-4.46417 400.529) (4.55332 400.334)) 
((-4.55102 400.869) (-4.50154 400.77) (4.2901 400.545)) 
((-4.58629 401.051) (-4.53839 400.934) (4.36131 400.723)) 
((-4.60488 401.187) (-4.55623 401.035) (7.13868 400.76) (7.24656 400.882)) 
((-4.61443 401.269) (-4.57608 401.142) (8.70794 400.749) (8.80796 400.87)) 
((-4.61088 401.287) (-4.56088 401.197) (8.79558 400.765) (8.89701 400.896)) 
((-4.5931 401.254) (-4.5431 401.145) (6.0526 400.874) (6.15277 400.979) (7.347 400.977) (7.47994 400.84) (14.4788 400.59) (14.6332 400.727)) 
((-4.5697 401.184) (-4.51724 401.074) (9.15111 400.759) (9.27862 400.861)) 
((-4.58246 401.061) (-4.55246 400.933) (5.46087 400.692) (5.56087 400.827)) 
((-4.56361 400.88) (-4.53383 400.772) (5.48645 400.546) (5.58645 400.674)) 
((-4.50948 400.663) (-4.47981 400.524) (5.19982 400.249) (5.29985 400.411)) 
((-4.61976 400.355) (-4.58963 400.218) (4.48461 399.982) (4.57992 400.101)) 
((-4.57274 400.044) (-4.54292 399.884) (4.3884 399.676))
)

;; km 0.525 au km 0.775
("ksituation_to_any" ((-6.29697 399.78) (-4.57705 399.713) (-4.54731 399.575) (4.28312 399.374) (13.4152 396.249) (18.222 396.121)) 
((-6.4048 399.471) (-4.5881 399.404) (-4.56073 399.284) (4.29809 399.094) (13.2257 396.077) (18.1386 395.945)) 
((-6.22628 399.11) (-4.59692 399.07) (-4.56249 398.954) (4.21467 398.737) (12.9855 396.004) (18.1329 395.83)) 
((-6.22711 398.833) (-4.59923 398.75) (-4.56248 398.636) (4.33072 398.513) (13.158 396.0) (18.0377 395.851)) 
((-6.22039 398.501) (-4.61002 398.476) (-4.57452 398.359) (4.3423 398.301) (12.8088 396.046) (18.0197 395.837)) 
((-6.10111 398.307) (-4.58081 398.249) (-4.55097 398.13) (4.40657 398.108) (13.0313 396.054) (17.9486 395.877)) 
((-19.4823 398.694) (-14.5982 398.769) (-6.14258 398.117) (-4.60347 398.073) (-4.57099 397.98) (4.28079 397.948) (13.4362 396.038) (17.8313 395.884)) 
((-13.1535 398.414) (-6.15 397.953) (-4.60749 397.925) (-4.57757 397.824) (4.28213 397.806) (13.3153 396.055) (17.7502 395.881)) 
((-18.8666 0.0) (-14.784 398.128) (-6.23327 397.851) (-4.58537 397.817) (-4.55323 397.72) (4.24499 397.67) (13.2629 396.018) (17.6821 395.819) (17.698 395.666)) 
((-19.1877 398.067) (-15.2252 397.914) (-6.14589 397.745) (-4.594 397.71) (-4.56817 397.616) (4.30249 397.607) (13.0967 395.495) (17.671 395.343) (17.6719 395.33)) 
((-13.9067 397.856) (-6.01126 397.642) (-4.57461 397.639) (-4.54461 397.54) (4.43133 397.519) (4.53602 397.639) (18.0766 394.625)) 
((-5.97029 397.623) (-4.57254 397.592) (-4.54211 397.493) (7.33974 397.421) (7.43975 397.554)))

;; km 0.800 au km 1.175
("ksituation_to_any" 
((-6.10023 397.612) (-4.58733 397.579) (-4.54606 397.49) (8.47695 397.395) (8.57711 397.54)) 
((-6.14286 397.614) (-4.58265 397.619) (-4.55265 397.497)) 
((-6.03787 397.634) (-4.56836 397.626) (-4.53711 397.518) (6.4092 397.409) (6.51991 397.553)) 
((-6.05719 397.676) (-4.54391 397.675) (-4.51227 397.56) (5.37215 397.463) (5.47215 397.595)) 
((-6.13464 397.725) (-4.56068 397.705) (-4.53269 397.594) (5.30595 397.524) (5.40517 397.648)) 
((-6.17483 397.786) (-4.54867 397.772) (-4.52079 397.653) (4.97132 397.581) (5.07133 397.708)) 
((-6.33522 397.851) (-4.54148 397.841) (-4.51148 397.722) (4.49534 397.698) (4.59534 397.814)) 
((-6.16788 397.907) (-4.54912 397.885) (-4.51585 397.775) (4.47186 397.795) (4.57157 397.897)) 
((-6.09556 397.982) (-4.54279 397.937) (-4.50621 397.851) (4.49891 397.843) (4.59859 397.947)) 
((-9.39803 398.12) (-7.55093 398.054) (-7.51439 397.981) (4.49147 397.92) (4.53012 398.41) (4.79238 398.402) (4.82238 397.845)) 
((-13.529 396.657) (-13.4756 395.459) (-10.9829 395.534) (-10.9518 398.192) (-6.30593 398.097) (-4.50034 398.037) (-4.45062 397.923) (4.50864 397.89) (4.55632 398.44) (4.81304 398.431) (4.84304 397.95)) 
((-6.24511 398.132) (-4.5376 398.105) (-4.48761 397.989) (4.48693 397.923) (4.57884 398.046) (4.79836 397.934) (4.82836 397.83)) 
((-6.23614 398.21) (-4.52146 398.182) (-4.47072 398.068) (4.48799 397.969) (4.58929 398.092) (4.78822 397.964) (4.81822 397.875)) 
((-6.13804 398.25) (-4.51854 398.205) (-4.46266 398.094) (4.48674 398.013) (4.58106 398.129) (4.79075 397.988) (4.82075 397.874)) 
((-12.4475 402.798) (-12.4175 401.399) (-6.20915 398.264) (-4.51842 398.223) (-4.46738 398.112) (4.48646 398.041) (4.58239 398.161) (4.79539 398.007) (4.82539 397.906) (7.95122 397.808) (7.97122 398.903) (8.68423 398.939) (10.6523 398.995)) 
((-6.38696 398.278) (-4.53137 398.229) (-4.4814 398.123) (4.47337 398.06) (4.57304 398.177) (4.79162 0.0) (4.82159 397.835) (8.44955 397.805) (8.46955 398.717) (8.70225 398.756) (10.6392 398.726) (12.0183 398.554) (14.1156 398.536)))

;; km 1.200 au km 1.550
("ksituation_to_any" 
((-7.26074 400.384) (-6.95162 0.0) (-4.51678 398.22) (-4.4667 398.137) (4.49207 398.065) (4.59086 398.184) (4.80016 398.044) (4.83016 397.825) (8.78293 397.914) (11.0705 397.983)) 
((-7.605 401.623) (-6.94173 398.252) (-4.55125 398.186) (-4.46262 398.079) (4.50676 398.031) (4.6099 398.151) (4.82983 397.991) (4.85983 397.798) (8.87454 397.886) (11.133 397.946)) 
((-7.66497 401.998) (-6.90626 398.193) (-4.55178 398.123) (-4.44921 397.993) (4.51512 397.906) (4.61567 398.056) (4.82144 397.902) (4.85144 397.685)) 
((-4.49793 0.0) (4.52819 397.855) (4.55819 398.37) (4.82632 398.373) (4.85632 397.511) (9.60362 397.723)) 
((-12.9553 399.654) (-10.1176 398.03) (-7.29477 397.989) (-6.47005 397.962) (-4.45776 397.888) (-4.43018 397.783) (4.53234 397.763) (4.62677 397.887) (5.92039 397.397) (10.3621 397.584) (12.1112 397.583)) 
((-11.4117 397.861) (-7.43597 397.856) (-6.562 397.793) (-4.57335 397.756) (-4.53851 397.63) (4.41874 397.613) (4.51548 397.742) (6.62425 397.174) (11.214 397.451) (12.981 397.469)) 
((-14.081 397.767) (-11.6853 397.757) (-7.62322 397.762) (-6.79106 397.666) (-4.79557 397.622) (-4.76557 397.505) (4.19188 397.434) (4.28999 397.577) (7.40245 397.0) (12.0015 397.318) (13.9094 397.329)) 
((-13.5595 397.412) (-8.15346 397.436) (-7.1904 397.499) (-5.21506 397.476) (-5.18329 397.379) (6.96533 397.262) (7.06734 397.402) (7.30569 397.24) (7.33637 397.095) (7.70469 397.067) (12.9778 397.204) (14.8409 397.229)) 
((-11.3492 396.844) (-7.78308 396.812) (-7.76389 397.388) (-5.62157 397.351) (-5.59346 397.251) (8.10519 397.048) (8.20987 397.183) (8.43935 397.024) (8.46936 396.944) (15.4457 397.095) (17.3474 397.139)) 
((-12.2591 396.432) (-8.10516 396.42) (-8.08667 397.29) (-5.96327 397.219) (-5.93327 397.095) (-1.01911 397.145) (-0.915534 397.303) (0.507807 397.261) (0.602874 397.102) (11.0636 396.881) (18.4486 397.012) (18.7023 396.897)) 
((-16.3263 396.926) (-12.295 396.814) (-8.36671 396.808) (-8.34671 397.115) (-6.24663 397.066) (-6.19553 396.938) (8.02123 396.731) (8.1228 396.848) (8.46882 396.845) (8.49273 398.42) (8.69274 398.421) (8.71274 397.805) (10.2902 397.781) (10.3102 396.768) (17.8017 396.763) (17.8217 397.812) (19.4384 397.809) (19.4575 398.441) (19.6575 398.439) (19.6775 396.783)) 
((-18.3125 396.883) (-16.309 396.938) (-12.1764 397.075) (-9.21116 397.078) (-8.33868 397.056) (-6.43247 397.017) (-6.32994 396.879) (8.31742 396.71) (8.4164 396.847) (8.77828 396.849) (8.79828 398.046) (8.99829 398.025) (9.01829 397.756) (11.135 397.692) (11.155 396.604) (17.6147 396.566) (17.6323 397.715) (19.7574 397.777) (19.7774 398.036) (19.9716 398.027) (19.9916 396.959)) 
((-16.4699 396.959) (-15.4425 396.942) (-15.3013 396.954) (-12.3967 396.96) (-12.1959 396.961) (-9.24534 397.029) (-8.38602 396.996) (-6.50066 396.962) (-6.3958 396.824) (8.51729 396.591) (8.61867 396.733) (8.97033 396.736) (8.99077 397.92) (9.18035 397.919) (9.20222 397.669) (11.3239 397.602) (11.3439 396.469) (17.8019 396.471) (17.8219 397.599) (19.9528 397.674) (19.9728 397.918)) 
((-12.2541 396.973) (-5.88289 396.96) (-5.78535 396.81) (8.57633 396.526) (8.6766 396.667) (9.05124 396.674) (9.07124 397.538) (9.23593 397.549) (9.25593 396.951) (10.8391 396.941) (10.8591 396.47) (18.3907 396.527) (18.4114 396.937)) ((-12.443 396.999) (-6.81335 396.999) (-4.8392 396.981) (-4.73983 396.834) (8.98632 396.414) (9.08424 396.557) (18.2072 396.582) (18.2372 396.697)) 
((-5.66144 396.823) (10.0774 396.557) (12.4313 396.672) (12.4614 396.587)))

;; axe tl du km 0.925 au km 1.450
("ksituation_to_any" 
((14.725 397.749) (15.5382 0.0) (16.3565 397.564)) 
((8.04024 397.743) (8.61603 0.0) (9.55121 397.625)) 
((5.88922 397.765) (6.65693 0.0) (7.41265 397.723)) 
((5.74997 397.777) (6.52304 0.0) (7.24951 397.761)) 
((5.74168 397.868) (6.52202 0.0) (7.28154 397.878)) 
((5.79016 397.989) (6.52654 0.0) (7.2939 397.989)) 
((5.78637 398.042) (6.53445 0.0) (7.31013 398.038)) 
((5.72027 398.01) (6.53951 0.0) (7.28321 398.004)) 
((5.7895 398.019) (6.54457 0.0) (7.27679 397.978)) 
((5.78286 397.959) (6.54963 0.0) (7.28617 397.958)) 
((5.77435 397.935) (6.55369 0.0) (7.14919 0.0)) 
((5.79711 397.921) (6.5563 0.0) (7.29736 397.916)) 
((5.79217 397.904) (6.55891 0.0) (7.28708 397.895)) 
((5.9032 397.889) (6.65764 0.0) (7.40964 397.846)) 
((6.08943 397.844) (6.85091 0.0) (7.58624 397.818)) 
((6.60532 397.716) (7.24696 0.0) (8.10205 397.699)) 
((7.29932 397.58) (8.17378 0.0) (8.79712 397.567)) 
((8.08696 397.442) (9.04037 0.0) (9.58526 397.432)) 
((8.98524 397.338) (9.82393 0.0) (10.4832 397.33)) 
((9.85967 397.208) (10.524 0.0) (11.3578 397.203)) 
((10.5365 397.057) (11.1488 0.0) (11.9842 397.061)) 
((11.104 396.909) (11.701 0.0) (12.5515 396.916) (14.692 396.903) (15.3918 0.0) (16.191 396.904)))

(defun C:ksituation_to_devers ()
	(defun au_carre (x) (* x x))
	(if (= ktransfert nil)
		(setq ktransfert (list "ksituation_to_devers"))
		)
	(while (setq PGB (getpoint "\nSéléctionner le premier point du profil (BAU de la voie de gauche) ou [Enter] pour finir: "))
		(setq PGM (getpoint "\nSéléctionner le point sur le marquage de la voie de gauche: "))
		(setq PGI (getpoint "\nSéléctionner le point sur le bord interne de la voie de gauche: "))
		(setq PDI (getpoint "\nSéléctionner le point sur le bord interne de la voie de droite: "))
		(setq PDM (getpoint "\nSéléctionner le point sur le marquage de la voie de droite: "))
		(setq PDB (getpoint "\nSéléctionner le point sur la BAU de la voie de droite: "))
		
		(setq LGB (sqrt (+ (au_carre (- (car PGM) (car PGB))) (au_carre (- (cadr PGM) (cadr PGB))))))
		(setq LGM (sqrt (+ (au_carre (- (car PGI) (car PGM))) (au_carre (- (cadr PGI) (cadr PGM))))))
		(setq LDM (sqrt (+ (au_carre (- (car PDI) (car PDM))) (au_carre (- (cadr PDI) (cadr PDM))))))
		(setq LDB (sqrt (+ (au_carre (- (car PDM) (car PDB))) (au_carre (- (cadr PDM) (cadr PDB))))))

		(setq profil (list (caddr PGB) LGB (caddr PGM) LGM (caddr PGI) (caddr PDI) LDM (caddr PDM) LDB (caddr PDB)))
		(setq ktransfert (append ktransfert (list profil)))
		)
	)
	
(defun C:kdevers_from_any ()
	(defun au_carre (x) (* x x))
	(setq ListeATrier ktransfert)

	(if (= (car ListeATrier) "ksituation_to_devers")
		(progn
			(entmake (list
			  (cons 0 "LAYER")
			  (cons 100 "AcDbSymbolTableRecord")
			  (cons 100 "AcDbLayerTableRecord")
			  (cons 2 "S+N - klisp - Gauche - BAU")				;; nom du calque
			  (cons 70 0)
			  (cons 62 8)							;; couleur du calque
			  (cons 6 "CACHE")					;; type de ligne 
			  )
			)
			(entmake (list
			  (cons 0 "LAYER")
			  (cons 100 "AcDbSymbolTableRecord")
			  (cons 100 "AcDbLayerTableRecord")
			  (cons 2 "S+N - klisp - Gauche - Marquage")				;; nom du calque
			  (cons 70 0)
			  (cons 62 2)							;; couleur du calque
			  (cons 6 "CACHE")					;; type de ligne 
			  )
			)
			(entmake (list
			  (cons 0 "LAYER")
			  (cons 100 "AcDbSymbolTableRecord")
			  (cons 100 "AcDbLayerTableRecord")
			  (cons 2 "S+N - klisp - Droite - Marquage")				;; nom du calque
			  (cons 70 0)
			  (cons 62 2)							;; couleur du calque
			  (cons 6 "Continuous")					;; type de ligne 
			  )
			)
			(entmake (list
			  (cons 0 "LAYER")
			  (cons 100 "AcDbSymbolTableRecord")
			  (cons 100 "AcDbLayerTableRecord")
			  (cons 2 "S+N - klisp - Droite - BAU")				;; nom du calque
			  (cons 70 0)
			  (cons 62 8)							;; couleur du calque
			  (cons 6 "Continuous")					;; type de ligne 
			  )
			)
			(entmake (list
			  (cons 0 "LAYER")
			  (cons 100 "AcDbSymbolTableRecord")
			  (cons 100 "AcDbLayerTableRecord")
			  (cons 2 "S+N - klisp - Etiquette")				;; nom du calque
			  (cons 70 0)
			  (cons 62 7)							;; couleur du calque
			  (cons 6 "Continuous")					;; type de ligne 
			  )
			)
			
			(defun au_carre (x) (* x x))
			
			(if (= PointDepart nil)
				(setq PointDepart (getpoint "\nSelectionner le point à l'intersection entre l'axe et le premier profil: "))
				)
			(if (= HauteurDeversPiano nil)
				(setq HauteurDeversPiano (abs (- (cadr PointDepart) (cadr (getpoint "\nSelectionner un point sur la ligne qui sépare le dévers de la sinusoité: ")))))
				)
			(if (= DistanceProfil nil)
				(setq DistanceProfil (getreal "\nEntrez la distance entre chaque profil (en mètres): "))
				)
				
			(setq NumeroProfil 0)
			(setq LPpGB nil)
			(setq LPpGM nil)
			(setq LPpDM nil)
			(setq LPpDB nil)
			;; (setq khello nil)			
			(setq ListeATrier (cdr ListeATrier))
			(while (> (length ListeATrier) 0)
				(setq Profil (car ListeATrier))
				
				(setq EGB (nth 0 Profil))
				(setq LGB (nth 1 Profil))
				(setq EGM (nth 2 Profil))
				(setq LGM (nth 3 Profil))
				(setq EGI (nth 4 Profil))
				(setq EDI (nth 5 Profil))
				(setq LDM (nth 6 Profil))
				(setq EDM (nth 7 Profil))
				(setq LDB (nth 8 Profil))
				(setq EDB (nth 9 Profil))
				
				(setq HGB (- EGB EGM))
				(setq HGM (- EGM EGI))
				(setq HDM (- EDM EDI))
				(setq HDB (- EDB EDM))
				
				(setq PeGB (* (/ HGB LGB) 100))
				(setq PeGM (* (/ HGM LGM) 100))
				(setq PeDM (* (/ HDM LDM) 100))
				(setq PeDB (* (/ HDB LDB) 100))
				
				(if (> PeGB 0)
					(setq TPeGB (strcat "+" (rtos PeGB 2 2)))
					(setq TPeGB (rtos PeGB 2 2))
					)
				(if (> PeGM 0)
					(setq TPeGM (strcat "+" (rtos PeGM 2 2)))
					(setq TPeGM (rtos PeGM 2 2))
					)
				(if (> PeDM 0)
					(setq TPeDM (strcat "+" (rtos PeDM 2 2)))
					(setq TPeDM (rtos PeDM 2 2))
					)
				(if (> PeDB 0)
					(setq TPeDB (strcat "+" (rtos PeDB 2 2)))
					(setq TPeDB (rtos PeDB 2 2))
					)
				
				(if (> (+ HGM HGB) 0)
					(setq THGB (strcat "+" (rtos (* (+ HGM HGB) 1000) 2 0)))
					(setq THGB (rtos (* (+ HGM HGB) 1000) 2 0))
					)
				(if (> HGM 0)
					(setq THGM (strcat "+" (rtos (* HGM 1000) 2 0)))
					(setq THGM (rtos (* HGM 1000) 2 0))
					)
				(if (> HDM 0)
					(setq THDM (strcat "+" (rtos (* HDM 1000) 2 0)))
					(setq THDM (rtos (* HDM 1000) 2 0))
					)
				(if (> (+ HDM HDB) 0)
					(setq THDB (strcat "+" (rtos (* (+ HDM HDB) 1000) 2 0)))
					(setq THDB (rtos (* (+ HDM HDB) 1000) 2 0))
					)
				
				(setq TGB (strcat THGB "mm  (" TPeGB "%)"))
				(setq TGM (strcat THGM "mm  (" TPeGM "%)"))
				(setq TDM (strcat THDM "mm  (" TPeDM "%)"))
				(setq TDB (strcat THDB "mm  (" TPeDB "%)"))
				
				(setq PpGB (list (+ (car PointDepart) (* NumeroProfil DistanceProfil)) (+ (cadr PointDepart) (* (+ HGM HGB) 100)) 0.0))
				(setq PpGM (list (+ (car PointDepart) (* NumeroProfil DistanceProfil)) (+ (cadr PointDepart) (* HGM 100)) 0.0))
				(setq PpDM (list (+ (car PointDepart) (* NumeroProfil DistanceProfil)) (+ (cadr PointDepart) (* HDM 100)) 0.0))
				(setq PpDB (list (+ (car PointDepart) (* NumeroProfil DistanceProfil)) (+ (cadr PointDepart) (* (+ HDM HDB) 100)) 0.0))
				
				(setq LPpGB (append LPpGB (list (cons 10 PpGB))))
				(setq LPpGM (append LPpGM (list (cons 10 PpGM))))
				(setq LPpDM (append LPpDM (list (cons 10 PpDM))))
				(setq LPpDB (append LPpDB (list (cons 10 PpDB))))
				
				(entmakex	;; texte Gauche Marquage
					(list
						(cons 0 "TEXT")
						(cons 8 "S+N - klisp - Etiquette")			;; calque
						(cons 10 (list 0.0 0.0 0.0))
						(cons 40 7.5)								;; hauteur de texte
						(cons 1 TGM)								;; le texte
						;; (cons 50 4.71238898)						;; rotation du texte
						(cons 41 1.00)
						(cons 7 "CH-Standard")
						(cons 72 1)
						(cons 73 2)
						(cons 11 PpGM)
						)
					)
				(entmakex	;; texte Gauche Marquage
					(list
						(cons 0 "TEXT")
						(cons 8 "S+N - klisp - Etiquette")			;; calque
						(cons 10 (list 0.0 0.0 0.0))
						(cons 40 5.0)								;; hauteur de texte
						(cons 1 TGB)								;; le texte
						;; (cons 50 4.71238898)						;; rotation du texte
						(cons 41 1.00)
						(cons 7 "CH-Standard")
						(cons 72 1)
						(cons 73 2)
						(cons 11 PpGB)
						)
					)
				(entmakex	;; texte Gauche Marquage
					(list
						(cons 0 "TEXT")
						(cons 8 "S+N - klisp - Etiquette")			;; calque
						(cons 10 (list 0.0 0.0 0.0))
						(cons 40 7.5)								;; hauteur de texte
						(cons 1 TDM)								;; le texte
						;; (cons 50 4.71238898)						;; rotation du texte
						(cons 41 1.00)
						(cons 7 "CH-Standard")
						(cons 72 1)
						(cons 73 2)
						(cons 11 PpDM)
						)
					)
				(entmakex	;; texte Gauche Marquage
					(list
						(cons 0 "TEXT")
						(cons 8 "S+N - klisp - Etiquette")			;; calque
						(cons 10 (list 0.0 0.0 0.0))
						(cons 40 5.0)								;; hauteur de texte
						(cons 1 TDB)								;; le texte
						;; (cons 50 4.71238898)						;; rotation du texte
						(cons 41 1.00)
						(cons 7 "CH-Standard")
						(cons 72 1)
						(cons 73 2)
						(cons 11 PpDB)
						)
					)
					
				(setq NumeroProfil (+ NumeroProfil 1))
				(setq ListeATrier (cdr ListeATrier))
				)
			(entmakex 
				(append 
					(list 
						(cons 0 "LWPOLYLINE")
						(cons 100 "AcDbEntity")
						(cons 8 "S+N - klisp - Gauche - Marquage")
						(cons 100 "AcDbPolyline")
						(cons 90 (length LPpGM))
						(cons 70 0)
						)
					LPpGM
					)
				)
			(entmakex 
				(append 
					(list 
						(cons 0 "LWPOLYLINE")
						(cons 100 "AcDbEntity")
						(cons 8 "S+N - klisp - Gauche - BAU")
						(cons 100 "AcDbPolyline")
						(cons 90 (length LPpGB))
						(cons 70 0)
						)
					LPpGB
					)
				)
			(entmakex 
				(append 
					(list 
						(cons 0 "LWPOLYLINE")
						(cons 100 "AcDbEntity")
						(cons 8 "S+N - klisp - Droite - Marquage")
						(cons 100 "AcDbPolyline")
						(cons 90 (length LPpDM))
						(cons 70 0)
						)
					LPpDM
					)
				)
			(entmakex 
				(append 
					(list 
						(cons 0 "LWPOLYLINE")
						(cons 100 "AcDbEntity")
						(cons 8 "S+N - klisp - Droite - Bau")
						(cons 100 "AcDbPolyline")
						(cons 90 (length LPpDB))
						(cons 70 0)
						)
					LPpDB
					)
				)
			)
		)
	)
(defun C:kbordure_arc ()
	(defun aucarre (asdf) (* asdf asdf))
	(defun distance (qwertz1 qwertz2) (sqrt (+ (aucarre (- (car qwertz1) (car qwertz2))) (aucarre (- (cadr qwertz1) (cadr qwertz2))))))
	(defun angle (yxcv1 yxcv2) (atan (- (cadr yxcv2) (cadr yxcv1)) (- (car yxcv2) (car yxcv1))))
	
	(setq 
		HauteurTexte 0.5
		declageTetxe 0.5
		style (getvar "textstyle")
		)
	(while 
		(setq a (car (entsel "\nSelectionner un arc ou une ligne: ")))
		(setq lstdxf (entget a))
		(setq TypeObjet (cdr (assoc 0 lstdxf)))
		(if (= TypeObjet "ARC")
			(progn
				(setq
					calque (cdr (assoc 8 lstdxf))
					centre (cdr (assoc 10 lstdxf))
					rayon (cdr (assoc 40 lstdxf))
					AngleDebut (cdr (assoc 50 lstdxf))
					AngleFin (cdr (assoc 51 lstdxf))
					PointDebut (polar centre AngleDebut rayon)
					PointFin (polar centre AngleFin rayon)
					PointMilieuArc (polar centre (if (< (- AngleFin AngleDebut) 0) (+ (/ (+ AngleDebut AngleFin) 2.0) pi) (/ (+ AngleDebut AngleFin) 2.0)) rayon)
					Direction (+ (atan (- (cadr PointFin) (cadr PointDebut)) (- (car PointFin) (car PointDebut))) (/ pi 2.0))
					)
				
				;;orientation
				(if (= AncienDirectionExtarctionTexte nil)
					(setq TexteOrientation "\nChoisissez l'orientation du texte: ")
					(setq TexteOrientation "\nChoisissez l'orientation du texte ou ENTER pour prendre l'orientation du texte précedent: ")
					)
					
				(if (= AncienDirectionExtarctionTexte nil)
							(initget 1)
							)
			
				(setq Point2U (getpoint PointMilieuArc TexteOrientation))
				(if (= Point2U nil)
					(setq DirectionExtarctionTexte AncienDirectionExtarctionTexte)
					(setq DirectionExtarctionTexte (angle PointMilieuArc Point2U))
					)
				(setq AncienDirectionExtarctionTexte DirectionExtarctionTexte)
				
				(if
					(> (abs (- Direction DirectionExtarctionTexte)) (/ pi 2.0))	;; plus grand que pi/2
					(setq Direction (- Direction pi))
					)
				
				(if (= (tblsearch "LAYER" (strcat calque "_txt")) nil)
					(setq CalqueFinal "0")
					(setq CalqueFinal (strcat calque "_txt"))
					)
						
				;; longueur de l'arc %<\AcObjProp Object(%<\_ObjId 8796074766336>%).ArcLength \f "%lu2%pr2">%
				;; rayon %<\AcObjProp Object(%<\_ObjId 8796074766336>%).Radius \f "%lu2%pr2">%
				(setq TexteArc (strcat
					"%<\\AcObjProp Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object a))) ">%).ArcLength \\f \"%lu2%pr2\">%"
					" R="
					"%<\\AcObjProp Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object a))) ">%).Radius \\f \"%lu2%pr2\">%"
					))
					
				(setq MTextArc (entmakex 
					(list 
						(cons 0 "MTEXT")
						(cons 8 CalqueFinal)
						(cons 100 "AcDbEntity")
						(cons 100 "AcDbMText")
						(cons 10 PointMilieuArc)	;;point d'insertion
						(cons 40 HauteurTexte)
						(cons 41 3.0)
						(cons 71 5)
						(cons 1 TexteArc)
						(cons 7 style)
						(cons 50 (- Direction (/ pi 2.0)))
						)
					))
				(vla-put-textstring (vlax-ename->vla-object MTextArc) (vla-get-textstring (vlax-ename->vla-object MTextArc)))
				)
			(if (= TypeObjet "LINE")
				(progn
					(setq
						calque (cdr (assoc 8 lstdxf))
						PointDebut (cdr (assoc 10 lstdxf))
						PointFin (cdr (assoc 11 lstdxf))
						Direction (+ (atan (- (cadr PointFin) (cadr PointDebut)) (- (car PointFin) (car PointDebut))) (/ pi 2.000))
						PointMilieuLine (list (/ (+ (car PointDebut) (car PointFin)) 2.0) (/ (+ (cadr PointDebut) (cadr PointFin)) 2.0) 0.0)
						)
					(if (= (tblsearch "LAYER" (strcat calque "_txt")) nil)
						(setq CalqueFinal "0")
						(setq CalqueFinal (strcat calque "_txt"))
						)
						
					;; longueur %<\AcObjProp Object(%<\_ObjId 2464132016>%).Length \f "%lu2%pr2">%
					(setq Texteline (strcat
						"%<\\AcObjProp Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object a))) ">%).Length \\f \"%lu2%pr2\">%"
						))
						
						;;orientation
					(if (= AncienDirectionExtarctionTexte nil)
						(setq TexteOrientation "\nChoisissez l'orientation du texte: ")
						(setq TexteOrientation "\nChoisissez l'orientation du texte ou ENTER pour prendre l'orientation du texte précedent: ")
						)
						
					(if (= AncienDirectionExtarctionTexte nil)
								(initget 1)
								)
				
					(setq Point2U (getpoint PointMilieuLine TexteOrientation))
					(if (= Point2U nil)
						(setq DirectionExtarctionTexte AncienDirectionExtarctionTexte)
						(setq DirectionExtarctionTexte (angle PointMilieuLine Point2U))
						)
					(setq AncienDirectionExtarctionTexte DirectionExtarctionTexte)
					
					(if
						(> (abs (- Direction DirectionExtarctionTexte)) (/ pi 2.0))	;; plus grand que pi/2
						(setq Direction (- Direction pi))
						)
						
					(setq PointInsertionTexte (polar
						PointMilieuLine
						direction
						declageTetxe
						))
						
					(setq MTextline (entmakex 
						(list 
							(cons 0 "MTEXT")
							(cons 8 CalqueFinal)
							(cons 100 "AcDbEntity")
							(cons 100 "AcDbMText")
							(cons 10 PointInsertionTexte)	;;point d'insertion
							(cons 40 HauteurTexte)
							(cons 41 3.0)
							(cons 71 8)
							(cons 1 Texteline)
							(cons 7 style)
							(cons 50 (- Direction (/ pi 2.000)))
							)
						))
					(vla-put-textstring (vlax-ename->vla-object MTextline) (vla-get-textstring (vlax-ename->vla-object MTextline)))
					)
				(alert "Objet incorrect.")
				)
			)
		)	
	)

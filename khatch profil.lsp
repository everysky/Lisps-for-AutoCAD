(defun C:Khatch ()

	(if 
		(or 
			(and 
				(/= (type hauteurtexte) 'INT) 
				(/= (type hauteurtexte) 'REAL)
				)
			(= hauteurtexte nil)
			)
		(setq hauteurtexte 0.20)
		)
	(if 
		(or 
			(and 
				(/= (type echelle) 'INT) 
				(/= (type echelle) 'REAL)
				)
			(= echelle nil)
			)
		(setq echelle 0.01)
		)
	(if (= motif nil)
		(setq motif "ANSI32")
		)
	(if 
		(or 
			(and 
				(/= (type angleHachure) 'INT) 
				(/= (type angleHachure) 'REAL)
				)
			(= angleHachure nil)
			)
		(setq angleHachure 0.0)
		)
	(setq style (getvar "textstyle"))
		
	(while
		(/= nil (progn		
			(initget "Angle Echelle Hauteur")
			(setq option (getpoint "\nSpécifiez le premier point ou [Angle/Echelle/Hauteur]: "))
			option
			))
		(if (= option "Angle")
			(progn
				(setq TexteOptionAngle (strcat
					"Spécifiez le nouvel angle de la hachure ou [selectionner une Hachure] pour en récupèrer l'angle: <"
					(rtos (* 180.0 (/ angleHachure pi)) 2 2)
					">"
					))
				(initget "Hachure")
				(setq OptionAngle (getreal TexteOptionAngle))
				(if (= OptionAngle "Hachure")
					(progn
						(while 
							(/= "HATCH" (cdr (assoc 0 (setq lstdxf (entget (car (entsel "\nSelectionnez une hachure dont vous voulez recupèrer l'angle:")))))))
							(prompt "\nL'objet sélectionné n'est pas une hachure.")
							)
						(setq OptionAngle (cdr (assoc 53 lstdxf)))
						(prompt "\nHachure sélectionnée. Angle enregistré")
						)
					)
				(if (/= OptionAngle nil)
					(setq angleHachure (* pi (/ OptionAngle 180.0)))
					)
				)
			)
		(if (= option "Echelle")
			(progn
				(setq TexteOptionEchelle (strcat
					"Spécifiez la nouvelle echelle de la hachure ou [sélectionner une Hachure] pour en récupèrer l'echelle: <"
					(rtos echelle 2 2)
					">"
					))
				(initget "Hachure")
				(setq OptionEchelle (getreal TexteOptionEchelle))
				(if (= OptionEchelle "Hachure")
					(progn
						(while 
							(/= "HATCH" (cdr (assoc 0 (setq lstdxf (entget (car (entsel "\nSélectionnez une hachure dont vous voulez récupèrer l'echelle:")))))))
							(prompt "\nL'objet sélectionné n'est pas une hachure.")
							)
						(setq OptionEchelle (cdr (assoc 41 lstdxf)))
						(prompt (strcat "\nHachure sélectionnée. Echelle = " (rtos OptionEchelle 2 2)))
						)
					)
				(if (/= OptionEchelle nil)
					(setq echelle OptionEchelle)
					)
				)
			)
		(if (= option "Hauteur")
			(progn
				(setq TexteOptionhauteur (strcat
					"Spécifiez la nouvelle hauteur du texte ou [sélectionner un Texte] pour en récupèrer la hauteur: <"
					(rtos hauteurtexte 2 2)
					">"
					))
				(initget "Texte")
				(setq OptionHauteur (getreal TexteOptionhauteur))
				(if (= OptionHauteur "Texte")
					(progn
						(while 
							(and
								(/= "TEXT" (cdr (assoc 0 (setq lstdxf (entget (car (entsel "\nSélectionnez un texte dont vous voulez récupèrer la hauteur:")))))))
								(/= "MTEXT" (cdr (assoc 0 lstdxf)))
								)
							(prompt "\nL'objet sélectionné n'est pas un texte.")
							)
						(setq OptionHauteur (cdr (assoc 40 lstdxf)))
						(prompt (strcat "\nTexte sélectionné. hauteur = " (rtos OptionHauteur 2 2)))
						)
					)
				(if (/= OptionHauteur nil)
					(setq hauteurtexte OptionHauteur)
					)
				)
			)
		(if (= (type option) 'LIST)
			(progn
				(setq point1 option)
				(setq point2 (getpoint point1 "\nChoisissez le point suivant: "))
				(if (= point2 nil)
					(quit)
					(setq liste
						(list 
							(cons 10 point1) 
							(cons 10 point2)
							)
						)
					)
				(while (setq point (getpoint (cdr (last liste)) "\nChoisissez un autre point ou ENTER pour finir le contour de la hachure: "))
					(setq liste (append liste (list (cons 10 point))))
					)

				(setq idHachure (entmakex ;; création de la hachure
					(append
						(list '(0 . "HATCH")
							'(100 . "AcDbEntity")
		;;					(cons 8 calque)
		;;					(cons 62 (fix couleur))
							'(410 . "Model")
							'(100 . "AcDbHatch")
							'(10 0.0 0.0 0.0)
							'(210 0.0 0.0 1.0)
							(cons 2 motif)
							(if (= motif "SOLID")
								'(70 . 1)
								'(70 . 0)
								) ;_  if
							'(71 . 0)
							'(91 . 1)
							'(92 . 7)
							'(72 . 0)
							'(73 . 1)
							(cons 93 (length liste))
							) ;_ list
						liste
						(list 
							'(97 . 0)
							'(75 . 0)
							'(76 . 1)
							(cons 52 angleHachure)
							(cons 41 echelle)
							'(77 . 0)
							'(78 . 1)
							(cons 53 angleHachure)
							'(43 . 0.)
							'(44 . 0.)
							'(45 . 1.)
							'(46 . 1.)
							'(79 . 0)
							'(47 . 1.)
							'(98 . 2)
							'(10 0. 0. 0.0)
							'(10 0. 0. 0.0)
							'(451 . 0)
							'(460 . 0.0)
							'(461 . 0.0)
							'(452 . 1)
							'(462 . 1.0)
							'(453 . 2)
							'(463 . 0.0)
							'(463 . 1.0)
							'(470 . "LINEAR")
							) ;_  list
						) ;_ append
					 )) ;_  entmakex
					
				(entmakex ;; création du contour
					(append 
						(list 
							(cons 0 "LWPOLYLINE")
							(cons 100 "AcDbEntity")
		;;					(cons 8 calque)
		;;					(cons 62 (fix couleur))
							(cons 100 "AcDbPolyline")
							(cons 90 (length liste))
							(cons 70 1)
							)
						liste
						)
					)
				(setq texte (strcat "%<\\AcObjProp Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idHachure))) ">%).Area \\f \"%lu2%pr2\">%" " [m2]"))
				
				(setq PointInsertion (getpoint point1 "\nChoisissez le point d'insertion du texte (ou ENTER pour inserer le texte sur le premier point de la hachure):"))
				(if 
					(= PointInsertion nil)
					(setq PointInsertion point1)
					)			
				(setq idMText (entmakex  ;; création du texte
					(list 
						(cons 0 "MTEXT")
						(cons 100 "AcDbEntity")
						(cons 100 "AcDbMText")
						(cons 10 PointInsertion)	;;point d'insertion
						(cons 40 hauteurtexte)
						(cons 41 3.0)
						(cons 71 5)
						(cons 1 texte)
						(cons 7 style)
						(cons 50 0)
						)
					))
				(vla-put-textstring (vlax-ename->vla-object idMText) (vla-get-textstring (vlax-ename->vla-object idMText)))
				
				;; code trouvé là -> https://forums.autodesk.com/t5/visual-lisp-autolisp-and-general/copy-string-to-clipboard/td-p/5607206
				;; permet de stocker une valeur/un texte dans le presse papier de windows
				(vl-load-com) ;; charge les commandes visualisp
				(vlax-invoke
					(vlax-get (vlax-get (vlax-create-object "htmlfile") 'ParentWindow) 'ClipBoardData)
					'setData
					"TEXT"
					(rtos (vla-get-area (vlax-ename->vla-object idHachure)) 2 3)
					)
				(prompt "\nL'aire de la hachure a été copiée dans le presse papier.")
				
				) ;; fin de progn
			) ;; fin de if
		) ;; fin de while
	) ;; fin de defun
(defun C:Khatch ()

	(if 
		(or 
			(and 
				(/= (type hauteurtexte) 'INT) 
				(/= (type hauteurtexte) 'REAL)
				)
			(= hauteurtexte nil)
			)
		(setq hauteurtexte 0.20)
		)
	(if 
		(or 
			(and 
				(/= (type echelle) 'INT) 
				(/= (type echelle) 'REAL)
				)
			(= echelle nil)
			)
		(setq echelle 0.01)
		)
	(if (= motif nil)
		(setq motif "ANSI32")
		)
	(if 
		(or 
			(and 
				(/= (type angleHachure) 'INT) 
				(/= (type angleHachure) 'REAL)
				)
			(= angleHachure nil)
			)
		(setq angleHachure 0.0)
		)
	(setq style (getvar "textstyle"))
		
	(while
		(/= nil (progn		
			(initget "Angle Echelle Hauteur")
			(setq option (getpoint "\nSpécifiez le premier point ou [Angle/Echelle/Hauteur]: "))
			option
			))
		(if (= option "Angle")
			(progn
				(setq TexteOptionAngle (strcat
					"Spécifiez le nouvel angle de la hachure ou [selectionner une Hachure] pour en récupèrer l'angle: <"
					(rtos (* 180.0 (/ angleHachure pi)) 2 2)
					">"
					))
				(initget "Hachure")
				(setq OptionAngle (getreal TexteOptionAngle))
				(if (= OptionAngle "Hachure")
					(progn
						(while 
							(/= "HATCH" (cdr (assoc 0 (setq lstdxf (entget (car (entsel "\nSelectionnez une hachure dont vous voulez recupèrer l'angle:")))))))
							(prompt "\nL'objet sélectionné n'est pas une hachure.")
							)
						(setq OptionAngle (cdr (assoc 53 lstdxf)))
						(prompt "\nHachure sélectionnée. Angle enregistré")
						)
					)
				(if (/= OptionAngle nil)
					(setq angleHachure (* pi (/ OptionAngle 180.0)))
					)
				)
			)
		(if (= option "Echelle")
			(progn
				(setq TexteOptionEchelle (strcat
					"Spécifiez la nouvelle echelle de la hachure ou [sélectionner une Hachure] pour en récupèrer l'echelle: <"
					(rtos echelle 2 2)
					">"
					))
				(initget "Hachure")
				(setq OptionEchelle (getreal TexteOptionEchelle))
				(if (= OptionEchelle "Hachure")
					(progn
						(while 
							(/= "HATCH" (cdr (assoc 0 (setq lstdxf (entget (car (entsel "\nSélectionnez une hachure dont vous voulez récupèrer l'echelle:")))))))
							(prompt "\nL'objet sélectionné n'est pas une hachure.")
							)
						(setq OptionEchelle (cdr (assoc 41 lstdxf)))
						(prompt (strcat "\nHachure sélectionnée. Echelle = " (rtos OptionEchelle 2 2)))
						)
					)
				(if (/= OptionEchelle nil)
					(setq echelle OptionEchelle)
					)
				)
			)
		(if (= option "Hauteur")
			(progn
				(setq TexteOptionhauteur (strcat
					"Spécifiez la nouvelle hauteur du texte ou [sélectionner un Texte] pour en récupèrer la hauteur: <"
					(rtos hauteurtexte 2 2)
					">"
					))
				(initget "Texte")
				(setq OptionHauteur (getreal TexteOptionhauteur))
				(if (= OptionHauteur "Texte")
					(progn
						(while 
							(and
								(/= "TEXT" (cdr (assoc 0 (setq lstdxf (entget (car (entsel "\nSélectionnez un texte dont vous voulez récupèrer la hauteur:")))))))
								(/= "MTEXT" (cdr (assoc 0 lstdxf)))
								)
							(prompt "\nL'objet sélectionné n'est pas un texte.")
							)
						(setq OptionHauteur (cdr (assoc 40 lstdxf)))
						(prompt (strcat "\nTexte sélectionné. hauteur = " (rtos OptionHauteur 2 2)))
						)
					)
				(if (/= OptionHauteur nil)
					(setq hauteurtexte OptionHauteur)
					)
				)
			)
		(if (= (type option) 'LIST)
			(progn
				(setq point1 option)
				(setq point2 (getpoint point1 "\nChoisissez le point suivant: "))
				(if (= point2 nil)
					(quit)
					(setq liste
						(list 
							(cons 10 point1) 
							(cons 10 point2)
							)
						)
					)
				(while (setq point (getpoint (cdr (last liste)) "\nChoisissez un autre point ou ENTER pour finir le contour de la hachure: "))
					(setq liste (append liste (list (cons 10 point))))
					)

				(setq idHachure (entmakex ;; création de la hachure
					(append
						(list '(0 . "HATCH")
							'(100 . "AcDbEntity")
		;;					(cons 8 calque)
		;;					(cons 62 (fix couleur))
							'(410 . "Model")
							'(100 . "AcDbHatch")
							'(10 0.0 0.0 0.0)
							'(210 0.0 0.0 1.0)
							(cons 2 motif)
							(if (= motif "SOLID")
								'(70 . 1)
								'(70 . 0)
								) ;_  if
							'(71 . 0)
							'(91 . 1)
							'(92 . 7)
							'(72 . 0)
							'(73 . 1)
							(cons 93 (length liste))
							) ;_ list
						liste
						(list 
							'(97 . 0)
							'(75 . 0)
							'(76 . 1)
							(cons 52 angleHachure)
							(cons 41 echelle)
							'(77 . 0)
							'(78 . 1)
							(cons 53 angleHachure)
							'(43 . 0.)
							'(44 . 0.)
							'(45 . 1.)
							'(46 . 1.)
							'(79 . 0)
							'(47 . 1.)
							'(98 . 2)
							'(10 0. 0. 0.0)
							'(10 0. 0. 0.0)
							'(451 . 0)
							'(460 . 0.0)
							'(461 . 0.0)
							'(452 . 1)
							'(462 . 1.0)
							'(453 . 2)
							'(463 . 0.0)
							'(463 . 1.0)
							'(470 . "LINEAR")
							) ;_  list
						) ;_ append
					 )) ;_  entmakex
					
				(entmakex ;; création du contour
					(append 
						(list 
							(cons 0 "LWPOLYLINE")
							(cons 100 "AcDbEntity")
		;;					(cons 8 calque)
		;;					(cons 62 (fix couleur))
							(cons 100 "AcDbPolyline")
							(cons 90 (length liste))
							(cons 70 1)
							)
						liste
						)
					)
				(setq texte (strcat "%<\\AcObjProp Object(%<\\_ObjId " (itoa (vla-get-ObjectID(vlax-ename->vla-object idHachure))) ">%).Area \\f \"%lu2%pr2\">%" " [m2]"))
				
				(setq PointInsertion (getpoint point1 "\nChoisissez le point d'insertion du texte (ou ENTER pour inserer le texte sur le premier point de la hachure):"))
				(if 
					(= PointInsertion nil)
					(setq PointInsertion point1)
					)			
				(setq idMText (entmakex  ;; création du texte
					(list 
						(cons 0 "MTEXT")
						(cons 100 "AcDbEntity")
						(cons 100 "AcDbMText")
						(cons 10 PointInsertion)	;;point d'insertion
						(cons 40 hauteurtexte)
						(cons 41 3.0)
						(cons 71 5)
						(cons 1 texte)
						(cons 7 style)
						(cons 50 0)
						)
					))
				(vla-put-textstring (vlax-ename->vla-object idMText) (vla-get-textstring (vlax-ename->vla-object idMText)))
				
				;; code trouvé là -> https://forums.autodesk.com/t5/visual-lisp-autolisp-and-general/copy-string-to-clipboard/td-p/5607206
				;; permet de stocker une valeur/un texte dans le presse papier de windows
				(vl-load-com) ;; charge les commandes visualisp
				(vlax-invoke
					(vlax-get (vlax-get (vlax-create-object "htmlfile") 'ParentWindow) 'ClipBoardData)
					'setData
					"TEXT"
					(rtos (vla-get-area (vlax-ename->vla-object idHachure)) 2 3)
					)
				(prompt "\nL'aire de la hachure a été copiée dans le presse papier.")
				
				) ;; fin de progn
			) ;; fin de if
		) ;; fin de while
	) ;; fin de defun

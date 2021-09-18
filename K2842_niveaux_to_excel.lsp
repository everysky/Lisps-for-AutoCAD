(defun C:K2842_niveaux_to_excel ()

	;; code trouv� ici http://www.theswamp.org/index.php?topic=21764.msg263322#msg263322
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
	
	;; code trouv� ici http://www.theswamp.org/index.php?topic=21764.msg263322#msg263322
	(defun _GetClipBoardText( / htmlfile result )
    ;;  Attribution: Reformatted version of
    ;;  post by Patrick_35 at theswamp.org.

    ;;  See http://tinyurl.com/2ngf4r.
		(setq result
			(vlax-invoke
				(vlax-get
					(vlax-get
						(setq htmlfile (vlax-create-object "htmlfile"))
					   'ParentWindow
					)
				   'ClipBoardData
				)
			   'GetData
				"Text"
			)
		)
		(vlax-release-object htmlfile)
		result
	)
	
	(_SetClipBoardText "")
	(while
		;; Bloc num�ro
		(/= (setq ent1 (entsel "\nSelectionner le bloc contenant le num�ro du point ou ENTER pour quitter la commande:")) nil)
		(setq
			ent1 (car ent1)
			lstdxf1 (entget ent1)
			ent1type (cdr (assoc 0 lstdxf1))
			)

		(if (/= ent1type "INSERT")
			(alert "L'objet selectionn� n'est pas un bloc.")
			(progn
				(prompt "\nL'objet selectionn� est un bloc. Le programme continue!")
				(if (/= (vla-get-effectivename (vlax-ename->vla-object ent1)) "PCOORDONEES")
					(prompt "Le bloc selectionn� n'est pas valide. Le bloc valide est ""PCOORDONEES"".")
					(progn
						(prompt "\nLe bloc selectionn� est valide. Le programme continue!")						
						;;modification du premier attribut
						(setq EntAtt (entnext Ent1))							;; nom d'entit� de l'entit� suivante
						(setq EntAttLstdxf (entget EntAtt))							;; d�finition de l'entit�
						(while (not (= (cdr (assoc 0 EntAttLstdxf)) "SEQEND"))		;; d�but de la boucle des attribut
							(if															;; si
								(and 
									(= (cdr (assoc 0 EntAttLstdxf)) "ATTRIB")				;; c'est une entit� "attribu"
									(= (cdr (assoc 2 EntAttLstdxf)) "X")				;; le nom de l'entit� "attribu" est "X"
									)
								(setq NumeroPoint (cdr (assoc 1 EntAttLstdxf)))
								)
							(setq EntAtt (entnext EntAtt))								;; nom d'entit� de l'entit� suivante
							(setq EntAttLstdxf (entget EntAtt))							;; d�finition de l'entit�
							)
						(prompt (strcat "\n" NumeroPoint))
								
								
								

						;; bloc altitude 1
						(initget 1)
						(setq ent2 (entsel "\nSelectionner le bloc contenant la premi�re altitude:"))
						(setq
							ent2 (car ent2)
							lstdxf2 (entget ent2)
							ent2type (cdr (assoc 0 lstdxf2))
							)

						(if (/= ent2type "INSERT")
							(alert "L'objet selectionn� n'est pas un bloc.")
							(progn
								(prompt "\nL'objet selectionn� est un bloc. Le programme continue!")
								(if (/= (vla-get-effectivename (vlax-ename->vla-object ent2)) "ELEV NEW")
									(alert "Le bloc selectionn� n'est pas valide. Le bloc valide est ""ELEV NEW"".")
									(progn
										(prompt "\nLe bloc selectionn� est valide. Le programme continue!")
										;;modification du premier attribut
										(setq EntAtt (entnext Ent2))							;; nom d'entit� de l'entit� suivante
										(setq EntAttLstdxf (entget EntAtt))							;; d�finition de l'entit�
										(while (not (= (cdr (assoc 0 EntAttLstdxf)) "SEQEND"))		;; d�but de la boucle des attribut
											(if															;; si
												(and 
													(= (cdr (assoc 0 EntAttLstdxf)) "ATTRIB")				;; c'est une entit� "attribu"
													(= (cdr (assoc 2 EntAttLstdxf)) "ELEV")				;; le nom de l'entit� "attribu" est "ELEV"
													)
												(setq Altitude1 (cdr (assoc 1 EntAttLstdxf)))
												)
											(setq EntAtt (entnext EntAtt))								;; nom d'entit� de l'entit� suivante
											(setq EntAttLstdxf (entget EntAtt))							;; d�finition de l'entit�
											)
										(prompt (strcat "\n" Altitude1))
										
										
										
										
										;; bloc altitude 2
										(if (/= (setq ent3 (entsel "\nSelectionner le bloc contenant la deuxi�me altitude ou ENTERE si il n' y en a pas:")) nil)
											(progn
												(setq
													ent3 (car ent3)
													lstdxf3 (entget ent3)
													ent3type (cdr (assoc 0 lstdxf3))
													)

												(if (/= ent3type "INSERT")
													(alert "L'objet selectionn� n'est pas un bloc.")
													(progn
														(prompt "\nL'objet selectionn� est un bloc. Le programme continue!")
														(if (/= (vla-get-effectivename (vlax-ename->vla-object ent3)) "ELEV NEW")
															(alert "Le bloc selectionn� n'est pas valide. Le bloc valide est ""ELEV NEW"".")
															(progn
																(prompt "\nLe bloc selectionn� est valide. Le programme continue!")
																;;modification du premier attribut
																(setq EntAtt (entnext Ent3))							;; nom d'entit� de l'entit� suivante
																(setq EntAttLstdxf (entget EntAtt))							;; d�finition de l'entit�
																(while (not (= (cdr (assoc 0 EntAttLstdxf)) "SEQEND"))		;; d�but de la boucle des attribut
																	(if															;; si
																		(and 
																			(= (cdr (assoc 0 EntAttLstdxf)) "ATTRIB")				;; c'est une entit� "attribu"
																			(= (cdr (assoc 2 EntAttLstdxf)) "ELEV")				;; le nom de l'entit� "attribu" est "ELEV"
																			)
																		(setq Altitude2 (cdr (assoc 1 EntAttLstdxf)))
																		)
																	(setq EntAtt (entnext EntAtt))								;; nom d'entit� de l'entit� suivante
																	(setq EntAttLstdxf (entget EntAtt))							;; d�finition de l'entit�
																	)
																(prompt (strcat "\n" Altitude2))
																(if (> Altitude1 Altitude2)
																	(setq 
																		AltitudeHaute Altitude1
																		AltitudeBasse Altitude2
																		)
																	(setq 
																		AltitudeHaute Altitude2
																		AltitudeBasse Altitude1
																		)
																	)
																(setq textePressePapier (strcat
																	NumeroPoint
																	"\t"
																	AltitudeBasse
																	"\t"
																	Altitudehaute
																	"\r\n"
																	))
																(_SetClipBoardText (strcat (_GetClipBoardText) textePressePapier))
																(prompt (strcat "\nLes valeurs ont �t� copi�es dans le presse-papier avec succ�s."))
																)
															)
														)
													)
												)
											(progn
												(setq textePressePapier (strcat
													NumeroPoint
													"\t"
													"'---"
													"\t"
													Altitude1
													"\r\n"
													))
												(_SetClipBoardText (strcat (_GetClipBoardText) textePressePapier))
												(prompt (strcat "\nLes valeurs ont �t� copi�es dans le presse-papier avec succ�s."))
												)
											)
										)
									)
								)
							)
						)
					)
				)
			)
		)
	)

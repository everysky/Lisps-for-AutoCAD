(defun c:kpente_texte_profil ( )
;; Bonjour, cette commande autocad cr�e, en selectionnant deux points, un texte avec la pente en % et une fl�che.
;; Pour l'utiliser: 1) copiez l'entier de ce texte dans la barre de commande de votre fichier sur autocad.
;;					2) taper "kpentetxt" (sans les guillemets) pour lancer la fonction 


	(setq a_fp 0.44810)
	(setq l_fp 0.41533)
	
	(setq a_fm 0.88564)
	(setq l_fm 0.23239)
	
	(setq a_ff 2.69349)
	(setq l_ff 0.41533)
	
	(setq a_t 1.57000)
	(setq l_t 0.31263)
	
	;;(setq calque "02 - D�vers")
	(if (= EchelleObjetsKPenteTexteProfil nil)
		(setq EchelleObjetsKPenteTexteProfil 100)
		)
	(if (= HauteurTexteKPenteTexteProfil nil)
		(setq HauteurTexteKPenteTexteProfil 0.25)
		)
	(if (= Unit�PenteKPenteTexteProfil nil)
		(setq Unit�PenteKPenteTexteProfil "Cent")
		)
	(if (= PrecisionKPenteTexteProfil nil)
		(setq PrecisionKPenteTexteProfil 1)
		)
	(setq style (getvar "textstyle"))
	
	(setq 
		option nil
		option2 nil
		option3 nil
		option4 nil
		option5 nil
		)
		
	(while 
		(not (= nil (progn
			(setq textechoix (strcat
				"\nSp�cifiez le premier point ou [Echelle/Hauteur-texte/Unit�s/Pr�cision] (1:" (rtos EchelleObjetsKPenteTexteProfil 2 0)
				" | h=" (rtos HauteurTexteKPenteTexteProfil 2 2)
				" | " (if (= Unit�PenteKPenteTexteProfil "Cent")
					"%"
					"�"
					)
				" | " (rtos PrecisionKPenteTexteProfil 2 0) " chiffres apr�s la virgule):"
				))
			(initget  "Echelle Hauteur-texte Unit�s Pr�cision")
			(setq option (getpoint textechoix))
			option
			)))
		(if (= option "Echelle")
			(progn;;si oui
				(setq textechoix (strcat "\nD�finissez l'echelle des objets (si l'echelle = 1:100 alors tapez \"100\") < 1:" (rtos EchelleObjetsKPenteTexteProfil 2 0) ">: ")) 
				(initget 6)
				(setq option2 (getint textechoix))
				(if (/= option2 nil)
					(setq EchelleObjetsKPenteTexteProfil option2)
					)
				) ;; fin de si oui
			(if (= option "Hauteur-texte")
				(progn ;; si oui
					(setq textechoix (strcat "\nD�finissez la hauteur du texte sur papier <" (rtos HauteurTexteKPenteTexteProfil 2 2) ">: ")) 
					(initget 6)
					(setq option3 (getreal textechoix))
					(if (/= option3 nil)
						(setq HauteurTexteKPenteTexteProfil option3)
						)
					) ;; fin de si oui
				(if (= option "Unit�s")
					(progn ;; si oui
						(setq textechoix (strcat "\nD�finissez l'unit� de la pente (pourcent ou pourmille)[Cent/Mille] <" Unit�PenteKPenteTexteProfil ">: ")) 
						(initget 0 "Cent Mille")
						(setq option4 (getkword textechoix))
						(if (/= option4 nil)
							(setq Unit�PenteKPenteTexteProfil option4)
							)
						) ;; fin de si oui
					(if (= option "Pr�cision")
						(progn ;; si oui
							(setq textechoix (strcat "\nD�finissez le nombre de chiffre apr�s la virgule <" (rtos PrecisionKPenteTexteProfil 2 0) ">: ")) 
							(initget 6)
							(setq option5 (getint textechoix))
							(if (/= option5 nil)
								(setq PrecisionKPenteTexteProfil option5)
								)
							) ;; fin de si oui
						(if (= (type option) 'LIST)
							(progn ;; si oui
								(setq p1 option)
								(setq p2 (getpoint p1 "\nSp�cifiez le deuxi�me point: "))
								(if (< (cadr p1) (cadr p2))
									(and
										(setq p p1)
										(setq p1 p2)
										(setq p2 p)
										) ;; and
									) ;; if
								(setq dX (- (car p2) (car p1)))
								(setq dY (- (cadr p2) (cadr p1)))
								(setq direction 
									(if (> (car p1) (car p2))
										"-"
										"+"
										)
									)
								(setq pente (abs (* (/ dY dX) 100)))
								(setq angle 
									(if (> dX 0)
										(atan dY dX)
										(atan (* -1.0 dY) (* -1 dX))
										)
									)
								(setq pointmilieu
									(list
										(/ (+ (car p1) (car p2)) 2.00)
										(/ (+ (cadr p1) (cadr p2)) 2.00)
										0.00
										)
									)
								(setq
									texte (if (= Unit�PenteKPenteTexteProfil "Cent")
										(strcat (rtos pente 2 PrecisionKPenteTexteProfil) "%")
										(strcat (rtos (* pente 10.0) 2 PrecisionKPenteTexteProfil) "�")
										)
									)
								(entmakex
									(list
										(cons 0 "LWPOLYLINE")
										(cons 100 "AcDbEntity")
										;;(cons 8 calque)
										(cons 100 "AcDbPolyline")
										(cons 90 3)					
										(cons 70 0)
										(cons 10 (if (= direction "+")
											(polar pointmilieu (+ a_fp angle) (* (/ EchelleObjetsKPenteTexteProfil 100.0) l_fp))
											(polar pointmilieu (+ (- PI a_fp) angle) (* (/ EchelleObjetsKPenteTexteProfil 100.0) l_fp))
											)) ;; if cons
										(cons 40 0)
										(cons 41 (* (/ EchelleObjetsKPenteTexteProfil 100.0) 0.1))
										(cons 10 (if (= direction "+")
											(polar pointmilieu (+ a_fm angle) (* (/ EchelleObjetsKPenteTexteProfil 100.0) l_fm))
											(polar pointmilieu (+ (- PI a_fm) angle) (* (/ EchelleObjetsKPenteTexteProfil 100.0) l_fm))
											)) ;; if cons
										(cons 40 0)
										(cons 41 0)
										(cons 10 (if (= direction "+")
											(polar pointmilieu (+ a_ff angle) (* (/ EchelleObjetsKPenteTexteProfil 100.0) l_ff))
											(polar pointmilieu (+ (- PI a_ff) angle) (* (/ EchelleObjetsKPenteTexteProfil 100.0) l_ff))
											)) ;; if cons
										) ;; entmakex
									)
								(entmakex 
									(list 
										(cons 0 "MTEXT")
										;;(cons 8 calque)
										(cons 100 "AcDbEntity")
										(cons 100 "AcDbMText")
										(cons 10 (polar pointmilieu (+ a_t angle) (* (/ EchelleObjetsKPenteTexteProfil 100.0) l_t)))	;;point d'insertion
										(cons 40 (* (/ EchelleObjetsKPenteTexteProfil 100.0) HauteurTexteKPenteTexteProfil))
										(cons 41 2.0)
										(cons 71 8)
										(cons 1 texte)
										(cons 7 style)
										(cons 50 angle)
										)
									)
								) ;;fin de si oui
							(quit) ;;sinon
							);; fin de if
						);; fin de if
					);; fin de if
				);; fin de if
			);; fin de if
		);; fin de while
		
;; Futures modifications:
;; Ajouter pr�fixe/suffixe
	)	

	
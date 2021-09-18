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
	(if (= (car ListeATrier) "ksituation_to_devers_1voie")
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
			;; (setq khello nil)			
			(setq ListeATrier (cdr ListeATrier))
			(while (> (length ListeATrier) 0)
				(setq Profil (car ListeATrier))
				
				(setq EGB (nth 0 Profil))
				(setq LGB (nth 1 Profil))
				(setq EGM (nth 2 Profil))
				(setq LGM (nth 3 Profil))
				(setq EGI (nth 4 Profil))
				
				(setq HGB (- EGB EGM))
				(setq HGM (- EGM EGI))
				
				(setq PeGB (* (/ HGB LGB) 100))
				(setq PeGM (* (/ HGM LGM) 100))

				
				(if (> PeGB 0)
					(setq TPeGB (strcat "+" (rtos PeGB 2 2)))
					(setq TPeGB (rtos PeGB 2 2))
					)
				(if (> PeGM 0)
					(setq TPeGM (strcat "+" (rtos PeGM 2 2)))
					(setq TPeGM (rtos PeGM 2 2))
					)
				
				(if (> (+ HGM HGB) 0)
					(setq THGB (strcat "+" (rtos (* (+ HGM HGB) 1000) 2 0)))
					(setq THGB (rtos (* (+ HGM HGB) 1000) 2 0))
					)
				(if (> HGM 0)
					(setq THGM (strcat "+" (rtos (* HGM 1000) 2 0)))
					(setq THGM (rtos (* HGM 1000) 2 0))
					)
				
				(setq TGB (strcat THGB "mm  (" TPeGB "%)"))
				(setq TGM (strcat THGM "mm  (" TPeGM "%)"))

				
				(setq PpGB (list (+ (car PointDepart) (* NumeroProfil DistanceProfil)) (+ (cadr PointDepart) (* (+ HGM HGB) 100)) 0.0))
				(setq PpGM (list (+ (car PointDepart) (* NumeroProfil DistanceProfil)) (+ (cadr PointDepart) (* HGM 100)) 0.0))

				
				(setq LPpGB (append LPpGB (list (cons 10 PpGB))))
				(setq LPpGM (append LPpGM (list (cons 10 PpGM))))
				
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
			)
		)
	(if (or (= (car ListeATrier) "ksituation_to_devers_RC") (= (car ListeATrier) "kprofil_to_devers_RC"))
		(progn
			
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
				
				(setq EGM (nth 0 Profil))
				(setq LGM (nth 1 Profil))
				(setq EGI (nth 2 Profil))
				(setq EDI (nth 3 Profil))
				(setq LDM (nth 4 Profil))
				(setq EDM (nth 5 Profil))

				

				(setq HGM (- EGM EGI))
				(setq HDM (- EDM EDI))

				

				(setq PeGM (* (/ HGM LGM) 100))
				(setq PeDM (* (/ HDM LDM) 100))

				

				(if (> PeGM 0)
					(setq TPeGM (strcat "+" (rtos PeGM 2 2)))
					(setq TPeGM (rtos PeGM 2 2))
					)
				(if (> PeDM 0)
					(setq TPeDM (strcat "+" (rtos PeDM 2 2)))
					(setq TPeDM (rtos PeDM 2 2))
					)

				

				(if (> HGM 0)
					(setq THGM (strcat "+" (rtos (* HGM 1000) 2 0)))
					(setq THGM (rtos (* HGM 1000) 2 0))
					)
				(if (> HDM 0)
					(setq THDM (strcat "+" (rtos (* HDM 1000) 2 0)))
					(setq THDM (rtos (* HDM 1000) 2 0))
					)

				(setq TGM (strcat THGM "mm  (" TPeGM "%)"))
				(setq TDM (strcat THDM "mm  (" TPeDM "%)"))

				(setq PpGM (list (+ (car PointDepart) (* NumeroProfil DistanceProfil)) (+ (cadr PointDepart) (* HGM 100)) 0.0))
				(setq PpDM (list (+ (car PointDepart) (* NumeroProfil DistanceProfil)) (+ (cadr PointDepart) (* HDM 100)) 0.0))

			
				(setq LPpGM (append LPpGM (list (cons 10 PpGM))))
				(setq LPpDM (append LPpDM (list (cons 10 PpDM))))
				
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
						(cons 8 "S+N - klisp - Droite - Marquage")
						(cons 100 "AcDbPolyline")
						(cons 90 (length LPpDM))
						(cons 70 0)
						)
					LPpDM
					)
				)
			)
		)
	)
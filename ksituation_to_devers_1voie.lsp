(defun C:ksituation_to_devers_1voie ()
	(defun au_carre (x) (* x x))
	(if (= ktransfert nil)
		(setq ktransfert (list "ksituation_to_devers_1voie"))
		)
	(while (setq PGB (getpoint "\nSéléctionner le premier point du profil (bord de la BAU) ou [Enter] pour finir: "))
		(setq PGM (getpoint "\nSéléctionner le point sur le marquage: "))
		(setq PGI (getpoint "\nSéléctionner le point sur le bord interne de la voie: "))
		
		(setq LGB (sqrt (+ (au_carre (- (car PGM) (car PGB))) (au_carre (- (cadr PGM) (cadr PGB))))))
		(setq LGM (sqrt (+ (au_carre (- (car PGI) (car PGM))) (au_carre (- (cadr PGI) (cadr PGM))))))

		(setq profil (list (caddr PGB) LGB (caddr PGM) LGM (caddr PGI)))
		(setq ktransfert (append ktransfert (list profil)))
		)
	)
	
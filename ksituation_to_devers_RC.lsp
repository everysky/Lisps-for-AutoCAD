(defun C:ksituation_to_devers ()
	(defun au_carre (x) (* x x))
	(if (= ktransfert nil)
		(setq ktransfert (list "ksituation_to_devers_RC"))
		)
	(while (setq PGM (getpoint "\nSéléctionner le premier point du profil (bord de la voie de gauche) ou [Enter] pour finir: "))
		(setq PGI (getpoint "\nSéléctionner le point sur le bord interne de la voie de gauche: "))
		(setq PDI (getpoint "\nSéléctionner le point sur le bord interne de la voie de droite: "))
		(setq PDM (getpoint "\nSéléctionner le point sur le bord de la voie de droite: "))
		

		(setq LGM (sqrt (+ (au_carre (- (car PGI) (car PGM))) (au_carre (- (cadr PGI) (cadr PGM))))))
		(setq LDM (sqrt (+ (au_carre (- (car PDI) (car PDM))) (au_carre (- (cadr PDI) (cadr PDM))))))


		(setq profil (list (caddr PGM) LGM (caddr PGI) (caddr PDI) LDM (caddr PDM)))
		(setq ktransfert (append ktransfert (list profil)))
		)
	)
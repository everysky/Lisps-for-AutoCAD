(defun C:kprofil_to_devers_RC ()
	(if (= ktransfert nil)
		(setq ktransfert (list "kprofil_to_devers_RC"))
		)
	(while (setq PG (getpoint "\nSéléctionner le premier point du profil (bord de la voie de gauche) ou [Enter] pour finir: "))
		(setq PA (getpoint "\nSéléctionner le point sur l'axe: "))
		(setq PD (getpoint "\nSéléctionner le point sur le bord de la voie de droite: "))
		

		(setq LG (abs (- (car pg) (car pa))))
		(setq LD (abs (- (car pa) (car pd))))


		(setq profil (list (cadr PG) LG (cadr PA) (cadr PA) LD (cadr PD)))
		(setq ktransfert (append ktransfert (list profil)))
		)	
	)
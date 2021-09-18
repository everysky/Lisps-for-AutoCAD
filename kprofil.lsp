(defun C:kprofil ()
;;	(initget 7 "Toit Gauche Droite")
;;	(setq choix (getkword "\nChoisissez le type de profil [Toit/Gauche/Droite]: "))
;;	(if (= choix "Toit")
		(setq pointAxe (getpoint "\nChoisissez un point sur l'axe du profil: "))
		(setq pointToit (getpoint "\nCliquer sur le point du sommet du Toit: "))
		(setq pointGauche (getpoint "\nCliquer sur le point gauche de la chaussée: "))
		(setq pointDroite (getpoint "\nCliquer sur le point droite de la chaussée: "))
		
		(setq AxeToit (- (car pointToit) (car pointAxe)))
		(setq ToitGauche (list (- (car pointGauche) (car pointToit)) (- (cadr pointGauche) (cadr pointToit))))
		(setq ToitDroite (list (- (car pointDroite) (car pointToit)) (- (cadr pointDroite) (cadr pointToit))))
		
		(setq profil (list "t" AxeToit ToitGauche ToitDroite))
		(setq ktransfert (list profil))
		
		(while (setq pointAxe (getpoint "\nChoisissez un point sur l'axe du profil ou ENTER: "))
			(setq pointToit (getpoint "\nCliquer sur le point du sommet du Toit: "))
			(setq pointGauche (getpoint "\nCliquer sur le point gauche de la chaussée: "))
			(setq pointDroite (getpoint "\nCliquer sur le point droite de la chaussée: "))
			
			(setq AxeToit (- (car pointToit) (car pointAxe)))
			(setq ToitGauche (list (- (car pointGauche) (car pointToit)) (- (cadr pointGauche) (cadr pointToit))))
			(setq ToitDroite (list (- (car pointDroite) (car pointToit)) (- (cadr pointDroite) (cadr pointToit))))
			
			(setq profil (list "t" AxeToit ToitGauche ToitDroite))
			(setq ktransfert (append ktransfert (list profil)))
			)
		)
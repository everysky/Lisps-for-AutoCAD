(defun C:ksituation ( )

	(setq pointAxe nil)
	(setq pointtruc nil)
	(setq distance nil)
	(setq coupe nil)
	(setq ktransfert2 nil)
	
	(setq pointAxe (getpoint "\nChoisissez un point sur l'axe du profil: "))
	(setq coupe (list 1))
	(while (setq pointtruc (getpoint pointAxe "\nChoisissez un point sur l'objet que vous voulez mesurer ou ENTER pour passer au profil suivant: "))
		(setq distance (* -1.0 (- (cadr pointtruc) (cadr pointAxe))))
		(setq coupe (append coupe (list distance)))
		(setq distance nil)
		)
	(setq ktransfert2 (list coupe))
	(setq coupe nil)
	(while (setq pointAxe (getpoint "\nChoisissez un point sur l'axe du profil ou ENTER pour finir: "))
		(while (setq pointtruc (getpoint pointAxe "\nChoisissez un point sur l'objet que vous voulez mesurer ou ENTER pour passer au profil suivant: "))
			(setq distance (* -1.0 (- (cadr pointtruc) (cadr pointAxe))))
			(setq coupe (append coupe (list distance)))
			(setq distance nil)
			)
		(setq ktransfert2 (append ktransfert2 (list coupe)))
		(setq coupe nil)
		)
	)
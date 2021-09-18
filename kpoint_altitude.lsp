(defun C:kpoint_altitude ()
	(while 
		(/= nil (setq ent (car (entsel "\nSelectionnez l'objet dont vous voulez changer l'altitude:"))))
		(setq 
			lstdxf (entget ent)
			entType (cdr (assoc 0 lstdxf))
			)
		(if 
			(or
				(= entType "POINT")
				(= entType "CIRCLE")
				)
			
			(progn
				(initget 1)
				(setq point (getpoint "\nSelectionnez le point representant la nouvelle altitude:"))
				(setq
					centre (cdr (assoc 10 lstdxf))
					centre (list (car centre) (cadr centre) (cadr point))
					lstdxf (subst (cons 10 centre) (assoc 10 lstdxf) lstdxf)
					)
				(entmod lstdxf)
				)
			(prompt "\nL'objet selectionné n'est ni un point, ni un cercle!")
			)
		)
	)
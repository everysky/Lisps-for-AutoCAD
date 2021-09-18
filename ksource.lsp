(defun C:ksource ()
	(setq hauteur 10)
	(setq decalage 10)
	(setq text (getstring T "\nEntrez le texte voulu: "))
	(setq point1 (getpoint "\nSelectionnez le coin en hauit à gauche: "))
	(setq point2 (getpoint "\nSelectionnez le coin en bas à droite: "))
	
	
	(entmakex	;; texte haut
		(list
			(cons 0 "TEXT")
			(cons 10 (list 0.0 0.0 0.0))
			(cons 40 hauteur)								;; hauteur de texte
			(cons 1 text)								;; le texte
			(cons 41 1.00)
			(cons 7 "Standard")
			(cons 72 1)
			(cons 73 2)
			(cons 11 (list (/ (+ (car point1) (car point2)) 2.0) (- (cadr point1) decalage) 0.0))
			)
		)
	(entmakex	;; texte droite
		(list
			(cons 0 "TEXT")
			(cons 10 (list 0.0 0.0 0.0))
			(cons 40 hauteur)								;; hauteur de texte
			(cons 1 text)								;; le texte
			(cons 50 (/ pi 2.0))						;; rotation du texte
			(cons 41 1.00)
			(cons 7 "Standard")
			(cons 72 1)
			(cons 73 2)
			(cons 11 (list (- (car point2) decalage) (/ (+ (cadr point1) (cadr point2)) 2.0) 0.0))
			)
		)
	(entmakex	;; texte bas
		(list
			(cons 0 "TEXT")
			(cons 10 (list 0.0 0.0 0.0))
			(cons 40 hauteur)								;; hauteur de texte
			(cons 1 text)								;; le texte
			(cons 41 1.00)
			(cons 7 "Standard")
			(cons 72 1)
			(cons 73 2)
			(cons 11 (list (/ (+ (car point1) (car point2)) 2.0) (+ (cadr point2) decalage) 0.0))
			)
		)
	(entmakex	;; texte gauche
		(list
			(cons 0 "TEXT")
			(cons 10 (list 0.0 0.0 0.0))
			(cons 40 hauteur)								;; hauteur de texte
			(cons 1 text)								;; le texte
			(cons 50 (/ pi 2.0))						;; rotation du texte
			(cons 41 1.00)
			(cons 7 "Standard")
			(cons 72 1)
			(cons 73 2)
			(cons 11 (list (+ (car point1) decalage) (/ (+ (cadr point1) (cadr point2)) 2.0) 0.0))
			)
		)
	)
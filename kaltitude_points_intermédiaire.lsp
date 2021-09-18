(defun C:kaltitude_points_intermediaire ()
	
	(defun AuCarre (asdf) (* asdf asdf))
	(defun Distance (qwertz1 qwertz2) (sqrt (+ (AuCarre (- (car qwertz1) (car qwertz2))) (AuCarre (- (cadr qwertz1) (cadr qwertz2))))))
	(defun Angle (yxcv1 yxcv2) (atan (- (cadr yxcv2) (cadr yxcv1)) (- (car yxcv2) (car yxcv1))))
	
	(setq int 1)
	(while (< int 5)
	
		(if (= int 1)
			(progn 
				(setq TexteP1 "\nChoisissez le premier point: ")
				(initget 1)
				(setq P1 (getpoint TexteP1))
				(setq int (+ int 1))
				
				(prompt (strcat
					"\nAltitude du premier point : "
					(rtos (caddr P1) 2 3)
					))
				)
			)

		(if (= int 2)
			(progn
				(setq TexteP2 "\nChoisissez le deuxième point ou [annUler] (retour au premier point) ")
					
				(initget 1 "annUler")	
				(setq P2 (getpoint P1 TexteP2))
				(if (= P2 "annUler")
					(setq int (- int 1))
					(progn
						(setq int (+ int 1))
						(prompt (strcat
							"\nAltitude du deuxième point : "
							(rtos (caddr P2) 2 3)
							))
						)				
					)
				)
			)
			
		(if (= int 3)
			(progn
				(setq TexteP3 "\nChoisissez un point intérmédiaire ou [annUler] (retour au deuxième point) ")
					
				(initget 1 "annUler")	
				(setq P3Temp (getpoint TexteP3))
				(if (= P3Temp "annUler")
					(setq int (- int 1))
					(progn
						(setq int (+ int 1))
						
						(setq
							DifferenceAltitudeP2_P1 (- (caddr P2) (caddr P1))
							DistanceP2_P1 (distance P2 P1)
							DistanceP2_P3Temp (Distance P2 P3Temp)
							AngleP2_P1 (Angle P2 P1)
							AngleP2_P3Temp (Angle P2 P3Temp)
							AngleSommetP2 (- AngleP2_P1 AngleP2_P3Temp)
							DistanceP2_P3Final (* (cos AngleSommetP2) DistanceP2_P3Temp)
							P3Final (polar P2 AngleP2_P1 DistanceP2_P3Final)
							P3Final (list (car P3Final) (cadr P3Final) (- (caddr P2) (* (/ DifferenceAltitudeP2_P1 DistanceP2_P1) DistanceP2_P3Final)))
							)
							
						(prompt (strcat
							"\nAltitude du point intermédiaire : "
							(rtos (caddr P3Final) 2 3)
							))
						)
					)
				)
			)
			
		(if (= int 4)
			(while 
				(and
					(not (= P3Temp "annUler"))
					(< int 5)
					)
					
				(setq TexteP3 "\nChoisissez un autre point intermédiaire ou [annUler] (retour au deuxième point) ")
					
				(initget "annUler")	
				(setq P3Temp (getpoint TexteP3))
				
				(if (= P3Temp "annUler")
					(setq int (- int 2))
					
					(if (= P3Temp nil)
						(setq int (+ int 1))
						
						(progn
							(setq
								DifferenceAltitudeP2_P1 (- (caddr P2) (caddr P1))
								DistanceP2_P1 (distance P2 P1)
								DistanceP2_P3Temp (Distance P2 P3Temp)
								AngleP2_P1 (Angle P2 P1)
								AngleP2_P3Temp (Angle P2 P3Temp)
								AngleSommetP2 (- AngleP2_P1 AngleP2_P3Temp)
								DistanceP2_P3Final (* (cos AngleSommetP2) DistanceP2_P3Temp)
								P3Final (polar P2 AngleP2_P1 DistanceP2_P3Final)
								P3Final (list (car P3Final) (cadr P3Final) (- (caddr P2) (* (/ DifferenceAltitudeP2_P1 DistanceP2_P1) DistanceP2_P3Final)))
								)
							
							(prompt (strcat
								"\nAltitude du point intermédiaire : "
								(rtos (caddr P3Final) 2 3)
								))
							)
						)
					)
				)
			)
		)	
	)
			
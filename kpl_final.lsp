;;kpl

(defun C:kpl ( )
	(if 
		(or
			(= echelle nil)
			(= facteur nil)
			(= origine nil)
			(= kiloorigine nil)
			(= horizon nil)
			)
		(alert "Bonjour,
			\nVous lancez pour la première fois cette commande (ou la commande à été annulé au mauvais moment).
			\nMerci de lire ce message jusqu'au bout pour le bon fonctionnement de la commande.
			\nQuelques données doivent être saisies avant de pouvoir utiliser les différentes fonctions de cette commande.
			\nTant que le plan est ouvert, ces données de base n'auront pas besoin dêtre re-saisies à chaque fois que la commande est lancées.
			\nVous pouvez modifier ces données de base plus tard, si vous vous êtes trompé ou si vous voulez les changer.
			\nATTENTION -- recommandation d'utilisation -- ATTENTTION
			\nToujours être en SCU général lors de la commande"
			)
		)
		;; entrées utilisateur de base
	(if (= echelle nil)
		(setq echelle (getreal "\nDéfinissez l'echelle du texte (ex: 1:500 => 500): "))
		)
	(if (= facteur nil)
		(setq facteur (getreal "\nDéfinissez le facteur d'agrandissement de l'axe vértical (ex: si les echelles sont 1:500//50, alors le facteur est de 10): "))
		)
	(if (= origine nil)
		(setq origine (getpoint "\nDéfinissez le point qui est en même temps l'origine du kilométrage et l'horizon: "))
		)
	(if (= kiloorigine nil)
		(setq kiloorigine (getreal "\nDéfinissez le kilomètrage à l'origine: "))
		)
	(if (= horizon nil)
		(setq horizon (getreal "\nDéfinissez l'altitude de l'horizon: "))
		)
		
;;création des calques

		(if (= (tblsearch "LAYER" "pl_piano_texte_025") nil) 
			(entmake (list
				(cons 0 "LAYER")
				(cons 100 "AcDbSymbolTableRecord")
				(cons 100 "AcDbLayerTableRecord")
				(cons 2 "pl_piano_texte_025")				;; nom du calque
				(cons 70 0)
				(cons 62 7)							;; couleur du calque
				(cons 6 "CONTINUOUS")					;; type de ligne 
				))
			)
			
		(if (= (tblsearch "LAYER" "pl_piano_texte_018") nil) 
			(entmake (list
				(cons 0 "LAYER")
				(cons 100 "AcDbSymbolTableRecord")
				(cons 100 "AcDbLayerTableRecord")
				(cons 2 "pl_piano_texte_018")				;; nom du calque
				(cons 70 0)
				(cons 62 1)							;; couleur du calque
				(cons 6 "CONTINUOUS")					;; type de ligne 
				))
			)
		
		(if (= (tblsearch "LAYER" "pl_piano_ligne_018") nil) 
			(entmake (list
				(cons 0 "LAYER")
				(cons 100 "AcDbSymbolTableRecord")
				(cons 100 "AcDbLayerTableRecord")
				(cons 2 "pl_piano_ligne_018")				;; nom du calque
				(cons 70 0)
				(cons 62 1)							;; couleur du calque
				(cons 6 "CONTINUOUS")					;; type de ligne 
				))
			)
			
;;variables de base
			
		(setq tkcalque "pl_piano_texte_025")
		(setq tkhauteur 2.50)
		(setq tkdecalagehorizontal 2.00)
		(setq lkcalque "pl_piano_ligne_018")
		

		(setq tatcalque "pl_piano_texte_018")
		(setq tathauteur 2.50)
		(setq tatdecalagehorizontal 2.00)
		(setq latcalque "pl_piano_ligne_018")

		
		(setq tapcalque "pl_piano_texte_025")
		(setq taphauteur 2.50)
		(setq tapdecalagehorizontal 2.00)
		(setq lapcalque "pl_piano_ligne_018")
	

		;; enfin
		
	(initget  6 "Projet Terrain Kilométrage Variables")
	(setq option (getkword "\nOptions [Projet/Terrain/Kilométrage/Variables]: "))
	(if (= option "Projet")
		(progn
;; vérification que la zone d'altitude du projet est bien délimitée
			(if 
				(or 
					(= coinprojetalthaut nil)
					(= coinprojetaltbas nil)
					)
				(progn
					(alert "\nVous avez choisi l'option\"projet\" pour la première fois ouu la commande a rencontrer un problème précedement et il manque des données.
					\nVous allez devoir Délimiter la zone du piano dans laquelle vont se créer les textes pour l'altitude du projet")
					(setq coinprojetaltbas (getcorner (setq coinprojetalthaut (getpoint "\nSelectionnez le premier coin de la zone du piano pour l'altitude du projet: ")) "\nSelectionner le deuxième coin de la zone: "))
					(if (> (cadr coinprojetaltbas) (cadr coinprojetalthaut))
						(setq 
							temp coinprojetaltbas
							coinprojetaltbas coinprojetalthaut
							coinprojetalthaut temp
							temp nil
							)
						)
					)
				)
			(alert "\nVous allez pouvoir selectionner les points du projet dont vous voulez l'altitude.
			\nSelectionnez les points les uns après le autres et pressez ENTER quand vous voulez finir la commande.")	
			(while (setq point (getpoint "\nChoisissez un nopuveau point (ou ENTER pour finir la commande): "))
				(setq 
					os (getvar "osmode")
					dim (getvar "dimzin")
					)
				(setvar "osmode" 0)
				(setvar "dimzin" 0)
				
				(setq altitude (+ horizon (/ (- (cadr point) (cadr origine)) facteur)))
				(setq altitudetexte (rtos altitude 2 2))
				(print altitudetexte)
				(setq hauteurtexteprojet (* echelle (/ tkhauteur 1000.0)))
				(setq positionaltitudetexte (list (+ (car point) (* echelle (/ tapdecalagehorizontal 1000.00))) (/ (+ (cadr coinprojetalthaut) (cadr coinprojetaltbas)) 2.00) 0.0))
				(entmakex 
					(list
						(cons 0 "TEXT")
						(cons 8 tapcalque)
						(cons 10 (list 0.0 0.0 0.0))
						(cons 40 hauteurtexteprojet)
						(cons 1 altitudetexte)
						(cons 50 4.71238898)
						(cons 41 1.00)
						(cons 7 "Standard")
						(cons 72 1)
						(cons 73 2)
						(cons 11 positionaltitudetexte)
						)
					)
				(entmakex
					(list
						(cons 0 "LWPOLYLINE")
						(cons 100 "AcDbEntity")
						(cons 8 lapcalque)
						(cons 100 "AcDbPolyline")
						(cons 90 2)					
						(cons 70 0)
						(cons 10 (list (car point) (cadr coinprojetalthaut) 0.0))
						(cons 10 (list (car point) (cadr coinprojetaltbas) 0.0))
						)
					)
				
				(setvar "osmode" os)
				(setvar "dimzin" dim)
				)
			(setq option nil)
			)
		)

	(if (= option "Terrain")
		(progn
;; vérification que la zone d'altitude du terrain est bien délimitée
			(if 
				(or 
					(= cointerrainalthaut nil)
					(= cointerrainaltbas nil)
					)
				(progn
					(alert "\nVous avez choisi l'option\"terrain\" pour la première fois ou la commande a rencontrer un problème précedement et il manque des données.
					\nVous allez devoir délimiter la zone du piano dans laquelle vont se créer les textes pour l'altitude du terrain")
					(setq cointerrainaltbas (getcorner (setq cointerrainalthaut (getpoint "\nSelectionnez le premier coin de la zone du piano pour l'altitude du terrain: ")) "\nSelectionner le deuxième coin de la zone: "))
					(if (> (cadr cointerrainaltbas) (cadr cointerrainalthaut))
						(setq 
							temp cointerrainaltbas
							cointerrainaltbas cointerrainalthaut
							cointerrainalthaut temp
							temp nil
							)
						)
					)
				)
			(alert "\nVous allez pouvoir selectionner les points du terrain dont vous voulez l'altitude.
			\nSelectionnez les points les uns après le autres et pressez ENTER quand vous voulez finir la commande.")	
			(while (setq point (getpoint "\nChoisissez un nopuveau point (ou ENTER pour finir la commande): "))
				(setq 
					os (getvar "osmode")
					dim (getvar "dimzin")
					)
				(setvar "osmode" 0)
				(setvar "dimzin" 0)
				
				(setq altitude (+ horizon (/ (- (cadr point) (cadr origine)) 10)))
				(setq altitudetexte (rtos altitude 2 2))
				(print altitudetexte)
				(setq hauteurtexteterrain (* echelle (/ tkhauteur 1000.0)))
				(setq positionaltitudetexte (list (+ (car point) (* echelle (/ tatdecalagehorizontal 1000.00))) (/ (+ (cadr cointerrainalthaut) (cadr cointerrainaltbas)) 2.00) 0.0))
				(entmakex 
					(list
						(cons 0 "TEXT")
						(cons 8 tatcalque)
						(cons 10 (list 0.0 0.0 0.0))
						(cons 40 hauteurtexteterrain)
						(cons 1 altitudetexte)
						(cons 50 4.71238898)
						(cons 41 1.00)
						(cons 51 0.261799)
						(cons 7 "Standard")
						(cons 72 1)
						(cons 73 2)
						(cons 11 positionaltitudetexte)
						)
					)
				(entmakex
					(list
						(cons 0 "LWPOLYLINE")
						(cons 100 "AcDbEntity")
						(cons 8 latcalque)
						(cons 100 "AcDbPolyline")
						(cons 90 2)					
						(cons 70 0)
						(cons 10 (list (car point) (cadr cointerrainalthaut) 0.0))
						(cons 10 (list (car point) (cadr cointerrainaltbas) 0.0))
						)
					)
				
				(setvar "osmode" os)
				(setvar "dimzin" dim)
				)
			(setq option nil)
			)
		)
	(if (= option "Kilométrage")
		(progn
;; vérification que la zone d'altitude du terrain est bien délimitée
			(if 
				(or
					(= coinprojetkilohaut nil)
					(= coinprojetkilobas nil)
					)
				(progn
					(alert "\nVous avez choisi l'option\"Kilométrage\" pour la première fois ou la commande a rencontrer un problème précedement et il manque des données.
					\nVous allez devoir délimiter la zone du piano dans laquelle vont se créer les textes pour le kilométrage")
					(setq coinprojetkilobas (getcorner (setq coinprojetkilohaut (getpoint "\nSelectionnez le premier coin de la zone du piano pour le kilométrage: ")) "\nSelectionner le deuxième coin de la zone: "))
					(if (> (cadr coinprojetkilobas) (cadr coinprojetkilohaut))
						(setq 
							temp coinprojetkilobas
							coinprojetkilobas coinprojetkilohaut
							coinprojetkilohaut temp
							temp nil
							)
						)
					)
				)
			(alert "\nVous allez pouvoir selectionner les points dont vous voulez le kilométrage.
			\nSelectionnez les points les uns après le autres et pressez ENTER quand vous voulez finir la commande.")	
			(while (setq point (getpoint "\nChoisissez un nopuveau point (ou ENTER pour finir la commande): "))
				(setq 
					os (getvar "osmode")
					dim (getvar "dimzin")
					)
				(setvar "osmode" 0)
				(setvar "dimzin" 0)
				
				(setq kilo  (+ kiloorigine (- (car point) (car origine))))
				(setq kilometragetexte (rtos kilo 2 2))
				(print kilometragetexte)
				(setq hauteurtextekilometrage (* echelle (/ tkhauteur 1000.0)))
				(setq positionkilometragetexte (list (+ (car point) (* echelle (/ tkdecalagehorizontal 1000.00))) (/ (+ (cadr coinprojetkilohaut) (cadr coinprojetkilobas)) 2.00) 0.0 ))
				(entmakex 
					(list
						(cons 0 "TEXT")
						(cons 8 tkcalque)
						(cons 10 (list 0.0 0.0 0.0))
						(cons 40 hauteurtextekilometrage)
						(cons 1 kilometragetexte)
						(cons 50 4.71238898)
						(cons 41 1.00)
						(cons 7 "Standard")
						(cons 72 1)
						(cons 73 2)
						(cons 11 positionkilometragetexte)
						)
					)
				(entmakex
					(list
						(cons 0 "LWPOLYLINE")
						(cons 100 "AcDbEntity")
						(cons 8 lkcalque)
						(cons 100 "AcDbPolyline")
						(cons 90 2)					
						(cons 70 0)
						(cons 10 (list (car point) (cadr coinprojetkilohaut) 0.0))
						(cons 10 (list (car point) (cadr coinprojetkilobas) 0.0))
						)
					)
				
				(setvar "osmode" os)
				(setvar "dimzin" dim)
				)
			(setq option nil)
			)
		)
	(if (= option "Variables")
		(progn
			(initget 6 "Echelle Facteur Origine Kilométrage Horizon Zones")
			(setq variable (getkword "\nQue voulez-vous redéfinir? [Echelle du texte/Facteur d'agradissement/point d'Origine/Kilométrage à l'origine/altitude de l'Horizon/les différentes Zones du piano]: "))
			(if (= variable "Echelle")
				(setq echelle (getreal "\nDéfinissez l'echelle du texte (ex: 1:500 => 500): ") variable nil)
				)
			(if (= variable "Facteur")
				(setq facteur (getreal "\nDéfinissez le facteur d'agrandissement de l'axe vértical (ex: si les echelles sont 1:500//50, alors le facteur est de 10): ") variable nil)
				)
			(if (= variable "Origine")
				(setq origine (getpoint "\nDéfinissez le point qui est en même temps l'origine du kilométrage et l'horizon: ") variable nil)
				)
			(if (= variable "Kilométrage")
				(setq kiloorigine (getreal "\nDéfinissez le kilomètrage à l'origine: ") variable nil)
				)
			(if (= variable "Horizon")
				(setq horizon (getreal "\nDéfinissez l'altitude de l'horizon: ") variable nil)
				)
			(if (= variable "Zones")
				(progn
					(initget 6 "Kilométrage Projet Terrain")
					(setq zone (getkword "\nQuelle zone voulez-vous redéfinir? [zone pour le Kilométrage/zone pour l'altitude du Projet/zone pour l'altitude du Terrain]: "))
					(if (= zone "Kilométrage")
						(progn
							(setq coinprojetkilobas (getcorner (setq coinprojetkilohaut (getpoint "\nSelectionnez le premier point de la zone du piano pour le kilométrage: ")) "\nSelectionner le deuxième point de la zone: "))
							(if (> (cadr coinprojetkilobas) (cadr coinprojetkilohaut))
								(setq 
									temp coinprojetkilobas
									coinprojetkilobas coinprojetkilohaut
									coinprojetkilohaut temp
									temp nil
									)
								)
							(setq zone nil)
							)
						)
					(if (= zone "Projet")
						(progn
							(setq coinprojetaltbas (getcorner (setq coinprojetalthaut (getpoint "\nSelectionnez le premier point de la zone du piano pour l'altitude du projet: ")) "\nSelectionner le deuxième point de la zone: "))
							(if (> (cadr coinprojetaltbas) (cadr coinprojetalthaut))
								(setq 
									temp coinprojetaltbas
									coinprojetaltbas coinprojetalthaut
									coinprojetalthaut temp
									temp nil
									)
								)
							(setq zone nil)
							)
						)
					(if (= zone "Terrain")
						(progn
							(setq cointerrainaltbas (getcorner (setq cointerrainalthaut (getpoint "\nSelectionnez le premier point de la zone du piano pour l'altitude du terrain: ")) "\nSelectionner le deuxième point de la zone: "))
							(if (> (cadr cointerrainaltbas) (cadr cointerrainalthaut))
								(setq 
									temp cointerrainaltbas
									cointerrainaltbas cointerrainalthaut
									cointerrainalthaut temp
									temp nil
									)
								)
							(setq zone nil)
							)
						)
					(setq variable nil)
					)
				)
			(setq option nil)
			)
		)
	)

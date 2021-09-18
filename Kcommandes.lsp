(defun C:Kcommandes ()
;;cette version est faite pour S+N 
;;load cette commande ici: "M:/Modèles/Autocad/LISP/kcommandes"

	(setq emplacement1 "M:/Modèles/Autocad/LISP/")
	
	;;(prompt "\nChargement des commandes générales: ")										;; Commandes générales
	;;(load (strcat emplacement1 "Kpente"))																			;; Kpente
	;;(if
		;;c:Kpente
		;;(prompt "\n\"Kpente\" chargée.")
		;;(prompt "\nPROBLEME. La commande \"Kpente\" n'a pas pu être chargée.")
		;;)
	
	(prompt "\nChargement des commandes en situation: ")									;; Commandes en situation
	(load (strcat emplacement1 "kaltitude_en_situation"))															;; kaltitude_en_situation
	(if
		c:kaltitude_en_situation
		(prompt "\n\"kaltitude_en_situation\" chargée.")
		(prompt "\nPROBLEME. La commande \"kaltitude_en_situation\" n'a pas pu être chargée.")
		)
	(load (strcat emplacement1 "kpente_texte_situation"))															;; kpente_texte_situation
	(if
		c:kpente_texte_situation
		(prompt "\n\"kpente_texte_situation\" chargée.")
		(prompt "\nPROBLEME. La commande \"kpente_texte_situation\" n'a pas pu être chargée.")
		)
	(load (strcat emplacement1 "kpente_texte_situation_forcee"))													;; kpente_texte_situation_forcee
	(if
		c:kpente_texte_situation_forcee
		(prompt "\n\"kpente_texte_situation_forcee\" chargée.")
		(prompt "\nPROBLEME. La commande \"kpente_texte_situation_forcee\" n'a pas pu être chargée.")
		)
	(load (strcat emplacement1 "ktri_courbes_de_niveaux"))															;; ktri_courbes_de_niveaux
	(if
		c:ktri_courbes_de_niveaux
		(prompt "\n\"ktri_courbes_de_niveaux\" chargée.")
		(prompt "\nPROBLEME. La commande \"ktri_courbes_de_niveaux\" n'a pas pu être chargée.")
		)
	(load (strcat emplacement1 "ktri_chambre_EC-EU"))																;; ktri_chambre_EC-EU
	(if
		c:ktri_chambre_EC-EU
		(prompt "\n\"ktri_chambre_EC-EU\" chargée.")
		(prompt "\nPROBLEME. La commande \"ktri_chambre_EC-EU\" n'a pas pu être chargée.")
		)
	(load (strcat emplacement1 "ksource"))																			;; ksource
	(if
		c:ksource
		(prompt "\n\"ksource\" chargée.")
		(prompt "\nPROBLEME. La commande \"ksource\" n'a pas pu être chargée.")
		)
	(load (strcat emplacement1 "kbordure_points"))																	;; kbordure_points
	(if
		c:kbordure_points
		(prompt "\n\"kbordure_points\" chargée.")
		(prompt "\nPROBLEME. La commande \"kbordure_points\" n'a pas pu être chargée.")
		)
	(load (strcat emplacement1 "kbordure_arc"))																		;; kbordure_arc
	(if
		c:kbordure_arc
		(prompt "\n\"kbordure_arc\" chargée.")
		(prompt "\nPROBLEME. La commande \"kbordure_arc\" n'a pas pu être chargée.")
		)
	(load (strcat emplacement1 "kbordure_geometrie"))																;; kbordure_geometrie
	(if
		c:kbordure_geometrie
		(prompt "\n\"kbordure_geometrie\" chargée.")
		(prompt "\nPROBLEME. La commande \"kbordure_geometrie\" n'a pas pu être chargée.")
		)
	
	(prompt "\nChargement des commandes pour les profils:")									;; Commandes pour les profils
	(load (strcat emplacement1 "kjag_avant_metree_polyligne"))														;; kjag_avant_metree_polyligne
	(if
		c:kjag_avant_metree_polyligne
		(prompt "\n\"kjag_avant_metree_polyligne\" chargée.")
		(prompt "\nPROBLEME. La commande \"kjag_avant_metree_polyligne\" n'a pas pu être chargée.")
		)
	(load (strcat emplacement1 "kpente_texte_profil"))																;; kpente_texte_profil
	(if
		c:kpente_texte_profil
		(prompt "\n\"kpente_texte_profil\" chargée.")
		(prompt "\nPROBLEME. La commande \"kpente_texte_profil\" n'a pas pu être chargée.")
		)
	(load (strcat emplacement1 "kpente_texte_PL"))																	;; kpente_texte_PL
	(if
		c:kpente_texte_PL
		(prompt "\n\"kpente_texte_PL\" chargée.")
		(prompt "\nPROBLEME. La commande \"kpente_texte_PL\" n'a pas pu être chargée.")
		)
	(prompt "\nFin du chargement des commandes")
	)
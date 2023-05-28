extends Node





static func cuvinte() -> Array:
	var de_inlocuit = "ăâîșț"
	var inlocuit_cu = "aaist"
	var dictionar = {
	"Animale":"animale",
	"Culori":"culori",
	"Mijloace de\ntransport":"transport",
	"Emoții":"emotii",
	"Verbe\nuzuale":"verbe_uzuale",
	"Corpul\nomenesc":"corpul_omenesc",
	"Fructe":"fructe",
	"Legume":"Legume",
	"Orașe din\nRomânia":"orase-ro",
	"Adjective\nuzuale":"adjective uzuale",
	"Familie":"Familie",
	"Profesii":"Profesii",
	"Zilele\nsăptămânii":"zile_sapt",
	"Lunile\nanului":"Lunile anului",
	"Formele\ngeometrice":"Formele geometrice",
	"Îmbrăcăminte":"imbracaminte",
	"Instrumente\nmuzicale":"Instrumente muzicale",
	"Numerele":"Numerele",
	"Prepoziții":"Prepozitii",
	"Alimente":"Alimente",
	"Expresii":"Expresii",
	}
	var cuvinte_ := Array()
	for i in dictionar:
		#Ignorarea categoriilor create de utilizator (toate au terminația .data
		if (!dictionar[i].ends_with(".data")):
			#Se incarca datele din categorie curentă
			var date = load("res://Dictionar/"+dictionar[i]+".tres")
			var nume = date.nume_categorie
			var folder = date.folder
			var cuvantt = nume
			for j in range(de_inlocuit.length()):
				cuvantt = cuvantt.replace(de_inlocuit[j], inlocuit_cu[j])
			for k in range(date.cuvinte.size()):
				var cuvant = date.cuvinte[k]
				cuvant = cuvant.to_lower()
				for j in range(de_inlocuit.length()):
					cuvant = cuvant.replace(de_inlocuit[j], inlocuit_cu[j])
				cuvinte_.append(Array([cuvantt, folder, date.locatii[k], cuvant]))
	
	return cuvinte_

extends Control

#Datele care se afla in prezent in memorie
var date_curente

#Numele resurselor din folderul dictionar
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
}

#Dictionar care contine denumirile tuturor butoanelor din aplicatie
var btn_denumiri = {
	"meniu": ["Cuvinte", 
		"Expresii",
		"Formare propoziții", 
		"Text->dactileme", 
		"Setări aplicație", 
		"Ieșire"
	],
	"categorii": [
		"Animale", 
		"Culori", 
		"Mijloace de\ntransport", 
		"Emoții",
		"Verbe\nuzuale",
		"Corpul\nomenesc",
		"Fructe",
		"Legume",
		"Orașe din\nRomânia"
	],
}
#	"Animale": [
#		"Câine",
#		"Papagal",
#		"Gaină",
#		"Pisică",
#		"Capră",
#		"Oaie",
#		"Porc",
#		"Vacă",
#		"Taur",
#		"Arici",
#		"Caprioară",
#		"Cerb",
#		"Lup",
#		"Vulpe",
#		"Furnici",
#		"Gândac",
#	],
#	"Culori": [
#		"Alb",
#		"Albastru",
#		"Galben",
#		"Gri",
#		"Maro",
#		"Mov",
#		"Negru",
#		"Portocaliu",
#		"Roșu",
#		"Roz",
#		"Verde",
#		"Violet",
#	],
#	"Mijloace de\ntransport":[
#		"Mașină",
#		"Avion",
#		"Autobuz",
#		"Barcă",
#		"Bicicletă",
#		"Motocicletă",
#		"Tractor",
#		"Tramvai",
#		"Tren",
#		"Vas",
#		"Vapor",
#		"Trăsură",
#		"Elicopter",
#		"Căruță",
#		"Automobil",
#	],
#	"Emoții":[
#		"Vesel",
#		"Trist",
#		"Supărat",
#		"Indrăgostit",
#		"Emoționat",
#		"Uimire",
#		"Mirare",
#		"Au durere",
#		"Dezamăgit",
#		"Anxietate"
#	],
#	"Verbe\nuzuale":[
#		"a privi",
#		"a scrie",
#		"a citi",
#		"a arăta",
#		"a spune",
#		"a căuta",
#		"a pune",
#		"a lăsa",
#		"a scoate",
#		"a mânca",
#		"a strânge",
#		"a apăsa",
#		"a trage",
#		"a construi",
#		"a mulţumi",
#	],
#	"Corpul\nomenesc":[
#		"barbă",
#		"buză",
#		"cap",
#		"cot",
#		"deget",
#		"dinte",
#		"faţă",
#		"frunte",
#		"gât",
#		"gură",
#		"limbă",
#		"mână",
#		"nas",
#		"ochi",
#		"os",
#		"palmă",
#		"păr",
#		"piept",
#		"picior",
#		"spate",
#		"sânge",
#		"trup",
#		"umăr",
#		"unghie",
#		"ureche",
#		"braț",
#		"buric",
#		"gambe",
#		"abdomen",
#		"sprânceană",
#	],
#	"Fructe":[
#		"măr",
#		"pară",
#		"prună",
#		"portocală",
#		"banană",
#		"gutuie",
#		"lămâie",
#		"ananas",
#		"zmeură",
#		"strugure",
#		"pepene",
#		"nucă",
#		"kiwi",
#		"cireșe",
#		"piersică"
#	],
#	"Legume":[
#		"roșie",
#		"castravete",
#		"cartof",
#		"dovlecel",
#		"ardei",
#		"ciupercă",
#		"salată",
#		"morcov",
#		"ceapă",
#		"varză",
#		"ridiche",
#		"porumb",
#		"fasole",
#	],
#	"Orașe din\nRomânia":[
#		"Brașov",
#		"București",
#		"Iași",
#		"Timișoara",
#		"Cluj Napoca",
#		"Galați",
#		"Constanța",
#		"Craiova",
#		"Ploiești",
#		"Oradea",
#		"Brăila",
#		"Bacău",
#		"Pitești",
#		"Sibiu",
#		"Târgu Mureș",
#		"Baia Mare",
#		"Buzău",
#		"Suceava",
#		"Botoșani",
#		"Satu Mare",
#		"Râmnicu Vâlcea",
#		"Piatra Neamț",
#		"Târgu Jiu",
#		"Târgoviște",
#		"Focșani",
#		"Bistrița",
#		"Tulcea",
#		"Reșița",
#		"Slatina",
#		"Alba Iulia",
#		"Giurgiu",
#		"Deva",
#		"Hunedoara",
#		"Zalău",
#		"Sfântu Gheorghe",
#		"Bârlad",
#		"Vaslui",
#		"Miercurea Ciuc",
#		"Făgăraș",
#		"Sighișoara",
#	],
#
#}
#
#var videoclipuri = {
#	"Animale": {
#		"Câine":"res://ResurseVideo/Animale/caine.webm",
#		"Gaină":"res://ResurseVideo/Animale/gaina.webm",
#		"Papagal":"res://ResurseVideo/Animale/papagal.webm",
#		"Pisică":"res://ResurseVideo/Animale/pisica.webm",
#		"Capră":"res://ResurseVideo/Animale/capra.webm",
#		"Oaie":"res://ResurseVideo/Animale/oaie.webm",
#		"Porc":"res://ResurseVideo/Animale/porc.webm",
#		"Vacă":"res://ResurseVideo/Animale/vaca.webm",
#		"Taur":"res://ResurseVideo/Animale/taur.webm",
#		"Arici":"res://ResurseVideo/Animale/arici.webm",
#		"Caprioară":"res://ResurseVideo/Animale/caprioara.webm",
#		"Cerb":"res://ResurseVideo/Animale/cerb.webm",
#		"Lup":"res://ResurseVideo/Animale/lup.webm",
#		"Vulpe":"res://ResurseVideo/Animale/vulpe.webm",
#		"Furnici":"res://ResurseVideo/Animale/furnici.webm",
#		"Gândac":"res://ResurseVideo/Animale/gandac.webm",
#	},
#	"Culori": {
#		"Alb":"res://ResurseVideo/Culori/alb.webm",
#		"Albastru":"res://ResurseVideo/Culori/albastru.webm",
#		"Galben":"res://ResurseVideo/Culori/galben.webm",
#		"Gri":"res://ResurseVideo/Culori/gri.webm",
#		"Maro":"res://ResurseVideo/Culori/maro.webm",
#		"Mov":"res://ResurseVideo/Culori/mov.webm",
#		"Negru":"res://ResurseVideo/Culori/negru.webm",
#		"Portocaliu":"res://ResurseVideo/Culori/portocaliu.webm",
#		"Roșu":"res://ResurseVideo/Culori/rosu.webm",
#		"Roz":"res://ResurseVideo/Culori/roz.webm",
#		"Verde":"res://ResurseVideo/Culori/verde.webm",
#		"Violet":"res://ResurseVideo/Culori/violet.webm",
#	},
#	"Mijloace de\ntransport":{
#		"Mașină":"res://ResurseVideo/Transport/masina.webm",
#		"Avion":"res://ResurseVideo/Transport/avion.webm",
#		"Autobuz":"res://ResurseVideo/Transport/autobuz.webm",
#		"Barcă":"res://ResurseVideo/Transport/barca.webm",
#		"Bicicletă":"res://ResurseVideo/Transport/bicicleta.webm",
#		"Motocicletă":"res://ResurseVideo/Transport/motocicleta.webm",
#		"Tractor":"res://ResurseVideo/Transport/tractor.webm",
#		"Tramvai":"res://ResurseVideo/Transport/tramvai.webm",
#		"Tren":"res://ResurseVideo/Transport/tren.webm",
#		"Vas":"res://ResurseVideo/Transport/vas.webm",
#		"Vapor":"res://ResurseVideo/Transport/vapor.webm",
#		"Trăsură":"res://ResurseVideo/Transport/trasura.webm",
#		"Elicopter":"res://ResurseVideo/Transport/elicopter.webm",
#		"Căruță":"res://ResurseVideo/Transport/caruta.webm",
#		"Automobil":"res://ResurseVideo/Transport/automobil.webm",
#	},
#	"Emoții":{
#		"Vesel":"res://ResurseVideo/Emoti/vesel.webm",
#		"Trist":"res://ResurseVideo/Emoti/trist.webm",
#		"Supărat":"res://ResurseVideo/Emoti/suparat.webm",
#		"Indrăgostit":"res://ResurseVideo/Emoti/indragostit.webm",
#		"Emoționat":"res://ResurseVideo/Emoti/emotionat.webm",
#		"Uimire":"res://ResurseVideo/Emoti/uimire.webm",
#		"Mirare":"res://ResurseVideo/Emoti/mirare.webm",
#		"Au durere":"res://ResurseVideo/Emoti/au-durere-2.webm",
#		"Dezamăgit":"res://ResurseVideo/Emoti/dezamagit-1.webm",
#		"Anxietate":"res://ResurseVideo/Emoti/anxietate.webm",			
#	},
#	"Verbe\nuzuale":{
#		"a privi":"res://ResurseVideo/Verbe uzuale/privi.webm",
#		"a scrie":"res://ResurseVideo/Verbe uzuale/scrie.webm",
#		"a citi":"res://ResurseVideo/Verbe uzuale/citi.webm",
#		"a arăta":"res://ResurseVideo/Verbe uzuale/arata.webm",
#		"a spune":"res://ResurseVideo/Verbe uzuale/spune.webm",
#		"a căuta":"res://ResurseVideo/Verbe uzuale/cauta.webm",
#		"a pune":"res://ResurseVideo/Verbe uzuale/pune.webm",
#		"a lăsa":"res://ResurseVideo/Verbe uzuale/lasa.webm",
#		"a scoate":"res://ResurseVideo/Verbe uzuale/scoate.webm",
#		"a mânca":"res://ResurseVideo/Verbe uzuale/mananca.webm",
#		"a strânge":"res://ResurseVideo/Verbe uzuale/strange.webm",
#		"a apăsa":"res://ResurseVideo/Verbe uzuale/apasa.webm",
#		"a trage":"res://ResurseVideo/Verbe uzuale/trage.webm",
#		"a construi":"res://ResurseVideo/Verbe uzuale/construi.webm",
#		"a mulţumi":"res://ResurseVideo/Verbe uzuale/multumesc.webm",
#	},
#	"Corpul\nomenesc":{
#		"barbă":"res://ResurseVideo/Corpul omenesc/barba.webm",
#		"buză":"res://ResurseVideo/Corpul omenesc/buze.webm",
#		"cap":"res://ResurseVideo/Corpul omenesc/cap.webm",
#		"cot":"res://ResurseVideo/Corpul omenesc/cot.webm",
#		"deget":"res://ResurseVideo/Corpul omenesc/deget.webm",
#		"dinte":"res://ResurseVideo/Corpul omenesc/dinte.webm",
#		"faţă":"res://ResurseVideo/Corpul omenesc/fata.webm",
#		"frunte":"res://ResurseVideo/Corpul omenesc/frunte.webm",
#		"gât":"res://ResurseVideo/Corpul omenesc/gat.webm",
#		"gură":"res://ResurseVideo/Corpul omenesc/gura.webm",
#		"limbă":"res://ResurseVideo/Corpul omenesc/limba.webm",
#		"mână":"res://ResurseVideo/Corpul omenesc/mana.webm",
#		"nas":"res://ResurseVideo/Corpul omenesc/nas.webm",
#		"ochi":"res://ResurseVideo/Corpul omenesc/ochi.webm",
#		"os":"res://ResurseVideo/Corpul omenesc/os.webm",
#		"palmă":"res://ResurseVideo/Corpul omenesc/palma.webm",
#		"păr":"res://ResurseVideo/Corpul omenesc/par.webm",
#		"piept":"res://ResurseVideo/Corpul omenesc/piept.webm",
#		"picior":"res://ResurseVideo/Corpul omenesc/picior.webm",
#		"spate":"res://ResurseVideo/Corpul omenesc/spate.webm",
#		"sânge":"res://ResurseVideo/Corpul omenesc/sange.webm",
#		"trup":"res://ResurseVideo/Corpul omenesc/trup.webm",
#		"umăr":"res://ResurseVideo/Corpul omenesc/umar.webm",
#		"unghie":"res://ResurseVideo/Corpul omenesc/unghi.webm",
#		"ureche":"res://ResurseVideo/Corpul omenesc/ureche.webm",
#		"braț":"res://ResurseVideo/Corpul omenesc/brat.webm",
#		"buric":"res://ResurseVideo/Corpul omenesc/buric.webm",
#		"gambe":"res://ResurseVideo/Corpul omenesc/gamba.webm",
#		"abdomen":"res://ResurseVideo/Corpul omenesc/abdomen.webm",
#		"sprânceană":"res://ResurseVideo/Corpul omenesc/sprancean.webm",
#	},
#	"Fructe":{
#		"măr":"res://ResurseVideo/Fructe/mar.webm",
#		"pară":"res://ResurseVideo/Fructe/pom-2.webm",
#		"prună":"res://ResurseVideo/Fructe/prune.webm",
#		"portocală":"res://ResurseVideo/Fructe/portocala.webm",
#		"banană":"res://ResurseVideo/Fructe/banana.webm",
#		"gutuie":"res://ResurseVideo/Fructe/gutuie.webm",
#		"lămâie":"res://ResurseVideo/Fructe/lamaie-3.webm",
#		"ananas":"res://ResurseVideo/Fructe/ananas.webm",
#		"zmeură":"res://ResurseVideo/Fructe/zmeura.webm",
#		"strugure":"res://ResurseVideo/Fructe/struguri.webm",
#		"pepene":"res://ResurseVideo/Fructe/pepene.webm",
#		"nucă":"res://ResurseVideo/Fructe/nuca-2.webm",
#		"kiwi":"res://ResurseVideo/Fructe/kiwi.webm",
#		"cireșe":"res://ResurseVideo/Fructe/cirese.webm",
#		"piersică":"res://ResurseVideo/Fructe/piersica1.webm",
#	},
#	"Legume":{
#		"roșie":"res://ResurseVideo/Legume/rosie-1.webm",
#		"castravete":"res://ResurseVideo/Legume/castravete.webm",
#		"cartof":"res://ResurseVideo/Legume/cartofi.webm",
#		"dovlecel":"res://ResurseVideo/Legume/dovlecel.webm",
#		"ardei":"res://ResurseVideo/Legume/ardei.webm",
#		"ciupercă":"res://ResurseVideo/Legume/ciuperca.webm",
#		"salată":"res://ResurseVideo/Legume/salata.webm",
#		"morcov":"res://ResurseVideo/Legume/morcov.webm",
#		"ceapă":"res://ResurseVideo/Legume/ceapa.webm",
#		"varză":"res://ResurseVideo/Legume/varza.webm",
#		"ridiche":"res://ResurseVideo/Legume/ridiche.webm",
#		"porumb":"res://ResurseVideo/Legume/porumb.webm",
#		"fasole":"res://ResurseVideo/Legume/fasole-2.webm",
#	},
#	"Orașe din\nRomânia":{
#		"Brașov":"res://ResurseVideo/Orase din Romania/Brasov.webm",
#		"București":"res://ResurseVideo/Orase din Romania/Bucuresti.webm",
#		"Iași":"res://ResurseVideo/Orase din Romania/Iasi.webm",
#		"Timișoara":"res://ResurseVideo/Orase din Romania/Timisoara.webm",
#		"Cluj Napoca":"res://ResurseVideo/Orase din Romania/Cluj-Napoca.webm",
#		"Galați":"res://ResurseVideo/Orase din Romania/Galati.webm",
#		"Constanța":"res://ResurseVideo/Orase din Romania/Constanta.webm",
#		"Craiova":"res://ResurseVideo/Orase din Romania/Craiova.webm",
#		"Ploiești":"res://ResurseVideo/Orase din Romania/Ploiesti.webm",
#		"Oradea":"res://ResurseVideo/Orase din Romania/Oradea.webm",
#		"Brăila":"res://ResurseVideo/Orase din Romania/Braila.webm",
#		"Bacău":"res://ResurseVideo/Orase din Romania/Bacau.webm",
#		"Pitești":"res://ResurseVideo/Orase din Romania/Pitesti.webm",
#		"Sibiu":"res://ResurseVideo/Orase din Romania/Sibiu.webm",
#		"Târgu Mureș":"res://ResurseVideo/Orase din Romania/Targu-Mures.webm",
#		"Baia Mare":"res://ResurseVideo/Orase din Romania/Baia-Mare.webm",
#		"Buzău":"res://ResurseVideo/Orase din Romania/Buzau.webm",
#		"Suceava":"res://ResurseVideo/Orase din Romania/Suceava.webm",
#		"Botoșani":"res://ResurseVideo/Orase din Romania/Botosani.webm",
#		"Satu Mare":"res://ResurseVideo/Orase din Romania/Satu-Mare.webm",
#		"Râmnicu Vâlcea":"res://ResurseVideo/Orase din Romania/Ramnicu-Valcea.webm",
#		"Piatra Neamț":"res://ResurseVideo/Orase din Romania/Piatra-Neamt.webm",
#		"Târgu Jiu":"res://ResurseVideo/Orase din Romania/Tg-Jiu.webm",
#		"Târgoviște":"res://ResurseVideo/Orase din Romania/Targoviste.webm",
#		"Focșani":"res://ResurseVideo/Orase din Romania/Focsani.webm",
#		"Bistrița":"res://ResurseVideo/Orase din Romania/Bistrita.webm",
#		"Tulcea":"res://ResurseVideo/Orase din Romania/Tulcea.webm",
#		"Reșița":"res://ResurseVideo/Orase din Romania/Resita.webm",
#		"Slatina":"res://ResurseVideo/Orase din Romania/Slatina.webm",
#		"Alba Iulia":"res://ResurseVideo/Orase din Romania/Alba-Iulia-ok.webm",
#		"Giurgiu":"res://ResurseVideo/Orase din Romania/Giurgiu.webm",
#		"Deva":"res://ResurseVideo/Orase din Romania/Deva.webm",
#		"Hunedoara":"res://ResurseVideo/Orase din Romania/Hunedoara.webm",
#		"Zalău":"res://ResurseVideo/Orase din Romania/Zalau.webm",
#		"Sfântu Gheorghe":"res://ResurseVideo/Orase din Romania/Sfantu-Gheorghe.webm",
#		"Bârlad":"res://ResurseVideo/Orase din Romania/Barlad.webm",
#		"Vaslui":"res://ResurseVideo/Orase din Romania/Vaslui.webm",
#		"Miercurea Ciuc":"res://ResurseVideo/Orase din Romania/Miercurea-Ciuc.webm",
#		"Făgăraș":"res://ResurseVideo/Orase din Romania/Fagaras.webm",
#		"Sighișoara":"res://ResurseVideo/Orase din Romania/Sighisoara.webm",
#	},
#}

#Enumerator pt butoanele din meniul principal (trebuie puse in ordinea in care au fost scrise mai sus)
enum meniu	{
	CUVINTE,
	EXPRESII,
	FORM_PROP,
	TEXT_DACTILEME,
	SETARI,
	IESIRE
}

#Vector care contine butoanele din meniul principal
var btn_meniu = []

#Vector care contine butoanele din meniul cu categorii
var btn_categorii = []

#incarcare tema din f,olderul Tema
var tema = load("res://Tema/Tema.tres")

func _ready():
	creare_meniu_principal()
	creare_categorii_cuvinte()
	
#	#Sortare liste in ordine aflabetica
#	for i in btn_denumiri["categorii"]:
#		btn_denumiri[i].sort()

func creare_meniu_principal():
	#referinta lista meniu
	var lista = $MeniuPrincipal/ListaButoane/VBoxContainer
	theme = tema
	
	#Crearea butoanelor din meniul principal
	for btn in btn_denumiri["meniu"]:
		#Se creeaza un buton
		var b = Button.new()
		#Se adauga butonul in lista
		lista.add_child(b)
		#Se seteaza textul butonului
		b.text = btn
		#Se adauga butonul creat in vectorul cu butoane
		btn_meniu.append(b)
	
	#Conectarea butoanelor din meniu la functii
	btn_meniu[meniu.CUVINTE].connect("pressed", self, "afisare_categorii_cuvinte")
	btn_meniu[meniu.TEXT_DACTILEME].connect("pressed", self, "afisare_text_dactil")
	btn_meniu[meniu.IESIRE].connect("pressed", self, "inchidere_aplicatie")

func afisare_meniu_principal():
	$MeniuPrincipal.visible = true

func ascunde_meniu_principal():
	$MeniuPrincipal.visible = false

func creare_categorii_cuvinte():
	#Incarca categoriile
	var categorii_cuvinte = load("res://Meniu/Cuvinte/CategoriiCuvinte.tscn")
	#Creeaza categoriile
	categorii_cuvinte = categorii_cuvinte.instance()
	#Afiseaza categoriile pe ecran
	add_child(categorii_cuvinte)
	
	#Referinta lista categorii
	var lista = categorii_cuvinte.get_node("ListaCategorii/HSplitContainer")
	
	#Setare titlu
	categorii_cuvinte.get_node("Titlu/Text").text = "Categorii Cuvinte"
	
	#Creearea butoanelor pt categorii
	for btn in btn_denumiri["categorii"]:
		var b = Button.new()
		var b_text = Label.new()
		lista.add_child(b)
		b.add_child(b_text)
		b_text.text = btn
		b_text.set_anchors_and_margins_preset(Control.PRESET_CENTER)
		b_text.align = Label.ALIGN_CENTER
		b.size_flags_horizontal = SIZE_EXPAND_FILL
		b.size_flags_vertical = SIZE_EXPAND_FILL
		btn_categorii.append(b)
		b.connect("pressed", self, "creare_lista_cuvinte", [btn])
	
	#Conectarea butonului Inapoi din meniu de categorii
	categorii_cuvinte.get_node("ButonInapoi").connect("pressed", self, "ascunde_categorii_cuvinte")
	
	#Ascunde categoriile (doar ce a pornit aplicatia si suntem in meniul principal, deci nu trebuie afisate categoriile)
	ascunde_categorii_cuvinte()

func afisare_categorii_cuvinte():
	$MeniuPrincipal.visible = false
	get_node("Categorii").visible = true

func ascunde_categorii_cuvinte():
	get_node("Categorii").visible = false
	$MeniuPrincipal.visible = true

func creare_lista_cuvinte(tip):
	if(dictionar.has(tip)):
		date_curente = load("res://Dictionar/"+dictionar[tip]+".tres")
		get_node("Categorii").visible = false
		var categorie = load("res://Meniu/Cuvinte/Categorie.tscn")
		categorie = categorie.instance()
		add_child(categorie)
		categorie.get_node("Titlu/Text").text = tip.replace("\n", " ")
		
		var lista = categorie.get_node("ListaCuvinte/VBoxContainer")
		
		for btn in date_curente.cuvinte:
			var b = Button.new()
			lista.add_child(b)
			b.mouse_filter = Control.MOUSE_FILTER_PASS
			b.text = btn
			b.size_flags_horizontal = SIZE_EXPAND_FILL
			b.connect("pressed", self, "creare_video", [tip, btn])
		
		categorie.get_node("ButonInapoi").connect("pressed", self, "stergere_lista_cuvinte")

func stergere_lista_cuvinte():
	get_node("Categorii").visible = true
	get_node("Categorie").queue_free()

func creare_video(categorie, cuvant):
	get_node("Categorie").visible = false
	var fereastra_cuvant = load("res://Meniu/Cuvinte/Cuvant.tscn")
	fereastra_cuvant = fereastra_cuvant.instance()
	var video = load("res://ResurseVideo/"+date_curente.folder+"/"+date_curente.locatii[Array(date_curente.cuvinte).find(cuvant)]+".webm")
	var rez_ecran = OS.window_size
	var player_video = fereastra_cuvant.get_node("Video/VideoPlayer")
	
	add_child(fereastra_cuvant)
	fereastra_cuvant.get_node("Denumire/Text").text = cuvant
	player_video.stream = video
	var rez_video = player_video.get_video_texture().get_size()
	var ratio = rez_video.y/rez_video.x
	player_video.margin_top = -rez_ecran.x*ratio/2
	player_video.margin_bottom = player_video.margin_top*(-1)
	player_video.play()
	
	fereastra_cuvant.dimensionare_buton_replay(rez_ecran.x/8)
	fereastra_cuvant.get_node("ButonInapoi").connect("pressed", self, "stergere_video")
	fereastra_cuvant.get_node("Video/Replay/Buton").connect("pressed", fereastra_cuvant, "reluare_video")
	player_video.connect("finished", fereastra_cuvant, "afisare_buton_reluare")

func stergere_video():
	get_node("Categorie").visible = true
	get_node("Cuvant").queue_free()

func afisare_text_dactil():
	$MeniuPrincipal.visible = false
	var text_dactil = load("res://Meniu/Cuvinte/TextDactileme.tscn")
	text_dactil = text_dactil.instance()
	add_child(text_dactil)
	text_dactil.get_node("ButonInapoi").connect("pressed", self, "ascunde_text_dactil")

func ascunde_text_dactil():
	get_node("MeniuPrincipal").visible = true
	get_node("TextDactileme").queue_free()

func inchidere_aplicatie():
	get_tree().quit()

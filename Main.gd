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
	"Adjective\nuzuale":"adjective uzuale",
	"Familie":"Familie",
	"Profesii":"Profesii",
	"Zilele\nsăptămânii":"zile_sapt",
	"Lunile\nanului":"Lunile anului",
	"Formele\ngeometrice":"Formele geometrice",
	"Îmbrăcăminte":"imbracaminte",
	"Instrumente\nmuzicale":"Instrumente muzicale",
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
		"Orașe din\nRomânia",
		"Adjective\nuzuale",
		"Familie",
		"Zilele\nsăptămânii",
		"Lunile\nanului",
		"Formele\ngeometrice",
		"Îmbrăcăminte",
		"Profesii",
		"Instrumente\nmuzicale",
	],
}

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

var lista_mica = false

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
	btn_meniu[meniu.FORM_PROP].connect("pressed", self, "afisare_formare_prop")
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
	
	var rez_ecran = OS.window_size
	
	#Creearea butoanelor pt categorii
	for btn in btn_denumiri["categorii"]:
		var b = Button.new()
		var panel = PanelContainer.new()
		var b_text = Label.new()
		lista.add_child(panel)
		panel.add_child(b)
		panel.add_child(b_text)
		
		
		panel.size_flags_horizontal = SIZE_EXPAND_FILL
		panel.size_flags_vertical = SIZE_SHRINK_CENTER
		panel.rect_min_size = Vector2(rez_ecran.x/2-10, rez_ecran.y/5)
		panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
		
		b_text.text = btn
		b_text.align = Label.ALIGN_CENTER
		b_text.mouse_filter = Control.MOUSE_FILTER_IGNORE
		b_text.size_flags_horizontal = SIZE_SHRINK_CENTER
		b_text.size_flags_vertical = SIZE_SHRINK_CENTER
		
		
		b.size_flags_horizontal = SIZE_EXPAND_FILL
		b.size_flags_vertical = SIZE_EXPAND_FILL
		b.set_anchors_and_margins_preset(Control.PRESET_WIDE)
		b.mouse_filter = Control.MOUSE_FILTER_PASS
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

func afisare_formare_prop():
	ascunde_meniu_principal()
	var formare_prop = load("res://Meniu/FormareProp.tscn")
	formare_prop = formare_prop.instance()
	formare_prop.get_node("ButonInapoi").connect("pressed", self, "stergere_formare_prop")
	formare_prop.get_node("Titlu/Text").text = "Formare propoziții"
	add_child(formare_prop)
	
	var categ = get_node("Categorii")
	remove_child(categ)
	add_child(categ)
	categ.anchor_top = .5
	categ.get_node("ButonInapoi").visible = false
	categ.get_node("Titlu").anchor_left = 0
	categ.visible = true
	
	lista_mica = true

func stergere_formare_prop():
	var categ = get_node("Categorii")
	categ.anchor_top = 0
	categ.get_node("ButonInapoi").visible = true
	categ.get_node("Titlu").anchor_left = .1
	get_node("Categorii/ListaCategorii").scroll_vertical = 0
	categ.visible = false
	
	if (get_node("FormareProp/Start").text == " X "):
		get_node("FormareProp").redare_video()
	
	get_node("FormareProp").queue_free()
	afisare_meniu_principal()
	
	if (has_node("Categorie")):
		get_node("Categorie").queue_free()
	
	lista_mica = false

func creare_lista_cuvinte(tip):
	var conectare_la
	var functie
	
	if (lista_mica):
		conectare_la = get_node("FormareProp")
		functie = "adaugare_cuvant"
	else:
		conectare_la = self
		functie = "creare_video"
	
	if(dictionar.has(tip)):
		date_curente = load("res://Dictionar/"+dictionar[tip]+".tres")
		get_node("Categorii").visible = false
		var categorie = load("res://Meniu/Cuvinte/Categorie.tscn")
		categorie = categorie.instance()
		
		if (lista_mica):
			categorie.anchor_top = .5
		
		add_child(categorie)
		categorie.get_node("Titlu/Text").text = tip.replace("\n", " ")
		
		var lista = categorie.get_node("ListaCuvinte/VBoxContainer")
		
		for btn in date_curente.cuvinte:
			var b = Button.new()
			lista.add_child(b)
			b.mouse_filter = Control.MOUSE_FILTER_PASS
			b.text = btn
			b.size_flags_horizontal = SIZE_EXPAND_FILL
			b.connect("pressed", conectare_la, functie, [tip, btn])
		
		categorie.get_node("ButonInapoi").connect("pressed", self, "stergere_lista_cuvinte")

func stergere_lista_cuvinte():
	get_node("Categorii").visible = true
	get_node("Categorie").queue_free()

func creare_video(categorie, cuvant):
	var fereastra_cuvant = load("res://Meniu/Cuvinte/Cuvant.tscn")
	fereastra_cuvant = fereastra_cuvant.instance()
	var video = load("res://ResurseVideo/"+date_curente.folder+"/"+date_curente.locatii[Array(date_curente.cuvinte).find(cuvant)]+".webm")
	var rez_ecran = OS.window_size
	var player_video = fereastra_cuvant.get_node("Video/VideoPlayer")
	
	add_child(fereastra_cuvant)
	player_video.stream = video
	var rez_video = player_video.get_video_texture().get_size()
	var ratio = rez_video.y/rez_video.x
	player_video.margin_top = -rez_ecran.x*ratio/2
	player_video.margin_bottom = player_video.margin_top*(-1)
	
	if (!lista_mica):
		get_node("Categorie").visible = false
		
		player_video.play()
		
		fereastra_cuvant.dimensionare_buton_replay(rez_ecran.x/8)
		fereastra_cuvant.get_node("Denumire/Text").text = cuvant
		fereastra_cuvant.get_node("ButonInapoi").connect("pressed", self, "stergere_video")
		fereastra_cuvant.get_node("Video/Replay/Buton").connect("pressed", fereastra_cuvant, "reluare_video")
		player_video.connect("finished", fereastra_cuvant, "afisare_buton_reluare")
	else:
		fereastra_cuvant.visible = false
		fereastra_cuvant.anchor_top = .5
		fereastra_cuvant.get_node("Denumire").visible = false
		fereastra_cuvant.get_node("ButonInapoi").visible = false
		player_video.connect("finished", get_node("FormareProp"), "urmat_video")
	
	return fereastra_cuvant

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
	
func incarcare_date(tip):
	if(tip!=date_curente.nume_categorie and dictionar.has(tip)):
		date_curente = load("res://Dictionar/"+dictionar[tip]+".tres")

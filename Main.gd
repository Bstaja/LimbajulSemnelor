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
	"Numerele":"Numerele",
	"Prepoziții":"Prepozitii",
	"Alimente":"Alimente",
	"Expresii":"Expresii",
}

#Dictionar care contine denumirile tuturor butoanelor din aplicatie
var btn_denumiri = {
	"meniu": [
		"Cuvinte", 
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
		"Numerele",
		"Prepoziții",
		"Alimente",
	],
}

var categorii_nesortate = [
	"Zilele\nsăptămânii",
	"Lunile\nanului",
	"Numerele",
]

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

var buton_back = "inchidere_aplicatie"
var buton_back_oprit = false

class Sortare:
	static func sort(a, b):
		var alfabet := "aăâbcdefghiîjklmnopqrsștțuvwxyz"
		a = a.rstrip("\n ").to_lower().replace("a ", "").replace("se ", "")
		b = b.rstrip("\n ").to_lower().replace("a ", "").replace("se ", "")
		var i = 0
		var a_size = a.length()-1
		var b_size = b.length()-1
		while(a[i] == b[i] and i<a_size and i<b_size):
			i+=1
		if (alfabet.find(a[i])<alfabet.find(b[i])):
			return true
		return false

func _ready():
	btn_denumiri["categorii"].sort_custom(Sortare, "sort")
	
	theme = tema
	
	#Rezolutie fixa
	var rez_ecran = OS.window_size
	print(rez_ecran)
	var ratio = rez_ecran.y/rez_ecran.x
	print(ratio)
	
	anchor_top = 0
	anchor_bottom = 0
	anchor_right = 0
	anchor_left = 0
	margin_top = 0
	margin_left = 0
	margin_bottom = 720*ratio
	margin_right = 720
	
	$ViewPort.get_viewport().size = rect_size
	
	print(rect_size)
	
	creare_meniu_principal()
	creare_categorii_cuvinte()

func creare_meniu_principal():
	#referinta lista meniu
	var lista = $MeniuPrincipal/ListaButoane/VBoxContainer
	
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
	btn_meniu[meniu.EXPRESII].connect("pressed", self, "creare_lista_cuvinte", ["Expresii"])
	btn_meniu[meniu.FORM_PROP].connect("pressed", self, "afisare_formare_prop")
	btn_meniu[meniu.TEXT_DACTILEME].connect("pressed", self, "afisare_text_dactil")
	btn_meniu[meniu.IESIRE].connect("pressed", self, "inchidere_aplicatie")

func afisare_meniu_principal():
	$MeniuPrincipal.visible = true
	buton_back = "inchidere_aplicatie"

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
	
	var rez_ecran = rect_size
	var tema_butoane = load("res://Tema/tema_btn_categorii.tres")
	
	#Creearea butoanelor pt categorii
	for btn in btn_denumiri["categorii"]:
		#Creare buton nou
		var b = Button.new()
		#Creare panel
		var panel = PanelContainer.new()
		#Creare text buton
		var b_text = Label.new()
		#Adauga panelul în listă
		lista.add_child(panel)
		#În panel vor fi adăugate butonul și textul acestuia
		panel.add_child(b)
		panel.add_child(b_text)
		#Se contectează semnalul "pressed" al butonului la funcția care
		#afișează lista de cuvinte
		#Ultimul argument al funcției "connect" este un vector cu argumentele
		#care vor fi predate funcției la declanșarea semnalului
		b.connect("pressed", self, "creare_lista_cuvinte", [btn])
		
		panel.size_flags_horizontal = SIZE_EXPAND_FILL
		panel.size_flags_vertical = SIZE_SHRINK_CENTER
		panel.rect_min_size = Vector2(0, rez_ecran.y/5)
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
		b.add_stylebox_override("normal", tema_butoane)
		b.add_stylebox_override("pressed", tema_butoane)
		b.add_stylebox_override("hover", tema_butoane)
		b.add_stylebox_override("focus", tema_butoane)
		b.add_stylebox_override("disabled", tema_butoane)
		btn_categorii.append(b)
	
	btn_categorii.remove(-1)
	lista.get_child(lista.get_child_count()-1).visible = false
	#Conectarea butonului Inapoi din meniu de categorii
	categorii_cuvinte.get_node("ButonInapoi").connect("pressed", self, "ascunde_categorii_cuvinte")
	categorii_cuvinte.get_node("ButonModificare").connect("pressed", self, "modifica_categorii")
	categorii_cuvinte.get_node("AdaugaCategorie/Buton").connect("pressed", self, "afisare_meniu_creare_categ")
	
	#Ascunde categoriile (doar ce a pornit aplicatia si suntem in meniul principal, deci nu trebuie afisate categoriile)
	ascunde_categorii_cuvinte()

func afisare_categorii_cuvinte():
	$MeniuPrincipal.visible = false
	get_node("Categorii").visible = true
	buton_back = "ascunde_categorii_cuvinte"

func ascunde_categorii_cuvinte():
	get_node("Categorii").visible = false
	if (get_node("Categorii/ButonModificare").text == "salvează"):
		modifica_categorii()
	$MeniuPrincipal.visible = true
	if (lista_mica):
		buton_back = "stergere_formare_prop"
	else:
		buton_back = "inchidere_aplicatie"

func afisare_formare_prop():
	
	ascunde_meniu_principal()
	var formare_prop = load("res://Meniu/FormareProp.tscn")
	formare_prop = formare_prop.instance()
	formare_prop.get_node("ButonInapoi").connect("pressed", self, "stergere_formare_prop")
	formare_prop.get_node("Titlu/Text").text = "Formare propoziții"
	add_child(formare_prop)
	
	micsorare_lista_categorii()
	get_node("Categorii").visible = true
	buton_back = "stergere_formare_prop"

func stergere_formare_prop():
	if (get_node("FormareProp/Start").text == " X "):
		get_node("FormareProp").redare_video()
	
	get_node("FormareProp").queue_free()
	afisare_meniu_principal()
	
	if (has_node("Categorie")):
		get_node("Categorie").queue_free()
	
	marire_lista_categorii()
	get_node("Categorii").visible = false
	buton_back = "inchidere_aplicatie"

func creare_lista_cuvinte(tip):
	var conectare_la
	var functie
	
	if(dictionar.has(tip)):
		date_curente = load("res://Dictionar/"+dictionar[tip]+".tres")
		get_node("Categorii").visible = false
		var categorie = load("res://Meniu/Cuvinte/Categorie.tscn")
		categorie = categorie.instance()
		
		if !(tip in categorii_nesortate):
			var aux = Array(date_curente.cuvinte)
			var aux2 = Array()
			var aux3 = aux.duplicate()
			aux.sort_custom(Sortare, "sort")
			
			for i in range(aux.size()):
				aux2.append(date_curente.locatii[aux3.find(aux[i])])
			
			date_curente.cuvinte = PoolStringArray(aux)
			date_curente.locatii = PoolStringArray(aux2)
		
		if (lista_mica):
			conectare_la = get_node_or_null("FormareProp")
			if (conectare_la == null):
				conectare_la = get_node("CategorieNoua/SelectareCuvinte")
				buton_back_oprit = false
			functie = "adaugare_cuvant"
			var tema_panel = load("res://Tema/tema_titlu_mijloc_cuv.tres")
			var tema_btn_inapoi = load("res://Tema/tema_btn_inapo_mij.tres")
			categorie.get_node("Titlu").add_stylebox_override("panel", tema_panel)
			categorie.get_node("ButonInapoi").add_stylebox_override("normal", tema_btn_inapoi)
			categorie.get_node("ButonInapoi").add_stylebox_override("pressed", tema_btn_inapoi)
			categorie.get_node("ButonInapoi").add_stylebox_override("hover", tema_btn_inapoi)
			categorie.get_node("ButonInapoi").add_stylebox_override("focus", tema_btn_inapoi)
			categorie.anchor_top = .5
		else:
			conectare_la = self
			functie = "creare_video"
		
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
		buton_back = "stergere_lista_cuvinte"

func stergere_lista_cuvinte():
	if (get_node("Categorie/Titlu/Text").text != "Expresii"):
		get_node("Categorii").visible = true
	get_node("Categorie").queue_free()
	if (!lista_mica):
		buton_back = "ascunde_categorii_cuvinte"
	else:
		if (get_node_or_null("FormareProp")!=null):
			buton_back = "stergere_formare_prop"
		else:
			buton_back = "ascunde_creare_categ"
			buton_back_oprit = true

func creare_video(categorie, cuvant):
	var fereastra_cuvant = load("res://Meniu/Cuvinte/Cuvant.tscn")
	fereastra_cuvant = fereastra_cuvant.instance()
	#print("res://ResurseVideo/"+date_curente.folder+"/"+date_curente.locatii[Array(date_curente.cuvinte).find(cuvant)]+".webm")
	var video = load("res://ResurseVideo/"+date_curente.folder+"/"+date_curente.locatii[Array(date_curente.cuvinte).find(cuvant)]+".webm")
	var rez_ecran = rect_size
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
		buton_back = "stergere_video"
	else:
		fereastra_cuvant.visible = false
		fereastra_cuvant.anchor_top = .5
		fereastra_cuvant.get_node("Denumire").visible = false
		fereastra_cuvant.get_node("ButonInapoi").visible = false
		player_video.connect("finished", get_node("FormareProp"), "urmat_video")
		buton_back = "oprire_video_succesive"
	
	return fereastra_cuvant

func stergere_video():
	get_node("Categorie").visible = true
	get_node("Cuvant").queue_free()
	buton_back = "stergere_lista_cuvinte"

func afisare_text_dactil():
	$MeniuPrincipal.visible = false
	var text_dactil = load("res://Meniu/Cuvinte/TextDactileme.tscn")
	text_dactil = text_dactil.instance()
	add_child(text_dactil)
	text_dactil.get_node("ButonInapoi").connect("pressed", self, "ascunde_text_dactil")
	buton_back = "ascunde_text_dactil"

func ascunde_text_dactil():
	get_node("MeniuPrincipal").visible = true
	get_node("TextDactileme").queue_free()
	buton_back = "inchidere_aplicatie"

func afisare_meniu_creare_categ():
	var meniu = load("res://Meniu/CategorieNoua.tscn")
	meniu = meniu.instance()
	meniu.get_node("Titlu/Text").text = "Categorie nouă"
	add_child(meniu)
	
	meniu.get_node("ButonInapoi").connect("pressed", self, "ascunde_creare_categ")
	
	modifica_categorii()
	micsorare_lista_categorii()
	
	buton_back = "ascunde_creare_categ"

func ascunde_creare_categ():
	get_node("CategorieNoua").queue_free()
	
	modifica_categorii()
	marire_lista_categorii()
	
	buton_back = "ascunde_categorii_cuvinte"

func inchidere_aplicatie():
	get_tree().quit()
	
func incarcare_date(tip):
	if(tip!=date_curente.nume_categorie and dictionar.has(tip)):
		date_curente = load("res://Dictionar/"+dictionar[tip]+".tres")

func oprire_video_succesive():
	var n = get_node_or_null("FormareProp")
	if (n!=null):
		n.redare_video()
		buton_back = "stergere_formare_prop"

func modifica_categorii():
	var categ = get_node("Categorii")
	var lista_categ = categ.get_node("ListaCategorii/HSplitContainer")
	var btn = categ.get_node("ButonModificare")
	
	if (btn.text == "modifică"):
		btn.text = "salvează"
		categ.get_node("AdaugaCategorie").visible = true
		categ.get_node("ListaCategorii").anchor_top = .2
		for i in lista_categ.get_children():
			i.get_child(0).disabled = true
	else:
		btn.text = "modifică"
		categ.get_node("AdaugaCategorie").visible = false
		categ.get_node("ListaCategorii").anchor_top = .1
		for i in lista_categ.get_children():
			i.get_child(0).disabled = false

func micsorare_lista_categorii():
	if (lista_mica == false):
		var categ = get_node("Categorii")
		var tema_titlu_mijloc = load("res://Tema/tema_titlu_mijloc.tres")
		categ.get_node("Titlu").add_stylebox_override("panel", tema_titlu_mijloc)
		categ.get_node("ButonModificare").visible = false
		categ.get_node("ListaCategorii").scroll_vertical = 0
		categ.anchor_top = .5
		categ.get_node("ButonInapoi").visible = false
		categ.get_node("Titlu").anchor_left = 0
		lista_mica = true

func marire_lista_categorii():
	if (lista_mica == true):
		var categ = get_node("Categorii")
		categ.anchor_top = 0
		categ.get_node("ButonInapoi").visible = true
		categ.get_node("ButonModificare").visible = true
		categ.get_node("Titlu").anchor_left = .1
		categ.get_node("ListaCategorii").scroll_vertical = 0
		categ.get_node("Titlu").add_stylebox_override("panel", null)
		lista_mica = false

func _notification(what):
	if (!buton_back_oprit and (what==MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST or what==MainLoop.NOTIFICATION_WM_QUIT_REQUEST)):
		call_deferred(buton_back)

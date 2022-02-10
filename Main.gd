extends Control

#Datele care se afla in prezent in memorie
var date_curente = load("res://Dictionar/CategorieGenerica.tres")

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
		"Dicționar", 
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
		"Expresii",
	],
}

var categorii_nesortate = [
	"Zilele\nsăptămânii",
	"Lunile\nanului",
	"Numerele",
	
	
	"Cuvinte găsite"
]

var categorii_utilizator = []
var nume_fisiere = []

#Enumerator pt butoanele din meniul principal (trebuie puse in ordinea in care au fost scrise mai sus)
enum meniu	{
	CUVINTE,
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
	var dir = Directory.new()
	if (!dir.dir_exists("user://Categorii")):
		dir.make_dir("user://Categorii")
	else:
		if (dir.file_exists("user://Categorii/temp.data")):
			dir.remove("user://Categorii/temp.data")
	
	incarca_categorii_utilizator()
	
	theme = tema
	
#	#Obtinerea rezolutiei ecranului
#	var rez_ecran = OS.window_size
#	#Calcularea raportului de aspect
#	var ratio = rez_ecran.y/rez_ecran.x
#	#Nu avem nevoie de ancore, prin umrare
#	#le-am atribuit la toate valoarea 0
#	anchor_top = 0
#	anchor_bottom = 0
#	anchor_right = 0
#	anchor_left = 0
#	#Setarea marginilor ferestrei principale
#	margin_top = 0
#	margin_left = 0
#	margin_bottom = 720*ratio
#	margin_right = 720
#
#	$ViewPort.get_viewport().size = rect_size
	$ViewPort.queue_free()
	
	creare_meniu_principal()
	creare_categorii_cuvinte()
	
	get_tree().get_root().connect("size_changed", self, "redimensionare_fereastra")

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
	btn_meniu[meniu.FORM_PROP].connect("pressed", self, "afisare_formare_prop")
	btn_meniu[meniu.TEXT_DACTILEME].connect("pressed", self, "afisare_text_dactil")
	btn_meniu[meniu.SETARI].connect("pressed", self, "afisare_setari")
	btn_meniu[meniu.IESIRE].connect("pressed", self, "inchidere_aplicatie")

func afisare_meniu_principal():
	$MeniuPrincipal.visible = true
	buton_back = "inchidere_aplicatie"

func ascunde_meniu_principal():
	$MeniuPrincipal.visible = false

func afisare_setari():
	var setari = load("res://Meniu/Setari.tscn")
	setari = setari.instance()
	add_child(setari)
	setari.get_node("Titlu/Text").text = "Setări aplicație"
	setari.get_node("ButonInapoi").connect("pressed", self, "ascunde_setari")
	buton_back = "ascunde_setari"

func ascunde_setari():
	get_node("Setari").queue_free()
	buton_back = "inchidere_aplicatie"

func creare_categorii_cuvinte():
	btn_denumiri["categorii"].sort_custom(Sortare, "sort")
	#Incarca categoriile
	var categorii_cuvinte = load("res://Meniu/Cuvinte/CategoriiCuvinte.tscn")
	#Creeaza categoriile
	categorii_cuvinte = categorii_cuvinte.instance()
	#Afiseaza categoriile pe ecran
	add_child(categorii_cuvinte)
	
	#Referinta lista categorii
	var lista = categorii_cuvinte.get_node("ListaCategorii/HSplitContainer")
	
	#Setare titlu
	categorii_cuvinte.get_node("Titlu/Text").text = "Categorii"
	
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
		panel.rect_min_size = Vector2(298, 298)
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
	
	#Conectarea butonului Inapoi din meniu de categorii
	categorii_cuvinte.get_node("ButonInapoi").connect("pressed", self, "ascunde_categorii_cuvinte")
	categorii_cuvinte.get_node("ButonModificare").connect("pressed", self, "modifica_categorii")
	categorii_cuvinte.get_node("AdaugaCategorie/Buton").connect("pressed", self, "afisare_meniu_creare_categ")
	
	#Ascunde categoriile (doar ce a pornit aplicatia si suntem in meniul principal, deci nu trebuie afisate categoriile)
	ascunde_categorii_cuvinte()
	redimensionare_fereastra()

func afisare_categorii_cuvinte():
	$MeniuPrincipal.visible = false
	get_node("Categorii").visible = true
	buton_back = "ascunde_categorii_cuvinte"

func ascunde_categorii_cuvinte():
	if (has_node("Categorie")):
		get_node("Categorie").visible = false
	get_node("Categorii").visible = false
	get_node("Categorii/CasetaCautare/Text").text = ""
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

func creare_lista_cuvinte(tip:String):
	var conectare_la
	var functie
	
	if(dictionar.has(tip)):
		incarcare_date(tip)
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
		var tema_t = load("res://Tema/tema_btn_general.tres")
		var tema_b = StyleBoxEmpty.new()
		
		for btn in date_curente.cuvinte:
			var b = Button.new()
			var t = Label.new()
			b.focus_mode = Control.FOCUS_CLICK
			t.autowrap = true
			t.align = Label.ALIGN_CENTER
			t.valign = Label.VALIGN_CENTER
			t.text = btn
			t.add_stylebox_override("normal", tema_t)
			t.add_child(b)
			
			lista.add_child(t)
			b.mouse_filter = Control.MOUSE_FILTER_PASS
			b.set_anchors_and_margins_preset(Control.PRESET_WIDE)
#			b.size_flags_horizontal = SIZE_EXPAND_FILL
#			b.size_flags_vertical = SIZE_EXPAND_FILL
			b.add_stylebox_override("normal", tema_b)
			b.add_stylebox_override("pressed", tema_b)
			b.add_stylebox_override("hover", tema_b)
			b.add_stylebox_override("focus", tema_b)
			b.connect("pressed", conectare_la, functie, [tip, btn])
		categorie.get_node("ButonInapoi").connect("pressed", self, "stergere_lista_cuvinte", [], CONNECT_DEFERRED)
		buton_back = "stergere_lista_cuvinte"

func stergere_lista_cuvinte():
	get_node("Categorii").visible = true
	get_node("Categorie").free()
	
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
	var rez_ecran = OS.window_size
	var player_video = fereastra_cuvant.get_node("Video/VideoPlayer")
	
	add_child(fereastra_cuvant)
	player_video.stream = video
	fereastra_cuvant.redimensionare_fereastra()

	
	if (!lista_mica):
		get_node("Categorie").visible = false
		
		player_video.play()
		
		fereastra_cuvant.get_node("Denumire/Text").text = cuvant
		fereastra_cuvant.get_node("ButonInapoi").connect("pressed", self, "stergere_video")
		fereastra_cuvant.get_node("Video/Replay/Buton").connect("pressed", fereastra_cuvant, "reluare_video")
		player_video.connect("finished", fereastra_cuvant, "afisare_buton_reluare")
		buton_back = "stergere_video"
	else:
		fereastra_cuvant.visible = false
		fereastra_cuvant.anchor_top = .5
		fereastra_cuvant.get_node("Video").anchor_top = 0
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
	
	for i in get_node("Categorii/ListaCategorii/HSplitContainer").get_children():
		if (categorii_utilizator.find(i.get_child(1).text)>-1):
			i.visible = false
	
	modifica_categorii()
	micsorare_lista_categorii()
	
	buton_back = "ascunde_creare_categ"

func ascunde_creare_categ():
	get_node("CategorieNoua").queue_free()
	
	for i in get_node("Categorii/ListaCategorii/HSplitContainer").get_children():
		i.visible = true
	
	modifica_categorii()
	marire_lista_categorii()
	
	buton_back = "ascunde_categorii_cuvinte"

func inchidere_aplicatie():
	get_tree().quit()
	
func incarcare_date(tip):
	if(dictionar.has(tip) and (tip!=date_curente.nume_categorie or tip == "Cuvinte găsite" or dictionar[tip].ends_with(".data"))):
		if (!dictionar[tip].ends_with(".data")):
			date_curente = load("res://Dictionar/"+dictionar[tip]+".tres")
		else:
			var f = File.new()
			var d
			f.open("user://Categorii/"+dictionar[tip], File.READ)
			d = f.get_var(true)
			date_curente = load("res://Dictionar/CategorieGenerica.tres")
			date_curente.cuvinte = d["cuvinte"]
			date_curente.locatii = d["locatii"]
			date_curente.nume_categorie = d["denumire"]

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
		categ.get_node("ListaCategorii").anchor_top = .18
		
		var aspect_sus = load("res://Tema/tema_btn_sus.tres")
		var aspect_jos = load("res://Tema/tema_btn_jos.tres")
		var font = load("res://Tema/FontButonModifica.tres")
		
		for i in lista_categ.get_children():
			i.get_child(0).disabled = true
			if (categorii_utilizator.has(i.get_child(1).text)):
				var b = Button.new()
				i.get_child(0).add_child(b)
				b.anchor_top = 0
				b.anchor_bottom = .2
				b.anchor_left = 0	
				b.anchor_right = 1
				b.add_font_override("font", font)
				b.add_stylebox_override("normal", aspect_sus)
				b.add_stylebox_override("pressed", aspect_sus)
				b.add_stylebox_override("focus", aspect_sus)
				b.add_stylebox_override("hover", aspect_sus)
				b.text = "șterge"
				b.connect("pressed", self, "sterge_categorie", [i.get_child(1).text, i])
				
				b = Button.new()
				i.get_child(0).add_child(b)
				b.anchor_top = .8
				b.anchor_bottom = 1
				b.anchor_left = 0
				b.anchor_right = 1
				b.add_font_override("font", font)
				b.add_stylebox_override("normal", aspect_jos)
				b.add_stylebox_override("pressed", aspect_jos)
				b.add_stylebox_override("focus", aspect_jos)
				b.add_stylebox_override("hover", aspect_jos)
				b.text = "modifică"
				b.connect("pressed", self, "modifica_categorie", [i.get_child(1).text, i])
			
	else:
		btn.text = "modifică"
		categ.get_node("AdaugaCategorie").visible = false
		categ.get_node("ListaCategorii").anchor_top = .18
		for i in lista_categ.get_children():
			i.get_child(0).disabled = false
			if (categorii_utilizator.has(i.get_child(1).text)):
				for j in i.get_child(0).get_children():
					j.queue_free()

func micsorare_lista_categorii():
	if (lista_mica == false):
		var categ = get_node("Categorii")
		var tema_titlu_mijloc = load("res://Tema/tema_titlu_mijloc.tres")
		categ.get_node("Titlu").add_stylebox_override("panel", tema_titlu_mijloc)
		categ.get_node("ButonModificare").visible = false
		categ.get_node("CasetaCautare").visible = false
		categ.get_node("ListaCategorii").scroll_vertical = 0
		categ.get_node("ListaCategorii").anchor_top = .1
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
		categ.get_node("CasetaCautare").visible = true
		categ.get_node("Titlu").anchor_left = .1
		categ.get_node("ListaCategorii").scroll_vertical = 0
		categ.get_node("ListaCategorii").anchor_top = .18
		categ.get_node("Titlu").add_stylebox_override("panel", null)
		lista_mica = false

func incarca_categorii_utilizator():
	#Obtinerea unei liste cu toate fisierele din folderul Categorii
	var dir = Directory.new()
	var fisiere = []
	dir.open("user://Categorii")
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if (file_name.length()>2):
			fisiere.append(file_name)
		file_name = dir.get_next()
	#Citirea din fisiere
	var fisier = File.new()
	var date
	for i in fisiere:
		fisier.open("user://Categorii/"+i, File.READ)
		date = fisier.get_var(true)
		btn_denumiri["categorii"].append(date["denumire"])
		categorii_utilizator.append(date["denumire"])
		nume_fisiere.append(i)
		dictionar[date["denumire"]] = i
		if (date["alfabetic"]==false):
			categorii_nesortate.append(date["denumire"])
		fisier.close()

func sterge_categorie(cat, obiect):
	var locatie = categorii_utilizator.find(cat)
	var dir = Directory.new()
	dir.remove("user://Categorii/"+nume_fisiere[locatie])
	categorii_utilizator.remove(locatie)
	nume_fisiere.remove(locatie)
	categorii_nesortate.erase(cat)
	btn_denumiri["categorii"].erase(cat)
	obiect.queue_free()

func modifica_categorie(cat, obiect):
	afisare_meniu_creare_categ()
	get_node("CategorieNoua/Titlu/Text").text = "Modifică categoria"
	get_node("CategorieNoua/CasetaText/Text").text = cat
	get_node("CategorieNoua").sterge_categ = cat
	get_node("CategorieNoua").sterge_obiect = obiect
	incarcare_date(cat)
	if (categorii_nesortate.has(cat)):
		get_node("CategorieNoua").sortare_alfabetica()
	
	for i in date_curente.cuvinte:
		get_node("CategorieNoua/SelectareCuvinte").adaugare_cuvant(cat, i)
	

func _notification(what):
	if (!buton_back_oprit and (what==MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST or what==MainLoop.NOTIFICATION_WM_QUIT_REQUEST)):
		call_deferred(buton_back)
		
func redimensionare_fereastra():
	var col = clamp(int(OS.window_size.x/350), 1, 4)
	get_node("Categorii/ListaCategorii/HSplitContainer").columns = col

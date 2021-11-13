extends Control

#Dictionar care contine denumirile tuturor butoanelor din aplicatie
var btn_denumiri = {
	"meniu": ["Cuvinte", "Expresii","Formare propoziții", "Text->dactileme", "Setări aplicație", "Ieșire"],
	"categorii": ["Animale", "Culori", "Transport"],
	"Animale": [
		"Câine",
		"Papagal",
		"Pisică",
	],
	"Culori": [
		"Albastru",
		"Galben",
		"Roșu",
	],
	"Transport":[
		"Mașină",
		"Avion",
		"Autobuz",
		"Barca",
		"Bicicleta",
		"Motocicleta",
		"Tractor"
	],
}

var videoclipuri = {
		"Animale": {
			"Câine":"res://ResurseVideo/Animale/caine.webm",
			"Papagal":"res://ResurseVideo/Animale/papagal.webm",
			"Pisică":"res://ResurseVideo/Animale/pisica.webm",
		},
		"Culori": {
			"Albastru":"res://ResurseVideo/Culori/albastru.webm",
			"Galben":"res://ResurseVideo/Culori/galben.webm",
			"Roșu":"res://ResurseVideo/Culori/rosu.webm",
		},
		"Transport":{
			"Mașină":"res://ResurseVideo/Transport/masina.webm",
			"Avion":"res://ResurseVideo/Transport/avion.webm",
			"Autobuz":"res://ResurseVideo/Transport/autobuz.webm",
			"Barca":"res://ResurseVideo/Transport/barca.webm",
			"Bicicleta":"res://ResurseVideo/Transport/bicicleta.webm",
			"Motocicleta":"res://ResurseVideo/Transport/motocicleta.webm",
			"Tractor":"res://ResurseVideo/Transport/tractor.webm",
		},
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

#incarcare tema din folderul Tema
var tema = load("res://Tema/Tema.tres")

func _ready():
	creare_meniu_principal()
	creare_categorii_cuvinte()

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
		lista.add_child(b)
		b.text = btn
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
	if(btn_denumiri.has(tip)):
		get_node("Categorii").visible = false
		var categorie = load("res://Meniu/Cuvinte/Categorie.tscn")
		categorie = categorie.instance()
		add_child(categorie)
		categorie.get_node("Titlu/Text").text = tip
		
		var lista = categorie.get_node("ListaCuvinte/VBoxContainer")
		
		for btn in btn_denumiri[tip]:
			var b = Button.new()
			lista.add_child(b)
			b.text = btn
			b.size_flags_horizontal = SIZE_EXPAND_FILL
			b.connect("pressed", self, "creare_video", [tip, btn])
		
		categorie.get_node("ButonInapoi").connect("pressed", self, "stergere_lista_cuvinte")

func stergere_lista_cuvinte():
	get_node("Categorii").visible = true
	get_node("Categorie").queue_free()

func creare_video(categorie, cuvant):
	if(videoclipuri[categorie].has(cuvant)):
		get_node("Categorie").visible = false
		var fereastra_cuvant = load("res://Meniu/Cuvinte/Cuvant.tscn")
		fereastra_cuvant = fereastra_cuvant.instance()
		var video = load(videoclipuri[categorie][cuvant])
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

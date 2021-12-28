extends Control
class_name SelectorCuvinte

var categorii = Array()
var denumiri = Array()

func adaugare_cuvant(categorie, denumire):
	var font = preload("res://Tema/FontSusJos.tres")
	var aspect_btn_stergere = load("res://Tema/tema_btn_categorii.tres")
	var aspect_btn_sus = load("res://Tema/tema_btn_sus.tres")
	var aspect_btn_jos = load("res://Tema/tema_btn_jos.tres")
	#Numele categoriei și denumirea fiecarui cuvânt adăugat se rețin în 2 vectori
	categorii.append(categorie)
	denumiri.append(denumire)
	#Crearea obiectelor care formează un element din lista de cuvinte
	var linie = HSplitContainer.new()
	var linie_cuv = HSplitContainer.new()
	var btn_stergere = Button.new()
	var btn_sus = Button.new()
	var btn_jos = Button.new()
	var btn_mutare = VBoxContainer.new()
	var text = Label.new()
	#Referință la lista de cuvinte
	var lista = $Propozitie/VBoxContainer
	#Adăugarea elementelor vizuale
	btn_mutare.add_child(btn_sus)
	btn_mutare.add_child(btn_jos)
	linie.add_child(btn_mutare)
	linie.add_child(linie_cuv)
	linie_cuv.add_child(text)
	linie_cuv.add_child(btn_stergere)
	lista.add_child(linie)
	#Conectarea semnlalelor butoanelor
	btn_sus.connect("pressed", self, "mutare_cuvant_sus", [linie])
	btn_jos.connect("pressed", self, "mutare_cuvant_jos", [linie])
	btn_stergere.connect("pressed", self, "stergere_cuvant", [linie])
	
	text.text = denumire
	text.size_flags_horizontal = SIZE_EXPAND_FILL
	text.anchor_left = .05
	
	btn_sus.add_font_override("font", font)
	btn_sus.add_stylebox_override("normal", aspect_btn_sus)
	btn_sus.add_stylebox_override("pressed", aspect_btn_sus)
	btn_sus.add_stylebox_override("hover", aspect_btn_sus)
	btn_sus.size_flags_vertical = SIZE_EXPAND_FILL
	btn_sus.text = "  ▲  "
	
	btn_jos.add_font_override("font", font)
	btn_jos.add_stylebox_override("normal", aspect_btn_jos)
	btn_jos.add_stylebox_override("pressed", aspect_btn_jos)
	btn_jos.add_stylebox_override("hover", aspect_btn_jos)
	btn_jos.add_stylebox_override("focus", StyleBoxEmpty.new())
	btn_jos.size_flags_vertical = SIZE_EXPAND_FILL
	btn_jos.text = "  ▼  "
	
	btn_mutare.set("custom_constants/separation", -10)
	
	btn_stergere.text = " X "
	btn_stergere.add_stylebox_override("normal", aspect_btn_stergere)
	btn_stergere.add_stylebox_override("pressed", aspect_btn_stergere)
	btn_stergere.add_stylebox_override("hover", aspect_btn_stergere)
	btn_stergere.add_stylebox_override("focus", StyleBoxEmpty.new())
	
	linie.mouse_filter = Control.MOUSE_FILTER_PASS
	linie_cuv.mouse_filter = Control.MOUSE_FILTER_PASS
	lista.mouse_filter = Control.MOUSE_FILTER_PASS

func stergere_cuvant(linie):
	categorii.remove(linie.get_index())
	denumiri.remove(linie.get_index())
	linie.queue_free()

func mutare_cuvant_sus(linie):
	var prev_index = linie.get_index()
	$Propozitie/VBoxContainer.move_child(linie, linie.get_index()-1)
	var current_index = linie.get_index()
	
	if(prev_index!=current_index):
		var aux = categorii[prev_index]
		categorii[prev_index] = categorii[current_index]
		categorii[current_index] = aux
		
		aux = denumiri[prev_index]
		denumiri[prev_index] = denumiri[current_index]
		denumiri[current_index] = aux
	

func mutare_cuvant_jos(linie):
	var prev_index = linie.get_index()
	$Propozitie/VBoxContainer.move_child(linie, linie.get_index()+1)
	var current_index = linie.get_index()
	if(prev_index!=current_index):
		#Interschimbare categorii
		var aux = categorii[prev_index]
		categorii[prev_index] = categorii[current_index]
		categorii[current_index] = aux
		#Interschimbare denumiri
		aux = denumiri[prev_index]
		denumiri[prev_index] = denumiri[current_index]
		denumiri[current_index] = aux

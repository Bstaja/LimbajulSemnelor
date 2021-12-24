extends Control

var font = preload("res://Tema/FontSusJos.tres")
var categorii = Array()
var denumiri = Array()
var v_curent = 0
var v1 = null
var v2 = null

func _ready():
	$Start.connect("pressed", self, "redare_video")

func adaugare_cuvant(categorie, denumire):
	var aspect_butoane = load("res://Tema/tema_btn_categorii.tres")
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
	btn_sus.add_stylebox_override("normal", aspect_butoane)
	btn_sus.add_stylebox_override("pressed", aspect_butoane)
	btn_sus.add_stylebox_override("hover", aspect_butoane)
	btn_sus.add_stylebox_override("focus", StyleBoxEmpty.new())
	btn_sus.size_flags_vertical = SIZE_EXPAND_FILL
	btn_sus.text = " ▲ "
	
	btn_jos.add_font_override("font", font)
	btn_jos.add_stylebox_override("normal", aspect_butoane)
	btn_jos.add_stylebox_override("pressed", aspect_butoane)
	btn_jos.add_stylebox_override("hover", aspect_butoane)
	btn_jos.add_stylebox_override("focus", StyleBoxEmpty.new())
	btn_jos.size_flags_vertical = SIZE_EXPAND_FILL
	btn_jos.text = " ▼ "
	
	btn_mutare.set("custom_constants/separation", -10)
	
	btn_stergere.text = " X "
	btn_stergere.add_stylebox_override("normal", aspect_butoane)
	btn_stergere.add_stylebox_override("pressed", aspect_butoane)
	btn_stergere.add_stylebox_override("hover", aspect_butoane)
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
		
		print(categorii)
		print(denumiri)
	

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
		
		print(categorii)
		print(denumiri)

func redare_video():
	if ($Start.text == " X "):
		#Opriera videoclipurilor
		$Start.text = " ► "
		get_parent().stergere_lista_cuvinte()
		$Propozitie/VBoxContainer.get_child(v_curent-1).get_child(1).get_child(0).set("custom_colors/font_color", Color.white)
		v_curent = 0
		#Daca sunt videoclipuri de eliminat din memorie, se vor elimina
		if (v1!=null and !v1.is_queued_for_deletion()):
			v1.queue_free()
		if (v2!=null and !v2.is_queued_for_deletion()):
			v2.queue_free()
	else:
		#Pornirea videoclipurilor
		if (denumiri.size()>1):
			$Propozitie.scroll_vertical = 0
			$Start.text = " X "
			get_parent().incarcare_date(categorii[v_curent])
			v1 = get_parent().creare_video(categorii[v_curent], denumiri[v_curent])
			v_curent+=1
			get_parent().incarcare_date(categorii[v_curent])
			v2 = get_parent().creare_video(categorii[v_curent], denumiri[v_curent])
			v1.visible = true
			v1.get_node("Video/VideoPlayer").play()
			$Propozitie/VBoxContainer.get_child(0).get_child(1).get_child(0).set("custom_colors/font_color", Color.red)
			
			

func urmat_video():
	v1.queue_free()
	if (v2!=null):
		#Scroll automat în funcție de dimensiunea pe ecran a unui cuvânt din lista de cuvinte
		$Propozitie.scroll_vertical = $Propozitie/VBoxContainer.get_child(0).rect_size.y*v_curent
		v1 = v2
		v1.visible = true
		v1.get_node("Video/VideoPlayer").play()
		$Propozitie/VBoxContainer.get_child(v_curent-1).get_child(1).get_child(0).set("custom_colors/font_color", Color.white)
		$Propozitie/VBoxContainer.get_child(v_curent).get_child(1).get_child(0).set("custom_colors/font_color", Color.red)
		v_curent+=1
		if (v_curent<denumiri.size()):
			get_parent().incarcare_date(categorii[v_curent])
			v2 = get_parent().creare_video(categorii[v_curent], denumiri[v_curent])
		else:
			v2 = null
	else:
		redare_video()
	print(v_curent)

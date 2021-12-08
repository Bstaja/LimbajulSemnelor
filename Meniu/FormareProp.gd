extends Control

func adaugare_cuvant(categorie, denumire):
	
	var linie = HSplitContainer.new()
	var btn_stergere = Button.new()
	var text = Label.new()
	var lista = $Propozitie/VBoxContainer
	
	text.text = denumire
	text.size_flags_horizontal = SIZE_EXPAND_FILL
	text.anchor_left = .05
	
	btn_stergere.text = " X "
	btn_stergere.connect("pressed", self, "stergere_cuvant", [linie])
	
	linie.add_child(text)
	linie.add_child(btn_stergere)
	linie.mouse_filter = Control.MOUSE_FILTER_PASS
	
	lista.add_child(linie)
	lista.mouse_filter = Control.MOUSE_FILTER_PASS

func stergere_cuvant(linie):
	linie.queue_free()

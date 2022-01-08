extends SelectorCuvinte


var v_curent = 0
var v1 = null
var v2 = null

func _ready():
	$Start.connect("pressed", self, "redare_video")



func redare_video():
	if ($Start.text == " X "):
		#Opriera videoclipurilor
		$Start.text = " ► "
		if (get_parent().has_node("Categorie")):
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

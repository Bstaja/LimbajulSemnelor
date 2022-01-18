extends Control

#Viteza normala: o litera la fiecare 0.5 secunde
var viteza_normala = .5
#Viteza curenta (procent)
var viteza = 1.0
#Variabila care retine textul introdus
var text:String
var alfabet = "AĂÂBCDEFGHIÎJKLMNOPQRSȘTȚUVWXYZ"
var alfabet_mic = "aăâbcdefghiîjklmnopqrsștțuvwxyz"
var animatie = Animation.new()


func _ready():
	$AnimationPlayer.add_animation("RedareDactileme", animatie)
	$CasetaText/HSplitContainer/Text.placeholder_text = "Introduceți textul aici"
	

func _on_Buton_pressed():
	#Stergerea animatiei anterioare
	animatie.clear()
	#adaugarea trackurilor
	var litera_curenta = animatie.add_track(Animation.TYPE_METHOD)
	var dactileme = animatie.add_track(Animation.TYPE_VALUE)
	#Setarea valorii modificate de fiecare track
	animatie.track_set_path(litera_curenta, ".")
	animatie.track_set_path(dactileme, "Dactileme:frame")
	#Setarea tipului de interpolare
	animatie.track_set_interpolation_type(dactileme, animatie.INTERPOLATION_NEAREST)
	animatie.track_set_interpolation_type(litera_curenta, animatie.INTERPOLATION_NEAREST)
	
	#Se preia textul introdus de utilizator
	text = $CasetaText/HSplitContainer/Text.text
	text = text.to_lower()
	var nr = 0
	#Literele invalide din text care vor fi sterse
	var de_sters = ""
	#Se formeaza un string cu literele care trebuie sterse
	for l in text:
		var aux = alfabet_mic.find(l)
		#daca litera nu se ragaseste in alfabet
		if (aux == -1 and de_sters.find(l)==-1):
			de_sters+=l
	#Se parcuge string-ul de_sters litera cu litera si
	#Se elimina caracterele invalide
	for l in de_sters:
		text = text.replace(l, "")
	
	for l in text:
		var aux = alfabet_mic.find(l)
		text[nr] = alfabet[aux]
		nr+=1
		
	var t = 0.0
	for i in text:
		var litera = alfabet.find(i)
		#Se inserează un key la momentul t cu locatia literei corespunzatoare in imagine
		animatie.track_insert_key(dactileme, t, litera)
		#Se inserează un key la momentul t care apeleaza functia setare_litera_curenta
		animatie.track_insert_key(litera_curenta, t, {"method":"setare_litera_curenta", "args":[]})
		#Se trece la urmatorul moment t
		t+=viteza_normala
	#Se seteaza durata animatiei
	animatie.length = t-viteza_normala
	#Incepe redarea animatiei de la momentul 0
	$AnimationPlayer.play("RedareDactileme", -1, viteza)
	$AnimationPlayer.seek(0.0)

func setare_litera_curenta():
	var index = int($AnimationPlayer.current_animation_position/viteza_normala)+1
	var text_procesat = text
	text_procesat = text_procesat.insert(index-1, "0")
	text_procesat = text_procesat.insert(index+1, "0")
	text_procesat = text_procesat.split("0")
	$LiteraCurenta/VSplitContainer/Text.bbcode_text = "[center]"+text_procesat[0]+"[color=red]"+text_procesat[1]+"[/color]"+text_procesat[2]+"[/center]"
	#$LiteraCurenta/HSplitContainer/Text.text = alfabet[$Dactileme.frame]

#Animatie catre litera precedenta
func _on_LiteraPrecedenta_pressed():
	#Pune animatia pe pauza
	$AnimationPlayer.stop(false)
	#Deruleaza animatia inapoi cu un pas
	$AnimationPlayer.advance(-viteza_normala)
#Animatie catre litera urmatoare
func _on_LiteraUrmatoare_pressed():
	$AnimationPlayer.stop(false)
	#Daca animatia nu e la final
	if ($AnimationPlayer.current_animation_position<$AnimationPlayer.current_animation_length):
		#Deruleaza animatia inainte cu un pas
		$AnimationPlayer.advance(viteza_normala)


func _on_Text_text_entered(new_text):
	_on_Buton_pressed()
	$CasetaText/HSplitContainer/Text.release_focus()

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
	
	animatie.clear()
	var litera_curenta = animatie.add_track(Animation.TYPE_METHOD)
	var dactileme = animatie.add_track(Animation.TYPE_VALUE)
	animatie.track_set_path(litera_curenta, ".")
	animatie.track_set_path(dactileme, "Dactileme:frame")
	animatie.track_set_interpolation_type(dactileme, animatie.INTERPOLATION_NEAREST)
	animatie.track_set_interpolation_type(litera_curenta, animatie.INTERPOLATION_NEAREST)
	
	text = $CasetaText/HSplitContainer/Text.text
	text = text.to_lower()
	var nr = 0
	#Literele invalide din text care vor fi sterse
	var de_sters = ""
	
	for l in text:
		var aux = alfabet_mic.find(l)
		if (aux == -1 and de_sters.find(l)==-1):
			de_sters+=l
	
	for l in de_sters:
		text = text.replace(l, "")
	
	for l in text:
		var aux = alfabet_mic.find(l)
		text[nr] = alfabet[aux]
		nr+=1
	var t = 0.0
	
	for i in text:
		var litera = alfabet.find(i)
		animatie.track_insert_key(dactileme, t, litera)
		animatie.track_insert_key(litera_curenta, t, {"method":"setare_litera_curenta", "args":[]})
		t+=viteza_normala
	
	animatie.length = t-viteza_normala
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


func _on_LiteraPrecedenta_pressed():
	print($AnimationPlayer.current_animation_position)
	$AnimationPlayer.stop(false)
	$AnimationPlayer.advance(-viteza_normala)

func _on_LiteraUrmatoare_pressed():
	$AnimationPlayer.stop(false)
	print($AnimationPlayer.current_animation_position)
	if ($AnimationPlayer.current_animation_position<$AnimationPlayer.current_animation_length):
		$AnimationPlayer.advance(viteza_normala)


func _on_Text_text_entered(new_text):
	_on_Buton_pressed()
	$Denumire.grab_focus()
	$CasetaText/HSplitContainer/Text.text = ""

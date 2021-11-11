extends Control

#Viteza normala: o litera la fiecare 0.5 secunde
var viteza_normala = .5
#Viteza curenta (procent)
var viteza = 1.0
#Variabila care retine textul introdus
var text
var alfabet = "AĂÂBCDEFGHIÎJKLMNOPQRSȘTȚUVWXYZ"
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
	text = text.to_upper()
	var t = 0.0
	
	for i in text:
		var litera = alfabet.find(i)
		if (alfabet.find(i)!=-1):
			animatie.track_insert_key(dactileme, t, litera)
			animatie.track_insert_key(litera_curenta, t, {"method":"setare_litera_curenta", "args":[]})
			t+=viteza_normala
	
	animatie.length = t+viteza_normala
	$AnimationPlayer.play("RedareDactileme", -1, viteza)
	$AnimationPlayer.seek(0.0)

func setare_litera_curenta():
	$LiteraCurenta/Text.text = alfabet[$Dactileme.frame]

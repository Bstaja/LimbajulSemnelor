extends Control

func _ready():
	$CasetaText/Text.placeholder_text = "Scrie aici numele categoriei..."
	$SelectareCuvinte/OK.connect("pressed", self, "ascunde_meniu_adaugare_cuvinte")
	$ButonAdaugare.connect("pressed", self, "afisare_meniu_adaugare_cuvinte")
	$OptiuneSortare/Buton.connect("pressed", self, "sortare_alfabetica")


func afisare_meniu_adaugare_cuvinte():
	$SelectareCuvinte.anchor_top = 0
	$SelectareCuvinte.anchor_bottom = 1
	anchor_bottom = .5
	$ButonAdaugare.visible = false
	$SelectareCuvinte/OK.visible = true
	get_parent().buton_back_oprit = true
	
func ascunde_meniu_adaugare_cuvinte():
	$SelectareCuvinte.anchor_top = .3
	$SelectareCuvinte.anchor_bottom = .9
	anchor_bottom = 1
	$ButonAdaugare.visible = true
	$SelectareCuvinte/OK.visible = false
	var lista = get_parent().get_node_or_null("Categorie")
	if (lista!=null):
		lista.queue_free()
		get_parent().get_node("Categorii").visible = true
	get_parent().buton_back_oprit = false

func sortare_alfabetica():
	if ($OptiuneSortare/Buton.text == " Da "):
		$OptiuneSortare/Buton.text = " Nu "
	else:
		$OptiuneSortare/Buton.text = " Da "

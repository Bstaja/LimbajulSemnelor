extends Control

var sterge_categ = null
var sterge_obiect = null



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


func salveaza_categ_noua():
	if (sterge_categ!=null):
		get_parent().sterge_categorie(sterge_categ, sterge_obiect)
	var date = {}
	var fisier = File.new()
	
	date["denumire"] = $CasetaText/Text.text
	date["cuvinte"] = []
	date["locatii"] = []
	date["alfabetic"] = false
	
	var i = 0
	while(fisier.file_exists("user://Categorii/"+str(i)+".data")):
		i+=1
	fisier.open("user://Categorii/"+str(i)+".data", File.WRITE)
	
	date["cuvinte"].append_array($SelectareCuvinte.denumiri)
	date["locatii"].append_array(incarca_locatii($SelectareCuvinte.categorii, $SelectareCuvinte.denumiri))
	
	if ($OptiuneSortare/Buton.text == " Da "):
		date["alfabetic"] = true
	
	if (date["denumire"]!="" and date["cuvinte"].size()>0):
		fisier.store_var(date, true)
	
	fisier.close()
	
	get_parent().btn_denumiri["categorii"].append(date["denumire"])
	get_parent().categorii_utilizator.append(date["denumire"])
	get_parent().dictionar[date["denumire"]] = str(i)+".data"
	get_parent().nume_fisiere.append(str(i)+".data")
	if (date["alfabetic"]==false):
		get_parent().categorii_nesortate.append(date["denumire"])
	
	get_parent().get_node("Categorii").free()
	get_parent().creare_categorii_cuvinte()
	get_parent().get_node("Categorii").visible = true
	
	get_parent().ascunde_creare_categ()
	
	
func incarca_locatii(categorii, cuvinte):
	var categ_precedenta = categorii[0]
	var locatii = []
	get_parent().incarcare_date(categorii[0])
	
	for i in range(categorii.size()):
		var c = categorii[i]
		if (c != categ_precedenta):
			categ_precedenta = c
			get_parent().incarcare_date(c)
			
		locatii.append(get_parent().date_curente.folder+"/"+get_parent().date_curente.locatii[Array(get_parent().date_curente.cuvinte).find(cuvinte[i])])
	return locatii

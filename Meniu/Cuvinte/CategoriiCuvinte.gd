extends Control

var de_inlocuit = "aăâîșț"
var inlocuit_cu = "aaaist"

class Sortare:
	static func sort(a, b):
		if (a[2]>b[2]):
			return true
		return false

func cautare(cuvant:String):
	cuvant = cuvant.to_lower()
	for j in range(de_inlocuit.length()):
		cuvant = cuvant.replace(de_inlocuit[j], inlocuit_cu[j])
	var categorii = get_parent().dictionar
	var cuv_gasite = []
	for i in categorii:
		if (!categorii[i].ends_with(".data")):
			var date = load("res://Dictionar/"+categorii[i]+".tres")
			for k in range(date.cuvinte.size()):
				var de_comparat = date.cuvinte[k].to_lower()
				
				for j in range(de_inlocuit.length()):
					de_comparat = de_comparat.replace(de_inlocuit[j], inlocuit_cu[j])
				
				var similaritate = cuvant.similarity(de_comparat)
				if (similaritate>.5 or de_comparat.find(cuvant)>-1):
					cuv_gasite.append([date.cuvinte[k], date.folder+"/"+date.locatii[k], similaritate])
	cuv_gasite.sort_custom(Sortare, "sort")
	return cuv_gasite


func text_cautare_schimbat(new_text):
	$CasetaCautare/Text.virtual_keyboard_enabled = false
	if (new_text.length()>=2):
		var cuv = cautare(new_text)
		var date = {}
		var fisier = File.new()
		
		date["denumire"] = "Cuvinte găsite"
		date["cuvinte"] = []
		date["locatii"] = []
		date["alfabetic"] = false
		
		fisier.open("user://Categorii/temp.data", File.WRITE)
		
		for i in cuv:
			date["cuvinte"].append(i[0])
			date["locatii"].append(i[1])
		
		fisier.store_var(date, true)
		fisier.close()
		get_parent().dictionar["Cuvinte găsite"] = "temp.data"
		if (get_parent().has_node("Categorie")):
			get_parent().stergere_lista_cuvinte()
		get_parent().creare_lista_cuvinte("Cuvinte găsite")
		visible = true
		
		var lista = get_parent().get_node("Categorie")
		lista.get_node("Titlu").visible = false
		lista.get_node("ButonInapoi").visible = false
		lista.get_node("ListaCuvinte").anchor_top = 0
		lista.get_node("ListaCuvinte/VBoxContainer").size_flags_vertical = SIZE_EXPAND
		if (!get_parent().lista_mica):
			lista.anchor_top = .18
		else:
			lista.margin_top = $CasetaCautare.rect_size.y-1
	else:
		if (get_parent().has_node("Categorie")):
			get_parent().stergere_lista_cuvinte()
	$CasetaCautare/Text.grab_focus()
	$CasetaCautare/Text.virtual_keyboard_enabled = true

func _on_Text_focus_entered():
	$CasetaCautare/Text.virtual_keyboard_enabled = true

func _on_Text_text_entered(new_text):
	$CasetaCautare/Text.release_focus()

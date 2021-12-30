extends Node

var fisiere = []

func _ready():
	var dir = Directory.new()
	if dir.open("res://Dictionar") == OK:
		dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if (file_name.length()>2):
			fisiere.append(file_name)
		file_name = dir.get_next()
	
	fisiere.erase("cuvinte.gd")
	
	print("Fisiere cu probleme:\n")
	
	for i in fisiere:
		var cat = load("res://Dictionar/"+i)
		var cale = "res://ResurseVideo/"
		for k in cat.locatii:
			var f = cale + cat.folder + "/" + k + ".webm"
			if (!dir.file_exists(f)):
				print(f)

extends Control

var nr = 0

func _ready():
	$ListaButoane/VBoxContainer/Button.connect("pressed", self, "sterge_date")

func sterge_date():
	if (nr==0):
		nr+=1
	else:
		var dir = Directory.new()
		if (dir.dir_exists("user://Categorii")):
			dir.open("user://Categorii")
			dir.list_dir_begin()
			var fisiere = []
			var file_name = dir.get_next()
			while file_name != "":
				if (file_name.length()>2):
					fisiere.append(file_name)
				file_name = dir.get_next()
			for i in fisiere:
				dir.remove("user://Categorii/"+i)
			dir.remove("user://Categorii")
			get_tree().change_scene_to(load("res://Main.tscn"))

tool
extends RichTextEffect
class_name ColorareLitera

var bbcode = "colorare"

func _process_custom_fx(char_fx):
	var index = char_fx.env.get("index")
	#print(index)
	if (char_fx.relative_index == index):
		char_fx.color = Color.red

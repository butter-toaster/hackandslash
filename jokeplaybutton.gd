extends Button


func _on_pressed() -> void:
	if self.name == "jokeplaybutton":
		get_tree().change_scene_to_file("res://bootlegscene.tscn")
	else:
		get_tree().change_scene_to_file("res://menu.tscn")
		

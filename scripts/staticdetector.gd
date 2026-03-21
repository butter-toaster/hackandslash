extends Panel


func _on_mouse_exited() -> void:
	%staticsfx.volume_db = -80
	
	var stattween = create_tween()
	stattween.tween_property(%static, "modulate", Color("ffffff00"), 0.3)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		%staticsfx.volume_db = 0
		%static.modulate = Color("ffffff1a")

func _process(_delta: float) -> void:
	var top_node = get_tree().root.get_viewport().gui_get_hovered_control()
	if top_node == self:
		%staticsfx.volume_db = 0
		%static.modulate = Color("ffffff1a")
